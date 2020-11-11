import 'dart:convert';

/// Created by liuwei
/// on 2020-09-25
/// page xfs_user_model
/// 用户信息

class XFSUserModel {

  /// 用户id
  String memberId;
  /// 是否签约
  bool contract;
  /// token
  String token;
  /// 登录账户
  String loginAccount;
  /// 用户名
  String userName;
  /// 是否有下单权限
  bool hasBuyAuth;
  /// 是否有审批权限
  bool hasApproveAuth;
  /// 是否有结算权限
  bool hasSettleAuth;
  /// 请求地址
  String baseUrl;
  /// 当前原生进入flutter入口路由，
  String route;
  /// 仓库id
  String warehouseId;
  /// 未选择项目下账号
  List unchoice_customer_ids;
  /// 用于传递参数
  Object arguments;

  XFSUserModel({this.memberId, this.contract, this.token, this.loginAccount});

  XFSUserModel.fromJson(Map<dynamic, dynamic> json){
    if (json == null) {
      return;
    }
    memberId = json['memberId'];
    contract = json['contract'];
    token = json['token'];
    loginAccount = json['loginAccount'];
    userName = json['userName'];
    hasBuyAuth = json['hasBuyAuth'];
    hasApproveAuth = json['hasApproveAuth'];
    hasSettleAuth = json['hasSettleAuth'];
    baseUrl = json['baseUrl'];
    route = json['route'];
    warehouseId = json['warehouseId'];
    unchoice_customer_ids = json['unchoice_customer_ids'];
    arguments = json['arguments'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['memberId'] = this.memberId;
    data['contract'] = this.contract;
    data['token'] = this.token;
    data['loginAccount'] = this.loginAccount;
    data['userName'] = this.userName;
    data['hasBuyAuth'] = this.hasBuyAuth;
    data['hasApproveAuth'] = this.hasApproveAuth;
    data['hasSettleAuth'] = this.hasSettleAuth;
    data['baseUrl'] = this.baseUrl;
    data['route'] = this.route;
    data['warehouseId'] = this.warehouseId;
    return data;
  }
}

XFSUserModel get xfsUserInfo => XFSUserInfoManage._userModel;

class XFSUserInfoManage {

  static XFSUserInfoManage _instance;

  static XFSUserModel _userModel;

  factory XFSUserInfoManage() => _getInstance();
  XFSUserInfoManage._();

  static XFSUserInfoManage _getInstance() {
    if (_instance == null) {
      _instance = XFSUserInfoManage._();
    }
    return _instance;
  }

  static void init(dynamic userInfo)  {
    Map map;
    if (userInfo is Map){
      map = userInfo;
    }
    else if (userInfo is String){
      map = jsonDecode(userInfo);
    }
    // Map map = jsonDecode(userInfo);
    /// 获取用户信息
    _userModel = XFSUserModel.fromJson(map);
  }

}