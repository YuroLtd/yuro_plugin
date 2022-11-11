package com.yuro.yuro_plugin.plugins

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.webkit.WebSettings
import androidx.core.content.FileProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.text.SimpleDateFormat
import java.util.*

object SystemPlugin {
    /**
     * 保存日志缓存
     */
    fun recordLog(context: Context, result: MethodChannel.Result) {
        val fileName = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.getDefault()).format(Date())
        val file = File(context.externalCacheDir, "$fileName.log")
        val getLog = arrayOf("logcat", "-d", "-f", file.absolutePath)
        Runtime.getRuntime().exec(getLog)
        result.success(file.absolutePath)
    }


    private fun isRoot(): Boolean {
        return try {
            File("/system/bin/su").exists() || File("/system/xbin/su").exists()
        } catch (e: Exception) {
            false
        }
    }

    /**
     * 获取设备信息
     */
    fun deviceInfo(context: Context, result: MethodChannel.Result) {
        val map = mapOf(
            // 品牌
            "brand" to Build.BRAND,
            // 型号
            "model" to Build.MODEL,
            // Android 版本
            "sdk" to "Android ${Build.VERSION.RELEASE}, level ${Build.VERSION.SDK_INT}",
            // ABIS
            "abis" to Build.SUPPORTED_ABIS.joinToString(),
            // user-agent
            "userAgent" to System.getProperty("http.agent"),
            // WebView user-agent
            "userAgent2" to WebSettings.getDefaultUserAgent(context),
            // 应用包名
            "packageName" to context.packageName,
            // android id
            "androidId" to Settings.System.getString(context.contentResolver, Settings.Secure.ANDROID_ID),
            // 是否获取root权限
            "isRoot" to isRoot(),
            // 网络连接地址
            "linkAddress" to NetworkPlugin.linkAddress,
            // 网络连接类型
            "networkType" to NetworkPlugin.networkType.code,
        )
        result.success(map)
    }


    /**
     * 安装应用
     */
    fun installApk(activity: Activity, call: MethodCall) {
        val filePath = call.arguments<String>()!!
        val intent = Intent(Intent.ACTION_VIEW).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
            val uri = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                FileProvider.getUriForFile(activity, "${activity.packageName}.fileProvider", File(filePath))
            } else {
                Uri.fromFile(File(filePath))
            }
            setDataAndType(uri, "application/vnd.android.package-archive")
        }
        activity.startActivity(intent)
    }
}