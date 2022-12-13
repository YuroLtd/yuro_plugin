package com.yuro.yuro_plugin.plugins

import com.yuro.yuro_plugin.utils.md5
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

object UtilPlugin {
    /**
     * 获取文件的md5
     */
    fun getFileMd5(call: MethodCall, result: MethodChannel.Result) {
        try {
            val filePath = call.arguments<String>()!!
            val fileMd5 = File(filePath).md5()
            result.success(fileMd5)
        } catch (e: Exception) {
            result.success(null)
        }
    }
}