import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_event_bus.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/net/xfs_common_channel_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Created by liuwei
/// on 2020-09-01
/// page xfs_common_uitils

class XFSCommonUtils{

  /// 显示toast
  static showToast({
    @required String msg,
    ToastGravity gravity=ToastGravity.CENTER,
    Color backgroundColor=Colors.black,
    Toast toastLength,
  }) {
    Fluttertoast.showToast(msg: msg, gravity: gravity, backgroundColor: backgroundColor, toastLength: toastLength);
  }

  /// 显示toast
  /// [msg] 显示信息
  /// [gravity] 显示位置
  /// [backgroundColor] 背景颜色
  /// [textColor] 字体颜色
  /// [duration] 持续时间，毫秒
  /// [dismissCallback] 消失的时候回调
  // static showXFSToast({
  //   @required BuildContext context,
  //   @required String msg,
  //   XFSToastGravity gravity = XFSToastGravity.CENTER,
  //   Color backgroundColor=Colors.black,
  //   Color textColor=Colors.white,
  //   int duration,
  //   Function dismissCallback
  // }) {
  //   XFSToast.show(context: context, message: msg, gravity: gravity, color: backgroundColor, duration: duration, dismissCallback: dismissCallback);
  // }

  /// 是否有购买权限
  static bool hasBuyAuth(){
    return xfsUserInfo.hasBuyAuth;
  }

  /// 是否有审批权限
  static bool hasApproveAuth(){
    return xfsUserInfo.hasApproveAuth;
  }

  /// 是否有结算
  static bool hasSettleAuth(){
    return xfsUserInfo.hasSettleAuth;
  }

  /// 是否签约
  static bool contract() {
    return xfsUserInfo?.contract??true;
  }

  /// 点击返回
  static goBackNative({dynamic argument}){
    XFSCommonChannelUtils.goBack(argument: argument);
    closeFlutter();
  }

  /// 跳转原生root页面
  /// [index] 原生底部导航第几个
  static goBackNativeHomePage({int index=-1}){
    XFSCommonChannelUtils.goHome(index: index);
    closeFlutter();
  }

  /// 关闭flutter
  static closeFlutter(){
    // android 在页面消失时候调用flutter的通道，setState不起作用，只能发送通知。生命周期和iOS生命周期不一致
    if (Platform.isAndroid){
      eventBus.fire(XFSCloseFlutter());
    }
  }
}

class XFSColorUtils{

  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }
}