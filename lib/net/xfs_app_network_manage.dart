import 'dart:async';

import 'package:connectivity/connectivity.dart';

/// Created by liuwei
/// on 2020-08-27
/// page xfs_app_network_manage

class XFSAppNetworkStatusManager{

  factory XFSAppNetworkStatusManager()=>_getInstance();
  static XFSAppNetworkStatusManager _instance;
  XFSAppNetworkStatusManager._();
  static XFSAppNetworkStatusManager get instance=>_getInstance();
  static ConnectivityResult networkStatu;
  StreamSubscription subscription;

  static XFSAppNetworkStatusManager _getInstance(){

    if(_instance == null){
      _instance = XFSAppNetworkStatusManager._();
    }
    return _instance;

  }

  void startMonitor() async{

    var result = await Connectivity().checkConnectivity();
    networkStatu = result;

    //开启网络状态监听
    subscription = Connectivity().onConnectivityChanged.listen((result){

      /// 网络环境变化
      if(result != networkStatu){

      }

      networkStatu = result;
    });

  }

}