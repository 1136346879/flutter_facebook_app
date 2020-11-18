import 'package:flutter_facebook/models/xfs_goods_model.dart';
import 'package:flutter_facebook/models/xfs_order_invoice_model.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';
import 'package:xfs_flutter_utils/utils/xfs_date_util.dart';

import 'package:flutter_facebook/config/xfs_header.dart';
/// Created by liuwei
/// on 2020-09-18
/// page xfs_order_model


class XFSOrderPageModel{
  XFSPageModel pageStoreOrderPojoList;
  bool tab_audit_show;

  XFSOrderPageModel({this.pageStoreOrderPojoList, this.tab_audit_show});

  XFSOrderPageModel.fromJson(Map<dynamic, dynamic> json){
    if (json == null){
      return;
    }
    if (json['pageStoreOrderPojoList'] != null){
      pageStoreOrderPojoList = XFSPageModel.fromJson(json['pageStoreOrderPojoList']);
    }
    tab_audit_show = json['tab_audit_show'];
  }

}

/// 订单列表
class XFSOrderListModel{

  bool audit_button_show;
  List authorityList;
  bool buy_again_button;
  /// 是否申请取消
  bool cancle_apply_show;
  String created_at;
  num current_time;
  String customer_code;
  String customer_id;
  String customer_name;
  String final_paid_type;
  num final_sent_type;
  bool is_show;
  num limit_time;
  num order_class;
  String order_id;
  /// 订单是否拆分, 0=未拆分，10=拆分中，20=以拆分
  int order_split_status;
  /// 订单状态
  int order_status;
  /// 商品总数
  num order_total_count;
  /// 支付金额
  num paid_amount;
  bool paid_button_show;
  /// 支付方式
  int paid_type;
  bool reject_orders_exist;
  /// 下单账号类型
  int sent_type;
  num separate_shipping_fee;
  /// 发票信息
  XFSOrderInvoice orderInvoice;
  /// 子订单。拆分
  List<XFSOrderListModel> subOrderList;
  /// 商品数量
  List<XFSGoodsModel> listOrderItems;
  List listOrderVerifyRecord;

  /// 是否展开，默认false，用于控制多个商品是否展开，
  bool isExpand = false;
  /// 是否显示更多按钮，如果商品大于三个则表示需要显示展开按钮，
  bool get isShowMore => listOrderItems?.length > 3 ? true : false;
  /// 订单下商品数量，如果小于三个直接显示，多余三个默认显示3个，如果是展开显示商品个数，未展开显示3个
  int get goodsCount => isShowMore ? isExpand ? listOrderItems?.length : 3  : listOrderItems?.length;
  /// 是否子订单，拆分订单的第一个订单用这个参数，用于取消顶部分割线
  bool isChildOrder = false;
  /// 可购买商品数组
  List<XFSGoodsModel>  _canBuyList = List();
  /// 可购买商品数组
  List<XFSGoodsModel> get canBuyList => _canBuyList;
  /// 无库存商品，临时数据
  List<XFSGoodsModel> noStockGoods;
  
  /// 当前账号是否在该订单下是否有下单权限
  bool hasBuyAuth(){
    if (!XFSCommonUtils.contract()){
      return true;
    }
    if (authorityList.contains(2)){
      return true;
    }
    return false;
  }
  
  /// 当前账号是否在该订单下是否有审核限
  bool hasApproveAuth(){
    if (!XFSCommonUtils.contract()){
      return true;
    }
    if (authorityList.contains(3)){
      return true;
    }
    return false;
  }
  
  /// 当前账号是否在该订单下是否有结算权限
  bool hasSettleAuth(){
    print('XFSCommonUtils.contract()-1-${XFSCommonUtils.contract()}');
    if (!XFSCommonUtils.contract()){
      return true;
    }
    print('XFSCommonUtils.contract()-2-${XFSCommonUtils.contract()}');
    if (authorityList.contains(1)){
      return true;
    }
    return false;
  }
  
