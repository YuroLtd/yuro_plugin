package com.yuro.yuro_plugin

import android.app.Activity
import android.content.Context
import android.util.Log
import com.yuro.yuro_plugin.plugins.SystemPlugin
import com.yuro.yuro_plugin.plugins.UtilPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** YuroPlugin */
@Suppress("unused")
class YuroPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("YuroPlugin", "onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.yuro.plugin/android")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("YuroPlugin", "onDetachedFromEngine")
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(p0: ActivityPluginBinding) {
        activity = p0.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.d("YuroPlugin", "onMethodCall: ${call.method}")
        when (call.method) {
            "system/installApk" -> activity?.let { SystemPlugin.installApk(it, call) }
            "system/deviceInfo" -> SystemPlugin.deviceInfo(context, result)
            "system/recordLog" -> SystemPlugin.recordLog(context, result)
            "util/getFileMd5" -> UtilPlugin.getFileMd5(call, result)
            else -> result.notImplemented()
        }
    }
}
