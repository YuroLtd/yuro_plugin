package com.yuro.yuro_plugin.util

enum class ErrorCode(value: Int) {
    APK_NOT_EXISTS(-100),
    NOT_APK_FILE(-101),
    APK_MD5_NOT_MATCH(-102),
}