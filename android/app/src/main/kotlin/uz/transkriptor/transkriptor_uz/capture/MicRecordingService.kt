package uz.transkriptor.transkriptor_uz.capture

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
        } catch (e: Exception) {
            // Android 12+/14 refuse it from the background or without
            // RECORD_AUDIO. Recording still works while the app is in front.
            Log.w("MicRecordingService", "startForeground refused", e)
            stopSelf()
        }
        // Not restarted after a kill: the recorder that needed it is gone too.
        return START_NOT_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        // Swiping the app away destroys the Flutter engine and with it the
        // recorder; an ongoing notification over nothing would be a lie.
        stopSelf()
    }

    companion object {
        fun start(context: Context) {
            val intent = Intent(context, MicRecordingService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, MicRecordingService::class.java))
        }
    }
}
