package com.yuro.yuro_plugin.src

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Build
import com.yuro.yuro_plugin.YuroPlugin
import com.yuro.yuro_plugin.util.ErrorCode
import com.yuro.yuro_plugin.util.getUri
import com.yuro.yuro_plugin.util.md5
import io.flutter.plugin.common.MethodCall
import java.io.File

object AppPlugin {
    fun installApk(activity: Activity?, call: MethodCall) {
        val filePath = call.argument<String>("filePath")!!
        val apkFile = File(filePath)
        if (apkFile.isDirectory || !apkFile.exists()) {
            YuroPlugin.sendError(ErrorCode.APK_NOT_EXISTS)
            return
        }
        if (!apkFile.path.endsWith(".apk")) {
            YuroPlugin.sendError(ErrorCode.NOT_APK_FILE)
            return
        }
        val fileMd5 = call.argument<String>("fileMd5")!!
        if (apkFile.md5() != fileMd5) {
            YuroPlugin.sendError(ErrorCode.APK_MD5_NOT_MATCH)
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