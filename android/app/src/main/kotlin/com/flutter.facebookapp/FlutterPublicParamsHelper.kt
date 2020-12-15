package com.flutter.facebookapp

import com.example.flutter_facebook.MainActivity
import java.util.HashMap

/**
 * Created by 公共参数组装 on 2020/9/22.
 * Author：wdx
 * Description： This is 。。。
 **/
 object FlutterPublicParamsHelper {

    fun  getPublicParams(mainActivity: MainActivity):Map<String,Any?>{
        val map = HashMap<String, Any?>()

        /**
         * 如果登录了，传递用户相关信息
         * 服务端每个模块定义的参数不一样，大小写都要传
         */
//        if (isLogin()) {
//            map["account_type"] = AccountManager.userInfo.accountType()
//            map["accountType"] = AccountManager.userInfo.accountType()
//            map["token"] = AccountManager.userInfo.token()
//            map["member_id"] = AccountManager.userInfo.memberId()
//            map["memberId"] = AccountManager.userInfo.memberId()
//            map["login_account"] = AccountManager.userInfo.loginAccount()
//            map["loginAccount"] = AccountManager.userInfo.loginAccount()
//            if(AccountManager.userInfo.accountType() == 10) {
//                map["customerId"] = AccountManager.userInfo.customerIdPe()
//                map["customer_id"] = AccountManager.userInfo.customerIdPe()
//                map["customerCode"] = AccountManager.userInfo.customerCodePe()
//                map["customer_code"] = AccountManager.userInfo.customerCodePe()
//                map["customerName"] = AccountManager.userInfo.customerName()
//            }
//        }
        map["timestamp"] = System.currentTimeMillis()
        map["device_platform"] = "android"
        map["version_code"] = DevicesUtils.getVerCode(mainActivity)
        map["push_token"] = ""
        map["channel"] = DevicesUtils.getAppMetaData(mainActivity, "UMENG_CHANNEL")
        map["device_id"] = DevicesUtils.getIMEI(mainActivity)
        map["network"] = DevicesUtils.getAPNType(mainActivity)
        map["device_brand"] = DevicesUtils.getMobileBrand()
        map["os_version"] = DevicesUtils.getOsVersion()
//        map["curLng"] =  SPUtils.getObjectForKey("longitude", "").toString()//当前所在位置地址经度
//        map["curLat"] = SPUtils.getObjectForKey("latitude", "").toString()//当前所在位置地址纬度
        return map;
    }
}