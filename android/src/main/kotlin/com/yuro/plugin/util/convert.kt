package com.yuro.plugin.util

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import java.io.File
import java.io.FileInputStream
import java.security.MessageDigest

/**
 * ByteArray转换成16进制字符串
 */
fun ByteArray.toHex(): String {
    val result = StringBuilder()
    forEach {
        result.append(Character.forDigit((it.toInt() shr 4) and 0xF, 16))
        result.append(Character.forDigit(it.toInt() and 0xF, 16))
    }
    return result.toString()
}

fun String.hexToByteArray(): ByteArray {
    val data = ByteArray(length / 2)
    for (i in 0 until length step 2) {
        data[i / 2] = ((Character.digit(this[i], 16) shl 4) + Character.digit(this[i + 1], 16)).toByte()
    }
    return data
}

fun File.md5(): String {
    val digest = MessageDigest.getInstance("MD5")
    val bytes = ByteArray(2048)
    val fis = FileInputStream(this)
    var len: Int
    while (fis.read(bytes, 0, bytes.size).also { len = it } != -1) {
        digest.update(bytes, 0, len)
    }
    fis.close()
    return digest.digest().toHex()
}

fun File.getUri(context: Context): Uri {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        FileProvider.getUriForFile(context, "${context.packageName}.fileProvider", this)
    } else {
        Uri.fromFile(this)
    }
}