package com.yuro.plugin.util

enum class Tid {
    /**
     * App相关
     */
    APP,

    /**
     * 转换相关
     */
    CONVERT,
}

enum class Bid(val value: Int) {

}


enum class ErrorCode(val value: Int) {
    APK_NOT_EXISTS(-1000),
    NOT_APK_FILE(-1001),
    APK_MD5_NOT_MATCH(-1002),
}

