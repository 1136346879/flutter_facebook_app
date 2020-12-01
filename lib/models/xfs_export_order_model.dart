import 'package:xfs_flutter_utils/utils/xfs_date_util.dart';

/// Created by liuwei
/// on 2020/11/16
/// page xfs_export_order_model
/// desc 订单导出

class XFSExportOrderModel {

  /// 选择的时间
  String time;
  /// 开始时间。自定义
  DateTime beginDate;
  /// 结束时间，自定义
  DateTime endDate;
  /// 订单状态
  List orderStatus;
  /// 发票状态
  List invoiceSorce;
  /// 支付方式
  List payments;
  /// 邮箱
  String email;

  String get created_at_begin => beginDate == null ? '' : XFSDateUtil.getDateStrByDateTime(beginDate);
  String get created_at_end => endDate == null ? '' : XFSDateUtil.getDateStrByDateTime(endDate);

  /// 开始时间的最小时间，不能小于结束时间一年
  DateTime beginMinDate(){
    if (endDate != null){
      return endDate.subtract(Duration(days: 365));
    }
    return null;
  }

  /// 结束时间的最大时间，不能大于开始时间一年
  DateTime endMaxDate(){
    if (beginDate != null){
      return beginDate.add(Duration(days: 365));
    }
    return null;
  }

  /// 初始化开始时间，如果有开始时间就显示开始时间，
  /// 如果没选开始时间则判断结束时间是否已选
  DateTime beginInitDate(){
    if (beginDate == null){
      return beginMinDate();
    }
    return beginDate;
  }

  /// 初始化结束时间，如果有结束时间就显示结束时间，
  /// 如果没选结束时间则判断开始时间是否已选
  DateTime endInitDate(){
    if (endDate == null){
      return endMaxDate();
    }
    return endDate;
  }

  Map toJson(){
    Map<dynamic, dynamic> map = Map();

    if (time == '自定义'){
      map['beginTime'] = created_at_begin??'';
      map['endTime'] = created_at_end??'';
    }else {
      map['time'] = time??'';
    }

    List uploadorderStatus = orderStatus.map((e) => e).toList();
    map['uploadorderStatus'] = uploadorderStatus??[];
    List uploadInvoiceSorce = invoiceSorce.map((e) => e).toList();
    map['uploadInvoiceSorce'] = uploadInvoiceSorce??[];
    List uploadPayments = payments.map((e) => e).toList();
    map['uploadPayments'] = uploadPayments??[];
    map['email'] = email??'';

    return map;
  }
}