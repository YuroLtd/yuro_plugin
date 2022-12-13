package com.yuro.yuro_plugin.utils

import com.google.gson.Gson
import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

inline fun <reified T : Any> String.jsonToList(): MutableList<T> =
    Gson().fromJson(this, object : ParameterizedType {
        override fun getRawType(): Type = MutableList::class.java

        override fun getOwnerType(): Type? = null

        override fun getActualTypeArguments(): Array<Type> = arrayOf(T::class.java)
    })