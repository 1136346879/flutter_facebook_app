package com.flutter.facebookapp

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.wifi.WifiManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import android.text.TextUtils
import java.net.Inet4Address
import java.net.NetworkInterface
import java.net.SocketException

/**
 * Created by kangf on 2018/7/13.
 */

object DevicesUtils {

    /**
     * 获取版本号
     */
    fun getVerCode(context: Context): Int {
        var verCode = -1
        try {
            @Suppress("DEPRECATION")
            verCode = context.packageManager.getPackageInfo(
                    "com.xfs.fsyuncai", 0).versionCode
        } catch (e: PackageManager.NameNotFoundException) {//
        }

        return verCode
    }
    /**
     * 获取版本号
     */
    fun getVerName(context: Context): String {
        var verName =""
        try {
            @Suppress("DEPRECATION")
            verName = context.packageManager.getPackageInfo(
                    "com.xfs.fsyuncai", 0).versionName
        } catch (e: PackageManager.NameNotFoundException) {//
        }

        return verName
    }
    /**
     * 获取设备唯一标识
     */
    @SuppressLint("HardwareIds")
    @Suppress("DEPRECATION")
    fun getIMEI(context: Context): String {
        val androidID = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
        return androidID + Build.SERIAL
    }

    /**
     * 获取application中指定的meta-data。本例中，调用方法时key就是UMENG_CHANNEL
     * @return 如果没有获取成功(没有对应值，或者异常)，则返回值为空
     */
    fun getAppMetaData(ctx: Context?, key: String): String? {
        if (ctx == null || TextUtils.isEmpty(key)) {
            return null
        }
        var resultData: String? = null
        try {
            val packageManager = ctx.packageManager
            if (packageManager != null) {
                val applicationInfo = packageManager.getApplicationInfo(ctx.packageName, PackageManager.GET_META_DATA)
                if (applicationInfo != null) {
                    if (applicationInfo.metaData != null) {
                        resultData = applicationInfo.metaData.getString(key)
                    }
                }
            }
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }

        return resultData
    }

    fun getMobileBrand(): String {
        return Build.BRAND
    }

    fun getOsVersion(): String {
        return Build.VERSION.RELEASE
    }


    /**
     * 获取当前的网络状态 ：没有网络-0：WIFI网络1：4G网络-4：3G网络-3：2G网络-2
     * 自定义
     *
     * @param context
     * @return
     */
    @Suppress("DEPRECATION")
    fun getAPNType(context: Context): String {
        //结果返回值
        var netType = ""
        //获取手机所有连接管理对象
        val manager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        //获取NetworkInfo对象
        val networkInfo = manager.activeNetworkInfo ?: return netType
        //NetworkInfo对象为空 则代表没有网络
        //否则 NetworkInfo对象不为空 则获取该networkInfo的类型
        val nType = networkInfo.type
        if (nType == ConnectivityManager.TYPE_WIFI) {
            //WIFI
            netType = "WIFI"
        } else if (nType == ConnectivityManager.TYPE_MOBILE) {
            val nSubType = networkInfo.subtype
            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            netType = if (nSubType == TelephonyManager.NETWORK_TYPE_LTE && !telephonyManager.isNetworkRoaming) {
                "4G"
            } else if (nSubType == TelephonyManager.NETWORK_TYPE_UMTS
                    || nSubType == TelephonyManager.NETWORK_TYPE_HSDPA
                    || nSubType == TelephonyManager.NETWORK_TYPE_EVDO_0 && !telephonyManager.isNetworkRoaming) {
                "3G"
            } else if (nSubType == TelephonyManager.NETWORK_TYPE_GPRS
                    || nSubType == TelephonyManager.NETWORK_TYPE_EDGE
                    || nSubType == TelephonyManager.NETWORK_TYPE_CDMA && !telephonyManager.isNetworkRoaming) {
                "2G"
            } else {
                "2G"
            }
        }
        return netType
    }


    @Suppress("DEPRECATION")
    fun getIpAddress(context: Context): String? {
        val info = (context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager).activeNetworkInfo
        if (info != null && info.isConnected) {
            // 3/4g网络
            when {
                info.type == ConnectivityManager.TYPE_MOBILE -> try {
                    val en = NetworkInterface.getNetworkInterfaces()
                    while (en.hasMoreElements()) {
                        val intf = en.nextElement()
                        val enumIpAddr = intf.inetAddresses
                        while (enumIpAddr.hasMoreElements()) {
                            val inetAddress = enumIpAddr.nextElement()
                            if (!inetAddress.isLoopbackAddress && inetAddress is Inet4Address) {
                                return inetAddress.getHostAddress()
                            }
                        }
                    }
                } catch (e: SocketException) {
                    e.printStackTrace()
                }
//                info.type == ConnectivityManager.TYPE_WIFI -> {
//                    //  wifi网络
//                    val wifiManager = UIUtils.context().applicationContext
//                            .getSystemService(Context.WIFI_SERVICE) as WifiManager
//                    val wifiInfo = wifiManager.connectionInfo
//                    return intIP2StringIP(wifiInfo.ipAddress)
//                }
                info.type == ConnectivityManager.TYPE_ETHERNET -> // 有限网络
                    return getLocalIp()
            }
        }
        return null
    }

    private fun intIP2StringIP(ip: Int): String {
        return (ip and 0xFF).toString() + "." +
                (ip shr 8 and 0xFF) + "." +
                (ip shr 16 and 0xFF) + "." +
                (ip shr 24 and 0xFF)
    }


    // 获取有线网IP
    private fun getLocalIp(): String {
        try {
            val en = NetworkInterface
                    .getNetworkInterfaces()
            while (en.hasMoreElements()) {
                val intf = en.nextElement()
                val enumIpAddr = intf
                        .inetAddresses
                while (enumIpAddr.hasMoreElements()) {
                    val inetAddress = enumIpAddr.nextElement()
                    if (!inetAddress.isLoopbackAddress && inetAddress is Inet4Address) {
                        return inetAddress.getHostAddress()
                    }
                }
            }
        } catch (ex: SocketException) {//

        }

        return "1.1.1.1"

    }

    fun isNetworkConnected(context: Context?): Boolean {
        if (context != null) {
            val mConnectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager
                    ?: return false

            val mNetworkInfo = mConnectivityManager.activeNetworkInfo
            //有网
            return mNetworkInfo != null
        }
        return false//没有网
    }
}