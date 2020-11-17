
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';

/// Created by liuwei
/// on 2020/10/28
/// page xfs_order_tracking_model
/// desc 订单跟踪model

class XFSOrderTrackingPageModel{

  List <XFSOrderTrackingModel> recordList = List();

  XFSOrderTrackingPageModel.fromJson(BaseEntity entity){
    if (entity.data != null){
      entity.data.forEach((v) {
        recordList.add(XFSOrderTrackingModel.fromJson(v));
      });
    }
  }
}

class XFSOrderTrackingModel {

  int id;
  /// 订单号
  String orderId;
  /// 订单状态。未用到
  int orderStatus;
  /// 处理人id
  int operatorId;
  /// 处理人姓名
  String operatorName;
  /// 处理时间
  String createdAt;
  /// 显示在页面的订单状态。
  String orderDisplayStatus;
  /// 底部线条是否显示，最后一条数据不显示底部线条, 默认是true
  bool showBottom;

  /// 订单状态对应的显示文字
  String get orderStatusTitle => orderDisplayStatus;

  XFSOrderTrackingModel({
    this.orderId,
    this.orderStatus,
    this.operatorId,
    this.operatorName,
    this.createdAt,
    this.showBottom=true,
    this.orderDisplayStatus,
  });

  XFSOrderTrackingModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    operatorId = json['operatorId'];
    operatorName = json['operatorName'];
    createdAt = json['createdAt'];
    orderDisplayStatus = json['orderDisplayStatus'];
    showBottom = true;
  }
}