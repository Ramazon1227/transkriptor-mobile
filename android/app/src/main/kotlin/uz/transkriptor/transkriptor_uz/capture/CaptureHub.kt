package uz.transkriptor.transkriptor_uz.capture

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

/**
 * Where the screen-audio service and the Flutter channel meet. They live
 * in one process but are created independently: the service outlives the
 * Flutter engine when the app is swiped away, and a new engine finds the
 * running session here.
 */
object CaptureHub {
    private val main = Handler(Looper.getMainLooper())

    /** Set while Dart listens to the event channel. Main thread only. */
    var events: EventChannel.EventSink? = null

    /** The running screen-audio session, if any. Main thread only. */
    var service: ScreenAudioService? = null

    /** Answers the pending `screen.start` call: null = started, else an error code. */
    var onStarted: ((String?) -> Unit)? = null

    fun started(errorCode: String?) = main.post {
        val callback = onStarted
        onStarted = null
        callback?.invoke(errorCode)
    }

    fun emit(event: Map<String, Any?>) = main.post { events?.success(event) }

    fun onMain(block: () -> Unit) {
        main.post(block)
    }
}

/** Error codes shared with the Dart side (`ScreenAudioSource`). */
object CaptureErrors {
    const val UNSUPPORTED = "UNSUPPORTED"
    const val CONSENT_DENIED = "CONSENT_DENIED"
    const val MIC_PERMISSION = "MIC_PERMISSION"
    const val CAPTURE_FAILED = "CAPTURE_FAILED"
    const val BUSY = "BUSY"
    const val NOT_RUNNING = "NOT_RUNNING"
    const val STORAGE = "STORAGE"
}
