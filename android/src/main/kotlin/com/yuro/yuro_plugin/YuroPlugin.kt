package com.yuro.yuro_plugin

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.util.Log
import com.yuro.yuro_plugin.plugins.NetworkPlugin
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
class YuroPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    companion object {
        const val HANDLER_NETWORK_STATUS = 1000

        var handler: MyHandler? = null
    }


    private lateinit var context: Context
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("YuroPlugin", "onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugins.yuro.com/yuro_android")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
        handler = MyHandler(channel)

        NetworkPlugin.registerNetworkCallback(context)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("YuroPlugin", "onDetachedFromEngine")
        channel.setMethodCallHandler(null)
        handler = null

        NetworkPlugin.unregisterNetworkCallback()
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

    class MyHandler(private val channel: MethodChannel) : Handler(Looper.getMainLooper()) {

        override fun handleMessage(msg: Message) {
            super.handleMessage(msg)
            when (msg.what) {
                HANDLER_NETWORK_STATUS -> {
                    channel.invokeMethod("networkStatus", mapOf("type" to msg.arg1, "linkAddress" to msg.obj))
                }
            }
        }
    }
}
