package uz.transkriptor.transkriptor_uz.capture

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaMetadataRetriever
import android.media.projection.MediaProjectionConfig
import android.media.projection.MediaProjectionManager
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

/**
 * `uz.transkriptor/capture` (methods) and `uz.transkriptor/capture/screen`
 * (events). The Dart side is `lib/features/recorder/infrastructure/native/`
 * and `lib/features/capture/infrastructure/`.
 */
class CaptureChannel(
    private val activity: Activity,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler {
    companion object {
        const val METHODS = "uz.transkriptor/capture"
        const val EVENTS = "uz.transkriptor/capture/screen"
        private const val REQUEST_PROJECTION = 4201
        private const val REQUEST_NOTIFICATIONS = 4202
    }

    private val methods = MethodChannel(messenger, METHODS)
    private val events = EventChannel(messenger, EVENTS)
    private val io = Executors.newSingleThreadExecutor()

    /** The `screen.start` call waiting for consent and the service. */
    private var pendingStart: MethodChannel.Result? = null
    private var pendingPath: String = ""
    private var pendingMic: Boolean = false
    private var pendingNotifications: MethodChannel.Result? = null

    init {
        methods.setMethodCallHandler(this)
        events.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                CaptureHub.events = sink
            }

            override fun onCancel(arguments: Any?) {
                CaptureHub.events = null
            }
        })
    }

    fun dispose() {
        methods.setMethodCallHandler(null)
        events.setStreamHandler(null)
        CaptureHub.events = null
        CaptureHub.onStarted = null
        io.shutdown()
        // The engine dies with the activity, and the `record` plugin's
        // recorder with it: nothing is left for the keep-alive to protect.
        MicRecordingService.stop(activity)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "mic.startService" -> runCatching { MicRecordingService.start(activity) }
                .fold({ result.success(true) }, { result.error(CaptureErrors.CAPTURE_FAILED, it.message, null) })
            "mic.stopService" -> {
                MicRecordingService.stop(activity)
                result.success(null)
            }
            "notifications.request" -> requestNotifications(result)
            "screen.isSupported" -> result.success(Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
            "screen.start" -> startScreen(call, result)
            "screen.stop" -> finishScreen(cancel = false, result)
            "screen.cancel" -> finishScreen(cancel = true, result)
            "screen.status" -> {
                val s = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) CaptureHub.service else null
                result.success(
                    s?.let { mapOf("path" to it.path, "elapsedMs" to it.elapsedMs, "withMic" to it.withMic) },
                )
            }
            "file.finalize" -> {
                val src = call.argument<String>("src")
                val dst = call.argument<String>("dst")
                if (src == null || dst == null) {
                    result.error(CaptureErrors.STORAGE, "src and dst are required", null)
                    return
                }
                io.execute {
                    val outcome = runCatching { Adts.remux(File(src), File(dst)) }
                    CaptureHub.onMain {
                        outcome.fold(
                            { result.success(it) },
                            { result.error(CaptureErrors.STORAGE, it.message, null) },
                        )
                    }
                }
            }
            "file.durationMs" -> {
                val path = call.argument<String>("path")
                io.execute {
                    val ms = runCatching {
                        MediaMetadataRetriever().run {
                            try {
                                setDataSource(path)
                                extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)?.toLongOrNull()
                            } finally {
                                release()
                            }
                        }
                    }.getOrNull()
                    CaptureHub.onMain { result.success(ms) }
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun requestNotifications(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            activity.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED
        ) {
            result.success(true)
            return
        }
        if (pendingNotifications != null) {
            result.success(false)
            return
        }
        pendingNotifications = result
        activity.requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), REQUEST_NOTIFICATIONS)
    }

    private fun startScreen(call: MethodCall, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            result.error(CaptureErrors.UNSUPPORTED, "playback capture needs Android 10", null)
            return
        }
        if (CaptureHub.service != null || pendingStart != null) {
            result.error(CaptureErrors.BUSY, "a capture is already running", null)
            return
        }
        // Playback capture itself needs RECORD_AUDIO, with or without the mic.
        if (activity.checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            result.error(CaptureErrors.MIC_PERMISSION, "RECORD_AUDIO not granted", null)
            return
        }
        val path = call.argument<String>("path")
        if (path.isNullOrEmpty()) {
            result.error(CaptureErrors.STORAGE, "path is required", null)
            return
        }
        pendingStart = result
        pendingPath = path
        pendingMic = call.argument<Boolean>("withMic") ?: false
        val manager = activity.getSystemService(MediaProjectionManager::class.java)
        val intent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            // Whole display: "share one app" would hide everything else's audio.
            manager.createScreenCaptureIntent(MediaProjectionConfig.createConfigForDefaultDisplay())
        } else {
            manager.createScreenCaptureIntent()
        }
        try {
            @Suppress("DEPRECATION")
            activity.startActivityForResult(intent, REQUEST_PROJECTION)
        } catch (e: Exception) {
            pendingStart = null
            result.error(CaptureErrors.UNSUPPORTED, e.message, null)
        }
    }

    private fun finishScreen(cancel: Boolean, result: MethodChannel.Result) {
        val s = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) CaptureHub.service else null
        if (s == null) {
            result.error(CaptureErrors.NOT_RUNNING, "no capture is running", null)
            return
        }
        s.finish(cancel = cancel, external = false) { done ->
            if (cancel || done != null) {
                result.success(done)
            } else {
                result.error(CaptureErrors.STORAGE, "nothing was recorded", null)
            }
        }
    }

    /** From MainActivity. True when the request was ours. */
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != REQUEST_PROJECTION) return false
        val result = pendingStart ?: return true
        if (resultCode != Activity.RESULT_OK || data == null || Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            pendingStart = null
            result.error(CaptureErrors.CONSENT_DENIED, "screen capture was not allowed", null)
            return true
        }
        CaptureHub.onStarted = { error ->
            pendingStart = null
            if (error == null) result.success(null) else result.error(error, null, null)
        }
        try {
            ScreenAudioService.start(activity, resultCode, data, pendingPath, pendingMic)
        } catch (e: Exception) {
            CaptureHub.onStarted = null
            pendingStart = null
            result.error(CaptureErrors.CAPTURE_FAILED, e.message, null)
        }
        return true
    }

    /** From MainActivity. True when the request was ours. */
    fun onRequestPermissionsResult(requestCode: Int, grantResults: IntArray): Boolean {
        if (requestCode != REQUEST_NOTIFICATIONS) return false
        val result = pendingNotifications ?: return true
        pendingNotifications = null
        result.success(grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED)
        return true
    }
}
