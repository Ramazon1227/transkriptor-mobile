package uz.transkriptor.transkriptor_uz.capture

import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log
import uz.transkriptor.transkriptor_uz.R

/**
 * Keeps the process alive while the `record` plugin records the
 * microphone: with the screen off or the app in the background Android
 * would otherwise stop the microphone (9+) or kill the process. It records
 * nothing itself.
 *
 * Android 14: a microphone-type foreground service may only be started
 * while the app is visible and RECORD_AUDIO is granted — the Dart side
 * starts it right after the permission check, from the recorder screen.
 */
class MicRecordingService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val notification = CaptureNotifications.build(this, getString(R.string.capture_mic_title))
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                startForeground(
                    CaptureNotifications.MIC_ID,
                    notification,
                    ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE,
                )
            } else {
                startForeground(CaptureNotifications.MIC_ID, notification)
            }
            running = true
        } catch (e: Exception) {
            // Android 12+/14 refuse it from the background or without
            // RECORD_AUDIO. Recording still works while the app is in front.
            Log.w("MicRecordingService", "startForeground refused", e)
            stopSelf()
        }
        // Not restarted after a kill: the recorder that needed it is gone too.
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        running = false
        super.onDestroy()
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        // Swiping the app away destroys the Flutter engine and with it the
        // recorder; an ongoing notification over nothing would be a lie.
        stopSelf()
    }

    companion object {
        // Only a running service's notification may be replaced; a stale
        // «stopped» notification over no recording would be a lie.
        @Volatile private var running = false

        /**
         * MB-10: a call or another app took the microphone and the `record`
         * plugin paused. Same notification id, so it replaces the ongoing one.
         */
        fun setInterrupted(context: Context, interrupted: Boolean) {
            if (!running) return
            val notification = if (interrupted) {
                CaptureNotifications.build(
                    context,
                    context.getString(R.string.capture_mic_interrupted_title),
                    text = context.getString(R.string.capture_mic_interrupted_text),
                )
            } else {
                CaptureNotifications.build(context, context.getString(R.string.capture_mic_title))
            }
            val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            manager.notify(CaptureNotifications.MIC_ID, notification)
        }

        fun start(context: Context) {
            val intent = Intent(context, MicRecordingService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            // Now, not in onDestroy: a late setInterrupted must not post an
            // ongoing notification no service owns any more.
            running = false
            context.stopService(Intent(context, MicRecordingService::class.java))
        }
    }
}
