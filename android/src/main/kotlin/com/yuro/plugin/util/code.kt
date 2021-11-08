package com.yuro.plugin.util

enum class BusinessId(val value: Int)


enum class ErrorCode(val value: Int) {
    APK_NOT_EXISTS(-1000),
    NOT_APK_FILE(-1001),
    APK_MD5_NOT_MATCH(-1002),
}

