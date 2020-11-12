import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook/router/xfs_route_configure.dart';
import 'package:xfs_flutter_utils/define/xfs_config.dart';
import 'package:xfs_flutter_utils/net/xfs_http.dart';
import 'package:xfs_flutter_utils/utils/xfs_log_util.dart';
import 'package:xfs_flutter_utils/widgets/xfs_text.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_navigator_manage.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_route.dart';

import 'config/channleKey.dart';
import 'config/defines.dart';
import 'config/xfs_event_bus.dart';
import 'models/xfs_user_model.dart';
import 'net/xfs_common_channel_utils.dart';

/// Created by liuwei
/// on 2020-09-17
/// page root_page

class XFSRootPage extends StatefulWidget {
  @override
  _XFSRootPageState createState() => _XFSRootPageState();
}

class _XFSRootPageState extends State<XFSRootPage>  with RouteAware{

  Object _arguments;
  /// 默认显示的页面
  String _route = 'rootPage';


  @override
  void initState() {
    super.initState();

    /// 这个通知只有Android端用到。
    eventBus.on<XFSCloseFlutter>().listen((event) {
      XFSCommonChannelUtils.canPushFlutter(false);
      Future.delayed(Duration(milliseconds: 300), (){
        _refreshView('rootPage');
        XFSCommonChannelUtils.canPushFlutter(true);
      });
    });

    methodChannle.setMethodCallHandler((call) => methedHandle(call));
  }

  Future methedHandle (MethodCall call){

    if (call.method == "pushPage"){

      var data = call.arguments;
      try{
        XFSUserInfoManage.init(data);
        // Http.setBaseUrl(xfsUserInfo.baseUrl);
        _route = call.arguments['route'];
        _arguments = xfsUserInfo.arguments;
        setState(() {});

      }catch(error){
        XFSLogUtil.info('error-----------${error.toString()}');
      }
    }
    else if (call.method == "refreshOrderList"){
      /// 发送通知刷新列表
      eventBus.fire(XFSRefreshOrderListEvent());
    }
    else if (call.method == "pushOrderListAndRemoveUntil"){
      /// 走这个通道表示进入入口变为XFSOrderPage，更新保存的入口。
      xfsUserInfo.route = "XFSOrderPage";
      /// 判断当前路由栈最后一个是root的话直接刷新，如果不是的话就跳转到root并刷新页面
      /// 发送通知跳转到订单列表
      if (xfsNaviPagelist.last != 'rootPage'){
        eventBus.fire(XFSPushOrderListAndRemoveUntil());
      }
      _refreshView('XFSOrderPage');
    }
    else if (call.method == "closeFlutterPage"){
      /// 退出flutter页面，释放资源，
      _refreshView('rootPage');
    }
  }

  /// 刷新页面显示
  _refreshView(String route){
    _route  = route;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (_route == 'rootPage'){
      return Container(
        color: Colors.brown,
      );
    }
    XFSRouteResult routeResult = XFSAppRouteConfigure.routeMap[_route](_arguments);
    return routeResult.widget;
  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();

    xfsRouteObserver.subscribe(this, ModalRoute.of(context));
  }
  

  @override
  void dispose() {
    xfsRouteObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    /// 关闭侧滑返回
    if (Platform.isIOS){
      XFSCommonChannelUtils.nativeCanPop(canPop: false);
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();

    /// 开启侧滑返回
    if (Platform.isIOS){
      XFSCommonChannelUtils.nativeCanPop(canPop: true);
    }
  }

}

