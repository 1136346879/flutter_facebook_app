import 'package:flutter_facebook/config/channleKey.dart';

/// Created by liuwei
/// on 2020-09-24
/// page xfs_common_channel_utils

/// 公共交互
class XFSCommonChannelUtils {

  /// 接口参数回传至原生--返回签名后的参数
  static Future<Map<dynamic, dynamic>> getPublicParmas(Map params) async {

    var result = await methodChannle.invokeMethod('get_public_parmas', params);

    if (result == null || result.isEmpty) {
      return null;
    }

    return result;
  }

  /// 获取用户信息
  static getUserInfo() {
    methodChannle.invokeMethod('goHomePage');
  }

  /// 调用原生的返回方法
  static goBack({dynamic argument}) {
    methodChannle.invokeMethod('goBack', argument);
  }

  /// 跳转首页
  /// [index] 原生底部导航，如果是-1不需要改变底部导航栏索引
  static goHome({int index=-1}) {
    methodChannle.invokeMethod('goHomePage', index);
  }

  /// 原生是否可以手势返回
  static nativeCanPop({bool canPop=false}){
    methodChannle.invokeMethod('PopGestureRecognizer', canPop);
  }

  /// 从自提点搜索页返回。
  static goBackFromSelfRaiseSearch(num shipAddId){
    methodChannle.invokeMethod('backFromSelfRaiseSearch', shipAddId.toInt());
  }
  /// 告诉原生页面当前flutter处于哪个页面。
  static currentRouteName(String route){
    methodChannle.invokeMethod('currentRouteName', route);
  }

  /// 是否可以跳转flutter页面，暂时只有Android用到
  /// 因为Android推出flutter页面生命周期和iOS不同，
  //  在页面消失的时候不能调用flutter的setstate方法。为了保持页面一致性，
  //  flutter页面退出时候增加500毫秒延时任务，防止在500毫秒之内用户再次点击跳转flutter
  //  需要走这个通道告诉原生什么时候可以点击跳转。
  static canPushFlutter(bool canPush){
    methodChannle.invokeMethod('canPushFlutter', canPush);
  }
}