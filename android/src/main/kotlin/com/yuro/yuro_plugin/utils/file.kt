package com.yuro.yuro_plugin.utils

import java.io.File
import java.io.FileInputStream
import java.security.MessageDigest

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