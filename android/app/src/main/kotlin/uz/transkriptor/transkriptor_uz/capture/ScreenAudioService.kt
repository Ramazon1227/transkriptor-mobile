package uz.transkriptor.transkriptor_uz.capture

import android.app.Activity
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.annotation.RequiresApi
import uz.transkriptor.transkriptor_uz.R
import java.io.File

/**
 * Foreground service of type mediaProjection (plus microphone when the
 * microphone is mixed in) that owns one screen-audio capture.
 *
 * Android 14 order: the service is started and in the foreground
 * *before* `getMediaProjection`, and the consent result is used once.
 */
@RequiresApi(Build.VERSION_CODES.Q)
class ScreenAudioService : Service() {
    companion object {
        private const val TAG = "ScreenAudioService"
        private const val ACTION_START = "uz.transkriptor.capture.START"
        private const val ACTION_STOP = "uz.transkriptor.capture.STOP"
        private const val EXTRA_CODE = "code"
        private const val EXTRA_DATA = "data"
        private const val EXTRA_PATH = "path"
        private const val EXTRA_MIC = "mic"

        fun start(context: Context, resultCode: Int, data: Intent, path: String, withMic: Boolean) {
            val intent = Intent(context, ScreenAudioService::class.java)
                .setAction(ACTION_START)
                .putExtra(EXTRA_CODE, resultCode)
                .putExtra(EXTRA_DATA, data)
                .putExtra(EXTRA_PATH, path)
                .putExtra(EXTRA_MIC, withMic)
            context.startForegroundService(intent)
        }

        /** `foo.aac` → `foo.m4a`. */
        fun finalPath(aac: String): String =
            if (aac.endsWith(".aac")) aac.dropLast(4) + ".m4a" else "$aac.m4a"
    }

    private var projection: MediaProjection? = null
    private var capture: ScreenAudioCapture? = null
    private var finishing = false

    var path: String = ""
        private set
    var withMic: Boolean = false
        private set

    val elapsedMs: Long get() = capture?.elapsedMs ?: 0L

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> begin(intent)
            // The notification's stop button: keep what was recorded.
            ACTION_STOP -> finish(cancel = false, external = true) {}
            else -> stopSelf()
        }
        return START_NOT_STICKY
    }

    private fun begin(intent: Intent) {
        if (capture != null) {
            CaptureHub.started(CaptureErrors.BUSY)
            return
        }
        path = intent.getStringExtra(EXTRA_PATH).orEmpty()
        withMic = intent.getBooleanExtra(EXTRA_MIC, false)
        val code = intent.getIntExtra(EXTRA_CODE, Activity.RESULT_CANCELED)
        val data: Intent? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(EXTRA_DATA, Intent::class.java)
        } else {
            @Suppress("DEPRECATION")
            intent.getParcelableExtra(EXTRA_DATA)
        }

        val stop = PendingIntent.getService(
            this, 1,
            Intent(this, ScreenAudioService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
        val notification = CaptureNotifications.build(this, getString(R.string.capture_screen_title), stop)
        var type = ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION
        if (withMic) type = type or ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE
        try {
            startForeground(CaptureNotifications.SCREEN_ID, notification, type)
        } catch (e: Exception) {
            Log.w(TAG, "startForeground failed", e)
            fail(CaptureErrors.CAPTURE_FAILED)
            return
        }

        val manager = getSystemService(MediaProjectionManager::class.java)
        val mp = try {
            if (data == null || path.isEmpty()) null else manager.getMediaProjection(code, data)
        } catch (e: Exception) {
            Log.w(TAG, "getMediaProjection failed", e)
            null
        }
        if (mp == null) {
            fail(CaptureErrors.CAPTURE_FAILED)
            return
        }
        projection = mp
        // Required before use on Android 14; also how "stop sharing" in
        // the system UI reaches us.
        mp.registerCallback(object : MediaProjection.Callback() {
            override fun onStop() {
                finish(cancel = false, external = true) {}
            }
        }, Handler(Looper.getMainLooper()))

        val c = ScreenAudioCapture(
            projection = mp,
            withMic = withMic,
            out = File(path),
            onLevel = { level, elapsed ->
                CaptureHub.emit(mapOf("event" to "level", "level" to level, "elapsedMs" to elapsed))
            },
            onSilent = { CaptureHub.emit(mapOf("event" to "silent")) },
            onFailure = { e ->
                Log.w(TAG, "capture failed", e)
                CaptureHub.onMain {
                    finish(cancel = false, external = true, error = CaptureErrors.CAPTURE_FAILED) {}
                }
            },
        )
        try {
            c.start()
        } catch (e: Exception) {
            Log.w(TAG, "capture did not start", e)
            File(path).delete()
            fail(CaptureErrors.CAPTURE_FAILED)
            return
        }
        capture = c
        CaptureHub.service = this
        CaptureHub.started(null)
    }

    private fun fail(code: String) {
        CaptureHub.started(code)
        teardown()
    }

    /**
     * Stops the capture. With [cancel] the file is deleted; otherwise it is
     * remuxed to .m4a and [done] gets `{path, durationMs}` (the .aac path
     * if remuxing failed — it stays recoverable). [external] = not asked by
     * Dart, so Dart hears it as an `ended` event. Main thread.
     */
    fun finish(
        cancel: Boolean,
        external: Boolean,
        error: String? = null,
        done: (Map<String, Any?>?) -> Unit,
    ) {
        val c = capture
        if (c == null || finishing) {
            done(null)
            return
        }
        finishing = true
        Thread({
            c.stop()
            val aac = File(path)
            val result: Map<String, Any?>? = if (cancel) {
                aac.delete()
                null
            } else {
                try {
                    val m4a = File(finalPath(path))
                    val duration = Adts.remux(aac, m4a)
                    aac.delete()
                    mapOf("path" to m4a.path, "durationMs" to duration)
                } catch (e: Exception) {
                    Log.w(TAG, "remux failed; the .aac stays for recovery", e)
                    if (aac.exists() && aac.length() > 0) {
                        mapOf("path" to aac.path, "durationMs" to c.elapsedMs)
                    } else {
                        aac.delete()
                        null
                    }
                }
            }
            CaptureHub.onMain {
                capture = null
                teardown()
                if (external) {
                    CaptureHub.emit(
                        mapOf(
                            "event" to "ended",
                            "path" to result?.get("path"),
                            "durationMs" to result?.get("durationMs"),
                            "error" to (error ?: if (result == null) CaptureErrors.STORAGE else null),
                        ),
                    )
                }
                done(result)
            }
        }, "screen-audio-finish").start()
    }

    private fun teardown() {
        runCatching { projection?.stop() }
        projection = null
        if (CaptureHub.service === this) CaptureHub.service = null
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    override fun onDestroy() {
        capture?.let { c ->
            // Killed by the system without finish(): close the file so the
            // ADTS on disk stays recoverable.
            runCatching { c.stop() }
            capture = null
        }
        runCatching { projection?.stop() }
        if (CaptureHub.service === this) CaptureHub.service = null
        super.onDestroy()
    }
}
