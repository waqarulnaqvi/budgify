package com.mysteriouscoder.budgetflow


import android.app.AppOpsManager
import android.content.Context
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "exact_alarm_checker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isExactAlarmAllowed" -> result.success(isExactAlarmAllowed())
                    else -> result.notImplemented()
                }
            }
    }

    private fun isExactAlarmAllowed(): Boolean {
        // Before Android 12 → No exact alarm permission exists
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            return true
        }

        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager

        val mode = appOps.unsafeCheckOpNoThrow(
            "android:schedule_exact_alarm",
            android.os.Process.myUid(),
            packageName
        )

        return mode == AppOpsManager.MODE_ALLOWED
    }
}
