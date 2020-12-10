
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Created by liuwei
/// on 2020/12/4
/// page common_utils
/// desc

class CommonUtils{

  /// 显示toast
  static showToast(
      {@required String msg,
        BuildContext context
      }) {
    // toast.showToast(msg);
    //  showToast(msg: msg);
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }
}