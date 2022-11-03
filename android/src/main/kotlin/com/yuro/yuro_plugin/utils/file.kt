package com.yuro.yuro_plugin.utils

import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import java.io.File

fun File.getUri(context: Context): Uri {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        FileProvider.getUriForFile(context, "${context.packageName}.fileProvider", this)
    } else {
        Uri.fromFile(this)
    }
}