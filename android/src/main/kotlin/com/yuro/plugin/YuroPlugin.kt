package com.yuro.plugin

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import com.yuro.plugin.src.AppPlugin
import com.yuro.plugin.src.ConvertPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** YuroPlugin */
class YuroPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    companion object {
        private const val TAG = "YuroPlugin"
        private const val METHOD_CHANNEL = "plugin.yuro.com/method"
//        private const val EVENT_CHANNEL = "plugin.yuro.com/event"
    }

    private lateinit var methodChannel: MethodChannel
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onAttachedToEngine")
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onDetachedFromEngine")
        methodChannel.setMethodCallHandler(null)
    }


    override fun onAttachedToActivity(p0: ActivityPluginBinding) {
        activity = p0.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(TAG, "onMethodCall: ${call.method},${call.arguments}")
        when (call.method) {
            "app/appInfo" -> AppPlugin.appInfo(activity, result)
            "app/installApk" -> AppPlugin.installApk(activity, call, result)
            //
            "convert/heif" -> ConvertPlugin.convertHeif(call, result)
            else -> result.notImplemented()
        }
    }
}
