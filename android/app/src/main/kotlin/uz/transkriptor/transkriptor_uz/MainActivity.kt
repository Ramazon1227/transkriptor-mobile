package uz.transkriptor.transkriptor_uz

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import uz.transkriptor.transkriptor_uz.capture.CaptureChannel

class MainActivity : FlutterActivity() {
    private var capture: CaptureChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        capture = CaptureChannel(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        capture?.dispose()
        capture = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    @Deprecated("FlutterActivity still routes plugin results through it")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (capture?.onActivityResult(requestCode, resultCode, data) == true) return
        @Suppress("DEPRECATION")
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        if (capture?.onRequestPermissionsResult(requestCode, grantResults) == true) return
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }
}