  /// 是否可以再次购买
  bool canBuyAgain(){

    List<XFSGoodsModel> list = List();

    for (int i = 0; i < listOrderItems.length; i++){
      XFSGoodsModel element = listOrderItems[i];
      /// 如果商品有小数则不显示。只要有一个商品是小数，则该订单就不能再次购买，需要清空_canBuyList中数据
      double num = element.buyyer_count.toDouble() - element.buyyer_count.toInt();
      if (num > 0){
        list.clear();
        return false;
      }
      /// 临采商品部不能再次购买
      if (element.spu_id == 0){
        continue;
      }
      /// 是否签约，未签约用户需要判断是否危险品。
      if (!XFSCommonUtils.contract()??true){
        //// 不是危险物品
        if (element.restricted != 1 && element.restricted != 2){
          list.add(element);
        }
      }
      else{
        list.add(element);
      }
    }
    if (list.isNotNullOrEmpty()){
      _canBuyList = list;
      return true;
    }
    return false;
  }

  XFSOrderListModel({this.audit_button_show, this.authorityList,
    this.buy_again_button, this.cancle_apply_show, this.created_at,
    this.current_time, this.customer_code, this.customer_id,
    this.customer_name, this.final_paid_type, this.final_sent_type,
    this.is_show, this.limit_time, this.order_class, this.order_id,
    this.order_split_status, this.order_status, this.order_total_count,
    this.paid_amount, this.paid_button_show, this.paid_type,
    this.reject_orders_exist, this.sent_type, this.separate_shipping_fee,
    this.subOrderList, this.listOrderItems, this.listOrderVerifyRecord, this.orderInvoice, this.isChildOrder = false});


  XFSOrderListModel.fromJson(Map<dynamic, dynamic> json){
    audit_button_show = json['audit_button_show'];
    authorityList = json['authorityList'];
    buy_again_button = json['buy_again_button'];
    cancle_apply_show = json['cancle_apply_show'];
    created_at = json['created_at'];
    current_time = json['current_time'];
    customer_code = json['customer_code'];
    customer_id = json['customer_id'];
    customer_name = json['customer_name'];
    final_paid_type = json['final_paid_type'];
    final_sent_type = json['final_sent_type'];
    is_show = json['is_show'];
    limit_time = json['limit_time'];
    order_class = json['order_class'];
    order_id = json['order_id'];
    order_split_status = json['order_split_status'];
    order_status = json['order_status'];
    order_total_count = json['order_total_count'];
    paid_amount = json['paid_amount'];
    paid_button_show = json['paid_button_show'];
    paid_type = json['paid_type'];
    bool ;reject_orders_exist = json['reject_orders_exist'];
    sent_type = json['sent_type'];
    separate_shipping_fee = json['separate_shipping_fee'];

    if (json['orderInvoice'] != null){
      orderInvoice = XFSOrderInvoice.fromJson(json['orderInvoice']);
    }
    if (json['subOrderList'] != null){
      subOrderList = List();
      json['subOrderList'].forEach((v) {
        subOrderList.add(XFSOrderListModel.fromJson(v));
      });
    }

    if (json['listOrderItems'] != null){
      listOrderItems = List();
      json['listOrderItems'].forEach((v) {
        listOrderItems.add(XFSGoodsModel.fromJson(v));
      });
    }
    listOrderVerifyRecord = json['listOrderVerifyRecord'];
  }
}

/// 订单列表请求
class XFSRequestOrderListModel{

  /// tab状态
  dynamic tab_order_status;
  /// 分页
  int page_num;
  int page_size;
  /// 开始时间
  DateTime beginTime;
  /// 结束时间
  DateTime endTime;

  String get created_at_begin => beginTime == null ? '' : XFSDateUtil.getDateStrByDateTime(beginTime);
  String get created_at_end => endTime == null ? '' : XFSDateUtil.getDateStrByDateTime(endTime);

  /// 支付方式
  String paid_type;
  /// 搜索关键词
  String search_param;
  int member_id;
  String customer_id;
  List unchoice_customer_ids;


  /// 开票状态
  String invoiceSorce;
  XFSRequestOrderListModel({this.tab_order_status, this.page_num=1, this.page_size,
    this.beginTime, this.endTime, this.paid_type, this.search_param});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tab_order_status'] = XFSOrderUtils.orderCodeTabWithTitle(this.tab_order_status)??'';
    data['page_num'] = this.page_num??1;
    data['page_size'] = this.page_size??5;
    data['created_at_begin'] = this.created_at_begin??'';
    data['created_at_end'] = this.created_at_end??'';
    data['paid_type'] = XFSOrderUtils.paymentForCode(this.paid_type)??'';
    data['search_param'] = this.search_param??'';
    data['unchoice_customer_ids'] = xfsUserInfo?.unchoice_customer_ids;
    data['member_id'] = this.member_id;
    data['customer_id'] = this.customer_id;
    return data;
  }
}