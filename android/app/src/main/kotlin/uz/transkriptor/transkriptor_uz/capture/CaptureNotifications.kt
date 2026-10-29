package uz.transkriptor.transkriptor_uz.capture

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import uz.transkriptor.transkriptor_uz.MainActivity
import uz.transkriptor.transkriptor_uz.R

/** The ongoing notification a recording foreground service must show. */
object CaptureNotifications {
    private const val CHANNEL_ID = "capture"
    const val MIC_ID = 4101
    const val SCREEN_ID = 4102

    private fun ensureChannel(context: Context) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager = context.getSystemService(NotificationManager::class.java)
        if (manager.getNotificationChannel(CHANNEL_ID) != null) return
        val channel = NotificationChannel(
            CHANNEL_ID,
            context.getString(R.string.capture_channel_name),
            // Low: visible and ongoing, but no sound every time a recording starts.
            NotificationManager.IMPORTANCE_LOW,
        ).apply { setShowBadge(false) }
        manager.createNotificationChannel(channel)
    }

    /** Tapping the notification brings the app back where it was. */
    private fun openApp(context: Context): PendingIntent {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_NEW_TASK
        }
        return PendingIntent.getActivity(
            context, 0, intent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
    }

    fun build(context: Context, title: String, stop: PendingIntent? = null): Notification {
        ensureChannel(context)
        @Suppress("DEPRECATION")
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(context, CHANNEL_ID)
        } else {
            Notification.Builder(context).setPriority(Notification.PRIORITY_LOW)
        }
        builder
            .setSmallIcon(R.drawable.ic_stat_recording)
            .setContentTitle(title)
            .setContentIntent(openApp(context))
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setShowWhen(true)
            .setUsesChronometer(true)
            .setCategory(Notification.CATEGORY_SERVICE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Shown at once, not after the 10 s grace Android 12+ allows.
            builder.setForegroundServiceBehavior(Notification.FOREGROUND_SERVICE_IMMEDIATE)
        }
        if (stop != null) {
            @Suppress("DEPRECATION")
            builder.addAction(
                Notification.Action.Builder(
                    null, context.getString(R.string.capture_stop), stop,
                ).build(),
            )
        }
        return builder.build()
    }
}
