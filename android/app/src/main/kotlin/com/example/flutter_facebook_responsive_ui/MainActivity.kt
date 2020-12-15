package com.example.flutter_facebook

import android.os.Build
import androidx.annotation.RequiresApi
import com.flutter.facebookapp.FlutterPublicParamsHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.flutter.facebookapp.SignUtils
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL = "xfs_fsyc_method_key"
    private var methodChannel: MethodChannel? = null
    var result1: MethodChannel.Result? = null
    @RequiresApi(Build.VERSION_CODES.N)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
        methodChannel!!.setMethodCallHandler { call, result ->
            try {
                result1 = result
                when (call.method) {
                    "get_public_parmas" -> {
                        getPublicParmas(call.arguments as kotlin.collections.HashMap<String, Any?>)
                    }
                    "goBack" -> finish()
                    else -> result.notImplemented()
                }
            } catch (e: IllegalStateException) {
                if (result1 != null ) {
                    result1!!.success("接口错误")
                }
            }
        }
    }

    /**
     * 获取公参
     */
    fun getPublicParmas(map: HashMap<String, Any?>) {
        var hasMap = HashMap<String, Any?>();
        hasMap.putAll(map)
        hasMap.putAll(FlutterPublicParamsHelper.getPublicParams(this@MainActivity));
        var sign = SignUtils.getSign(hasMap, "xfs7Alc74oCVpHXg97etTs",true);
        hasMap.put("sign", sign);
        result1?.success(hasMap);
    }
}
