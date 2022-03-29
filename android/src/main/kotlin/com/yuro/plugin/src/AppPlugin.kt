package com.yuro.plugin.src

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.webkit.WebView
import com.yuro.plugin.YuroPlugin
import com.yuro.plugin.util.getUri
import com.yuro.plugin.util.md5
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

object AppPlugin {
    fun appInfo(context: Context, result: MethodChannel.Result) {
        val map = mutableMapOf<String, Any>()

        val pm: PackageManager = context.packageManager
        val info: PackageInfo = pm.getPackageInfo(context.packageName, 0)

        map["appName"] = info.applicationInfo.loadLabel(pm).toString()
        map["packageName"] = context.packageName
        map["versionName"] = info.versionName
        map["versionCode"] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) info.longVersionCode else info.versionCode
        map["androidId"] = Settings.System.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
        map["userAgent"] = WebView(context).settings.userAgentString
        result.success(map)
    }

    fun installApk(activity: Activity?, call: MethodCall, result: MethodChannel.Result) {
        val filePath = call.argument<String>("filePath")!!
        val apkFile = File(filePath)
        if (apkFile.isDirectory || !apkFile.exists()) {
            result.error("APK_NOT_EXISTS", "Apk文件不存在: $filePath", null)
            return
        }
        if (!apkFile.path.endsWith(".apk")) {
            result.error("FILE_TYPE_ERROR", "APK文件类型错误: ${apkFile.name}", null)
            return
        }
        val fileMd5 = call.argument<String>("fileMd5")!!
        if (apkFile.md5() != fileMd5) {
            result.error("APK_MD5_NOT_MATCH", "Apk的Md5不匹配,请重新下载", null);
            return
        }
        activity?.let {
            val intent = Intent(Intent.ACTION_VIEW).apply {
                flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    Intent.FLAG_GRANT_READ_URI_PERMISSION
                } else {
                    Intent.FLAG_ACTIVITY_NEW_TASK
                }
                setDataAndType(apkFile.getUri(it), "application/vnd.android.package-archive")
            }
            it.startActivity(intent)
        }
    }
}