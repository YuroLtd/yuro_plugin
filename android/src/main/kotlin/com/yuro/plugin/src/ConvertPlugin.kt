package com.yuro.plugin.src

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class ConvertPlugin {
    fun convertHeif(call: MethodCall, result: MethodChannel.Result) {
        try {
            val heifPath = call.arguments as String
            val newFile = File("${heifPath.substringBeforeLast(".")}.jpg").apply { createNewFile() }
            val bitmap = BitmapFactory.decodeFile(heifPath)
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, FileOutputStream(newFile))
            bitmap.recycle()
            result.success(newFile.path)
        } catch (e: Exception) {
            result.success(null)
        }
    }
}