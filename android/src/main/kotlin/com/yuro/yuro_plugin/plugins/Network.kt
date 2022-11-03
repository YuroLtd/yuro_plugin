package com.yuro.yuro_plugin.plugins

import android.content.Context
import android.net.*
import android.net.Network
import android.os.Build
import com.yuro.yuro_plugin.YuroPlugin
import kotlin.concurrent.thread

object Network {
    private lateinit var connectivityManager: ConnectivityManager
    var networkType = NetworkType.NONE
    var linkAddress = listOf<String>()

    fun registerNetworkCallback(context: Context) {
        connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            connectivityManager.registerDefaultNetworkCallback(networkCallback)
        } else {
            connectivityManager.registerNetworkCallback(NetworkRequest.Builder().build(), networkCallback)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork
            thread {
                connectivityManager.getNetworkCapabilities(network)?.let { checkNetworkCapabilities(it) }
                connectivityManager.getLinkProperties(network)?.let { checkLinkProperties(it) }
                reportStatus()
            }
        }
    }


    fun unregisterNetworkCallback() {
        connectivityManager.unregisterNetworkCallback(networkCallback)
    }

    private fun checkNetworkCapabilities(networkCapabilities: NetworkCapabilities) {
        if (networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED)) {
            networkType = if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                NetworkType.WIFI
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI_AWARE)) {
                NetworkType.WIFI_AWARE
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
                NetworkType.CELLULAR
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH)) {
                NetworkType.BLUETOOTH
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                NetworkType.ETHERNET
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_USB)) {
                NetworkType.USB
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN)) {
                NetworkType.VPN
            } else if (networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_LOWPAN)) {
                NetworkType.LOWPAN
            } else {
                NetworkType.NONE
            }
        }
    }

    private fun checkLinkProperties(linkProperties: LinkProperties) {
        this.linkAddress = linkProperties.linkAddresses.map { it.address.hostName }.toList()
    }

    private fun reportStatus() {
        YuroPlugin.handler?.obtainMessage(YuroPlugin.HANDLER_NETWORK_STATUS, networkType.code, 0, linkAddress)
            ?.sendToTarget()
    }

    private val networkCallback = object : ConnectivityManager.NetworkCallback() {

        override fun onLost(network: Network) {
            super.onLost(network)
            networkType = NetworkType.NONE
            linkAddress = listOf()
            reportStatus()
        }

        override fun onCapabilitiesChanged(network: Network, networkCapabilities: NetworkCapabilities) {
            super.onCapabilitiesChanged(network, networkCapabilities)
            checkNetworkCapabilities(networkCapabilities)
            reportStatus()
        }

        override fun onLinkPropertiesChanged(network: Network, linkProperties: LinkProperties) {
            super.onLinkPropertiesChanged(network, linkProperties)
            checkLinkProperties(linkProperties)
            reportStatus()
        }
    }

    enum class NetworkType(val code: Int) {
        CELLULAR(0),
        WIFI(1),
        BLUETOOTH(2),
        ETHERNET(3),
        VPN(4),
        WIFI_AWARE(5),
        LOWPAN(6),
        USB(8),
        NONE(-1),
    }
}