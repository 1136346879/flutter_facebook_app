import 'dart:convert';

import 'package:flutter_facebook/models/xfs_address_receiver_model.dart';
import 'package:flutter_facebook/models/xfs_goods_model.dart';
import 'package:flutter_facebook/models/xfs_logistics_Info_model.dart';
import 'package:flutter_facebook/models/xfs_order_coupon_model.dart';
import 'package:flutter_facebook/models/xfs_order_verify_model.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/extension/xfs_extension.dart';
import 'xfs_order_invoice_model.dart';
import 'xfs_order_tracking_model.dart';

/// Created by ZhuMuZhi
/// on 2020-09-21
/// page xfs_order
/// Details_model
/// 订单详情Model

///订单详情-数据模型
class XFSOrderDetailsModel {
  // 订单基础信息 对象
  XFSOrderBase orderBase;

  List<XFSOrderTrackingModel> orderRecordList = List();

  // orderExt 对象
  XFSOrderExt orderExt;

  // 订单发票 对象
  XFSOrderInvoice orderInvoice;

  // 订单取消 对象
  XFSOrderCancle orderCancle;

  // 物流信息 对象（本地字段，通过订单详情数物流单号字段获得）
  XFSLogisticsInfoModel logisticsInfo;

  // 收货人List 内部为XFSAddressReceiverModel收货人model
  List<XFSAddressReceiverModel> listAddressReceiver;

  // 商品对象列表
  List<XFSGoodsModel> listOrderItems;

  // 可购买的商品列表
  List<XFSGoodsModel> _canBuyList = List();

  // 普通商品对象列表
  List<XFSGoodsModel> normalPriceOrderItemsList;

  // 特殊商品对象列表
  List<XFSGoodsModel> specialPriceOrderItemsList;

  // 满减商品对象列表
  List<XFSGoodsModel> fullAmountReduceOrderItemsList;

  List<XFSGoodsModel> fullQuantityReduceOrderItemsList;

  /// 可购买商品数组
  List<XFSGoodsModel> get canBuyList => _canBuyList;

  /// 无库存商品，临时数据
  List<XFSGoodsModel> noStockGoods;

  // 订单商品是否包含危化品
  bool restricted_items_exist;

  // 订单优惠卷 对象
  XFSOrderCouponModel orderCoupon;

  // 订单备注
  List<XFSOrderRemark> listOrderRemark;

  // 审批记录阶段模型List
  List<XFSOrderVerifyRecordModel> listOrderVerifyRecord;

  // [本地字段] 联系人是否展开，默认false，用于控制多个联系人是否展开
  bool isContactsExpand = false;

  // [本地字段] 联系人是否显示更多按钮，如果联系人大于2个则需要显示展开按钮
  bool get isContactsShowMore => listAddressReceiver?.length > 2 ? true : false;

  // [本地字段] 商品是否展开，默认false，用于控制多个商品是否展开，
  bool isExpand = false;

  // [本地字段] 商品Item是否显示更多按钮，如果商品大于三个则表示需要显示展开按钮，
  bool get isShowMore => listOrderItems?.length > 3 ? true : false;

  // [本地字段] 订单下商品数量，如果小于三个直接显示，多余三个默认显示3个，如果是展开显示商品个数，未展开显示3个
  int get goodsCount =>
      isShowMore
          ? isExpand
          ? listOrderItems?.length
          : 3
          : listOrderItems?.length;

  /// 当前账号是否在该订单下是否有下单权限
  bool hasBuyAuth() {
    if (!XFSCommonUtils.contract()) {
      return true;
    }
    if (authorityList.contains(2)) {
      return true;
    }
    return false;
  }

  /// 当前账号是否在该订单下是否有审核限
  bool hasApproveAuth() {
    if (!XFSCommonUtils.contract()) {
      return true;
    }
    if (authorityList.contains(3)) {
      return true;
    }
    return false;
  }

  /// 当前账号是否在该订单下是否有结算权限
  bool hasSettleAuth() {
    if (!XFSCommonUtils.contract()) {
      return true;
    }
    if (authorityList.contains(1)) {
      return true;
    }
    return false;
  }

  /// 是否可以再次购买
  bool canBuyAgain() {
    List<XFSGoodsModel> list = List();

    for (int i = 0; i < listOrderItems.length; i++) {
      XFSGoodsModel element = listOrderItems[i];

      /// 如果商品有小数则不显示。只要有一个商品是小数，则该订单就不能再次购买，需要清空_canBuyList中数据
      double num =
          element.buyyer_count.toDouble() - element.buyyer_count.toInt();
      if (num > 0) {
        list.clear();
        return false;
      }

      /// 临采商品部不能再次购买
      if (element.spu_id == 0) {
        continue;
      }

      /// 是否签约，未签约用户需要判断是否危险品。
      if (!XFSCommonUtils?.contract()) {
        //// 不是危险物品
        if (element.restricted != 1 && element.restricted != 2) {
          list.add(element);
        }
      } else {
        list.add(element);
      }
    }
    if (list.isNotNullOrEmpty()) {
      _canBuyList = list;
      return true;
    }
    return false;
  }

  dynamic orderRemark;
  dynamic comfirmRemark;

  dynamic listOrderRefund;
  dynamic orderRefund;
  dynamic orderCancleApply;
  dynamic orderWarning;
  dynamic initPayWay;
  dynamic payWay;

  // 付款方式
  String settleWay;

  // 当前时间 (计算倒计时)
  num current_time;

  // 截止时间 (计算倒计时)
  num limit_time;

  // 预计到达时间
  String may_arrived;

  // 期望到达时间
  String wanna_arrived;

  // 总重量
  num total_weight;

  // 是否显示【再次购买】按钮 true 显示 false 不显示
  bool buy_again_button;

  // 是否显示【支付】按钮 true 显示 false 不显示
  bool paid_button_show;

  // 是否显示【取消申请】按钮 true 显示 false 不显示
  bool cancle_apply_show;

  // 是否显示【审批】按钮 true 显示 false 不显示
  bool audit_button_show;

  // 是否显示push(?)按钮 true 显示 false 不显示
  bool push_button_show;

  // 账号在当前订单内的权限串 [1：结算 2：下单 3：审批] -- 例子 [1,3] 权限为[结算 + 审批]
  List authorityList;

  // 订单号（无值）
  dynamic order_id;

  // 期望时间
  String self_take_in_str;

  // 物流单号
  List list_express_num;

  // 维修按钮是否置灰
  bool is_show;

  dynamic settled_amount;
  num flag;
  dynamic orderAnomal;

  num is_rejected;
  dynamic is_returnable_freight;
  num limit_customer;
  num total_volume_f;
  dynamic total_volume;
  dynamic max_edge;
  dynamic inquiry_num;
  bool reject_orders_exist;

  // fullQuantityReduceOrderItemsMap 对象
  dynamic fullQuantityReduceOrderItemsMap;
  dynamic fullAmountReduceOrderItemsMap;
  num full_amount_reduce_value;
  num full_quantity_reduce_value;
  num total_promotion_value;

  dynamic listOrderAttachment;

  num order_class;
  dynamic push_message;

  XFSOrderDetailsModel({this.order_id,
    this.orderBase,
    this.orderRecordList,
    this.orderExt,
    this.cancle_apply_show,
    this.audit_button_show,
    this.paid_button_show,
    this.push_button_show,
    this.buy_again_button,
    this.authorityList,
    this.comfirmRemark,
    this.current_time,
    this.logisticsInfo,
    this.flag,
    this.fullAmountReduceOrderItemsList,
    this.fullAmountReduceOrderItemsMap,
    this.fullQuantityReduceOrderItemsList,
    this.fullQuantityReduceOrderItemsMap,
    this.full_amount_reduce_value,
    this.full_quantity_reduce_value,
    this.initPayWay,
    this.inquiry_num,
    this.is_rejected,
    this.is_returnable_freight,
    this.is_show,
    this.limit_customer,
    this.limit_time,
    this.listAddressReceiver,
    this.listOrderAttachment,
    this.listOrderItems,
    this.listOrderRefund,
    this.listOrderRemark,
    this.listOrderVerifyRecord,
    this.list_express_num,
    this.max_edge,
    this.may_arrived,
    this.normalPriceOrderItemsList,
    this.orderAnomal,
    this.orderCancle,
    this.orderCancleApply,
    this.orderCoupon,
    this.orderInvoice,
    this.orderRefund,
    this.orderRemark,
    this.orderWarning,
    this.order_class,
    this.payWay,
    this.push_message,
    this.reject_orders_exist,
    this.restricted_items_exist,
    this.self_take_in_str,
    this.settleWay,
    this.settled_amount,
    this.specialPriceOrderItemsList,
    this.total_promotion_value,
    this.total_volume,
    this.total_volume_f,
    this.total_weight,
    this.wanna_arrived});

  XFSOrderDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    orderBase = json['orderBase'] != null
        ? XFSOrderBase.fromJson(json['orderBase'])
        : null;

    if (json['orderRecordList'] != null) {
      json['orderRecordList'].forEach((i) {
        orderRecordList.add(XFSOrderTrackingModel.fromJson(i));
      });
    }
    orderExt = json['orderExt'] != null
        ? XFSOrderExt.fromJson(json['orderExt'])
        : null;

    orderInvoice = json['orderInvoice'] != null
        ? XFSOrderInvoice.fromJson(json['orderInvoice'])
        : null;

    listAddressReceiver = json['listAddressReceiver'] != null
        ? (json['listAddressReceiver'] as List)
        .map((i) => XFSAddressReceiverModel.fromJson(i))
        .toList()
        : null;

    orderCancle = json['orderCancle'] != null
        ? XFSOrderCancle.fromJson(json['orderCancle'])
        : null;

    if (json['listOrderItems'] != null) {
      listOrderItems = List();
      json['listOrderItems'].forEach((value) {
        listOrderItems.add(XFSGoodsModel.fromJson(value));
      });
    }

    normalPriceOrderItemsList = json['normalPriceOrderItemsList'] != null
        ? (json['normalPriceOrderItemsList'] as List)
        .map((i) => XFSGoodsModel.fromJson(i))
        .toList()
        : null;

    fullAmountReduceOrderItemsList =
    json['fullAmountReduceOrderItemsList'] != null
        ? (json['fullAmountReduceOrderItemsList'] as List)
        .map((i) => XFSGoodsModel.fromJson(i))
        .toList()
        : null;

    fullQuantityReduceOrderItemsList =
    json['fullQuantityReduceOrderItemsList'] != null
        ? (json['fullQuantityReduceOrderItemsList'] as List)
        .map((i) => XFSGoodsModel.fromJson(i))
        .toList()
        : null;

    specialPriceOrderItemsList = json['specialPriceOrderItemsList'] != null
        ? (json['specialPriceOrderItemsList'] as List)
        .map((i) => XFSGoodsModel.fromJson(i))
        .toList()
        : null;

    listOrderRemark = json['listOrderRemark'] != null
        ? (json['listOrderRemark'] as List)
        .map((i) => XFSOrderRemark.fromJson(i))
        .toList()
        : null;

    orderCoupon = json['orderCoupon'] != null
        ? XFSOrderCouponModel.fromJson(json['orderCoupon'])
        : null;

    listOrderVerifyRecord = json['listOrderVerifyRecord'] != null
        ? (json['listOrderVerifyRecord'] as List).map((i) =>
        XFSOrderVerifyRecordModel.fromJson(i)).toList()
        : null;

    // fullAmountReduceOrderItemsMap = json['fullAmountReduceOrderItemsMap'] != null ? FullAmountReduceOrderItemsMap.fromJson(json['fullAmountReduceOrderItemsMap']) : null,
    // fullQuantityReduceOrderItemsMap: json['fullQuantityReduceOrderItemsMap'] != null ? FullQuantityReduceOrderItemsMap.fromJson(json['fullQuantityReduceOrderItemsMap']) : null,

    buy_again_button = json['buy_again_button'] ?? false;
    cancle_apply_show = json['cancle_apply_show'] ?? false;
    push_button_show = json['push_button_show'] ?? false;
    paid_button_show = json['paid_button_show'] ?? false;
    audit_button_show = json['audit_button_show'] ?? false;

    authorityList = json['authorityList'] != null
    ? new List<num>.from(json['authorityList'])
        : null;

    list_express_num = json['list_express_num'] != null
    ? new List<String>.from(json['list_express_num'])
        : null;

    current_time = json['current_time'];
    flag = json['flag'];
    full_amount_reduce_value = json['full_amount_reduce_value'];
    full_quantity_reduce_value = json['full_quantity_reduce_value'];
    is_rejected = json['is_rejected'];
    is_show = json['is_show'] ?? false;
    limit_customer = json['limit_customer'];
    limit_time = json['limit_time'];
    may_arrived = json['may_arrived'];
    order_class = json['order_class'];
    reject_orders_exist = json['reject_orders_exist'] ?? false;
    restricted_items_exist = json['restricted_items_exist'] ?? false;
    self_take_in_str = json['self_take_in_str'];
    settleWay = json['settleWay'];
    total_promotion_value = json['total_promotion_value'];
    total_volume_f = json['total_volume_f'];
    total_weight = json['total_weight'];
    wanna_arrived = json['wanna_arrived'];

    order_id = json['order_id'];

    // total_volume = json['total_volume'] != null ? Object.fromJson(json['total_volume']) : null,
    // this.comfirmRemark= json['comfirmRemark'] != null ? Object.fromJson(json['comfirmRemark']) : null,
    // initPayWay = json['initPayWay'] != null ? Object.fromJson(json['initPayWay']) : null,
    // inquiry_num = json['inquiry_num'] != null ? Object.fromJson(json['inquiry_num']) : null,
    // this.is_returnable_freight = json['is_returnable_freight'] != null ? Object.fromJson(json['is_returnable_freight']) : null,
    // listOrderAttachment = json['listOrderAttachment'] != null ? Object.fromJson(json['listOrderAttachment']) : null,
    // listOrderRefund = json['listOrderRefund'] != null ? Object.fromJson(json['listOrderRefund']) : null,

    // max_edge = json['max_edge'] != null ? Object.fromJson(json['max_edge']) : null,
    // orderAnomal = json['orderAnomal'] != null ? Object.fromJson(json['orderAnomal']) : null,

    // orderCancleApply = json['orderCancleApply'] != null ? Object.fromJson(json['orderCancleApply']) : null,

    // orderRefund = json['orderRefund'] != null ? Object.fromJson(json['orderRefund']) : null,
    // orderRemark = json['orderRemark'] != null ? Object.fromJson(json['orderRemark']) : null,
    // orderWarning = json['orderWarning'] != null ? Object.fromJson(json['orderWarning']) : null,
    // payWay = json['payWay'] != null ? Object.fromJson(json['payWay']) : null,
    // push_message = json['push_message'] != null ? Object.fromJson(json['push_message']) : null,
    // settled_amount = json['settled_amount'] != null ? Object.fromJson(json['settled_amount']) : null,
  }
}

/// XFSOrderBaseModel
class XFSOrderBase {
  // 最终支付方式对象
  String final_paid_type;

  // 订单状态
  num order_status;

  // 订单号
  String order_id;

  // 订单创建时间
  String created_at;

  // 支付方式
  num paid_type;

  // 最终支付金额
  num final_total_amount;

  // 结算金额
  num paid_amount;

  // 汇款信息Id（支付流水号）
  num paid_id;

  // 物流费用
  num shipping_fee;

  // 是否运费分摊 10：  20：
  num separate_shipping_fee;

  num make_invoice;

  num init_shipping_fee;

  num order_split_status;

  num quality_file_required;

  num used_coupon;
  num used_total_points;

  String parent_order_id;
  String sub_order_created_at;

  num anomal_check;
  num change_price;
  String customer_code;
  String customer_id;
  String customer_name;
  String customer_name_alias;
  num customer_verify;
  num customer_verify_status;
  num delete_status;
  num id;
  String login_account;
  num member_id;
  num order_number;
  num order_role;
  num parent_warehouse_id;
  String role_id;
  String role_name;
  num shop_id;
  num warehouse_id;

  List<XFSFinalPaidTypeModel> finalPaidTypeList() {
    List<XFSFinalPaidTypeModel> modelList = List();
    List list = json.decode(final_paid_type);
    if (list != null && list.length > 0) {
      list.forEach((element) {
        XFSFinalPaidTypeModel model = XFSFinalPaidTypeModel.fromJson(element);
        modelList.add(model);
      });
    }
    return modelList;
  }

  // 本地字段
  String finalPaidType;

  XFSOrderBase({this.order_status,
    this.anomal_check,
    this.change_price,
    this.created_at,
    this.customer_code,
    this.customer_id,
    this.customer_name,
    this.customer_name_alias,
    this.customer_verify,
    this.customer_verify_status,
    this.delete_status,
    this.final_paid_type,
    this.final_total_amount,
    this.id,
    this.init_shipping_fee,
    this.login_account,
    this.make_invoice,
    this.member_id,
    this.order_id,
    this.order_number,
    this.order_role,
    this.order_split_status,
    this.paid_amount,
    this.paid_id,
    this.paid_type,
    this.parent_order_id,
    this.parent_warehouse_id,
    this.quality_file_required,
    this.role_id,
    this.role_name,
    this.separate_shipping_fee,
    this.shipping_fee,
    this.shop_id,
    this.sub_order_created_at,
    this.used_coupon,
    this.used_total_points,
    this.warehouse_id});

  factory XFSOrderBase.fromJson(Map<String, dynamic> json) {
    return XFSOrderBase(
      final_paid_type: json['final_paid_type'],
      anomal_check: json['anomal_check'],
      change_price: json['change_price'],
      created_at: json['created_at'],
      customer_code: json['customer_code'],
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      customer_name_alias: json['customer_name_alias'],
      customer_verify: json['customer_verify'],
      customer_verify_status: json['customer_verify_status'],
      delete_status: json['delete_status'],
      final_total_amount: json['final_total_amount'],
      id: json['id'],
      init_shipping_fee: json['init_shipping_fee'],
      login_account: json['login_account'],
      make_invoice: json['make_invoice'],
      member_id: json['member_id'],
      order_id: json['order_id'],
      order_number: json['order_number'],
      order_role: json['order_role'],
      order_split_status: json['order_split_status'],
      order_status: json['order_status'],
      paid_amount: json['paid_amount'],
      paid_id: json['paid_id'],
      paid_type: json['paid_type'],
      parent_order_id: json['parent_order_id'],
      parent_warehouse_id: json['parent_warehouse_id'],
      quality_file_required: json['quality_file_required'],
      role_id: json['role_id'],
      role_name: json['role_name'],
      separate_shipping_fee: json['separate_shipping_fee'],
      shipping_fee: json['shipping_fee'],
      shop_id: json['shop_id'],
      sub_order_created_at: json['sub_order_created_at'],
      used_coupon: json['used_coupon'],
      used_total_points: json['used_total_points'],
      warehouse_id: json['warehouse_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anomal_check'] = this.anomal_check;
    data['change_price'] = this.change_price;
    data['created_at'] = this.created_at;
    data['customer_code'] = this.customer_code;
    data['customer_id'] = this.customer_id;
    data['customer_name'] = this.customer_name;
    data['customer_name_alias'] = this.customer_name_alias;
    data['customer_verify'] = this.customer_verify;
    data['customer_verify_status'] = this.customer_verify_status;
    data['delete_status'] = this.delete_status;
    data['final_total_amount'] = this.final_total_amount;
    data['id'] = this.id;
    data['init_shipping_fee'] = this.init_shipping_fee;
    data['login_account'] = this.login_account;
    data['make_invoice'] = this.make_invoice;
    data['member_id'] = this.member_id;
    data['order_id'] = this.order_id;
    data['order_number'] = this.order_number;
    data['order_role'] = this.order_role;
    data['order_split_status'] = this.order_split_status;
    data['order_status'] = this.order_status;
    data['paid_amount'] = this.paid_amount;
    data['paid_id'] = this.paid_id;
    data['paid_type'] = this.paid_type;
    data['parent_order_id'] = this.parent_order_id;
    data['parent_warehouse_id'] = this.parent_warehouse_id;
    data['quality_file_required'] = this.quality_file_required;
    data['role_id'] = this.role_id;
    data['role_name'] = this.role_name;
    data['separate_shipping_fee'] = this.separate_shipping_fee;
    data['shipping_fee'] = this.shipping_fee;
    data['shop_id'] = this.shop_id;
    data['sub_order_created_at'] = this.sub_order_created_at;
    data['used_coupon'] = this.used_coupon;
    data['used_total_points'] = this.used_total_points;
    data['warehouse_id'] = this.warehouse_id;
    if (this.final_paid_type != null) {
      data['final_paid_type'] = this.final_paid_type;
    }
    return data;
  }
}

/// XFSOrderExt
class XFSOrderExt {
  // 收货人-省名称
  String receiver_province_name;

  // 收货人-城市名称
  String receiver_city_name;

  // 收货人-区域名称
  String receiver_area_name;

  // 收货人-街名称
  String receiver_town_name;

  // 收货人-详细地址
  String receiver_detail_address;

  // 资质文件份数 （>4 = 4）
  num file_copies;

  // 是否带红章 10：带红章 其他：不带红章
  num original_file;

  // 预计时间
  num modify_may_arrived;

  // 配送方式 10:快递 20:快运 21:快运-站点自提 30:专车包车 40:鑫方盛物流(data.restricted_items_exist=true:物流配送) 50:上门自提
  num sent_type;

  // 最终配送方式 10:快递 20:快运 21:快运-站点自提 30:专车包车 40:鑫方盛物流(data.restricted_items_exist=true:物流配送) 50:上门自提
  num final_sent_type;

  String audit_pass_at;
  num belong_groupId;
  String branch_contacts;
  String branch_department;
  String branch_name;
  String branch_phone;
  String cancel_at;
  String create_at;
  String customer_email;
  String customer_landline_phone;
  num customer_type;
  String deliver_name;
  String deliver_phone;
  String delivery_at;
  String distribute_at;
  String driver_name;
  String driver_phone;
  String express_company;
  String express_num;

  num ip;
  String lat;
  num limit_line;
  num limit_time;
  String lng;
  String may_arrived_begin;
  String may_arrived_in;
  num member_organization_id;
  String member_organization_name;

  num order_big_type;
  String order_id;
  String order_success_at;
  num order_type;
  String organization_name;

  String paid_at;
  num platform;
  String predict_delivery_at;
  num prescription;
  String received_at;
  String receiver_area;
  String receiver_city;
  String receiver_detail_address_alias;
  String receiver_province;
  String receiver_town;
  num rollback_tag;
  num sales_manager_id;
  String sales_manager_name;
  String sales_manager_phone;
  num secondary_sent_type;
  String self_take_in;
  String self_take_phone;
  String self_take_shop;
  String self_take_warehouse;

  num ship_add_id;
  String ship_at;
  num shop_customer_type;
  num source;
  num temp_address;
  String trade_closed_at;
  String trade_finished_at;
  String verify_code;
  num version_code;
  String wanna_arrived_begin;
  String wanna_arrived_in;
  num wanna_arrived_time_by;

  XFSOrderExt({this.audit_pass_at,
    this.belong_groupId,
    this.branch_contacts,
    this.branch_department,
    this.branch_name,
    this.branch_phone,
    this.cancel_at,
    this.create_at,
    this.customer_email,
    this.customer_landline_phone,
    this.customer_type,
    this.deliver_name,
    this.deliver_phone,
    this.delivery_at,
    this.distribute_at,
    this.driver_name,
    this.driver_phone,
    this.express_company,
    this.express_num,
    this.file_copies,
    this.final_sent_type,
    this.ip,
    this.lat,
    this.limit_line,
    this.limit_time,
    this.lng,
    this.may_arrived_begin,
    this.may_arrived_in,
    this.member_organization_id,
    this.member_organization_name,
    this.modify_may_arrived,
    this.order_big_type,
    this.order_id,
    this.order_success_at,
    this.order_type,
    this.organization_name,
    this.original_file,
    this.paid_at,
    this.platform,
    this.predict_delivery_at,
    this.prescription,
    this.received_at,
    this.receiver_area,
    this.receiver_area_name,
    this.receiver_city,
    this.receiver_city_name,
    this.receiver_detail_address,
    this.receiver_detail_address_alias,
    this.receiver_province,
    this.receiver_province_name,
    this.receiver_town,
    this.receiver_town_name,
    this.rollback_tag,
    this.sales_manager_id,
    this.sales_manager_name,
    this.sales_manager_phone,
    this.secondary_sent_type,
    this.self_take_in,
    this.self_take_phone,
    this.self_take_shop,
    this.self_take_warehouse,
    this.sent_type,
    this.ship_add_id,
    this.ship_at,
    this.shop_customer_type,
    this.source,
    this.temp_address,
    this.trade_closed_at,
    this.trade_finished_at,
    this.verify_code,
    this.version_code,
    this.wanna_arrived_begin,
    this.wanna_arrived_in,
    this.wanna_arrived_time_by});

  factory XFSOrderExt.fromJson(Map<String, dynamic> json) {
    return XFSOrderExt(
      audit_pass_at: json['audit_pass_at'],
      belong_groupId: json['belong_groupId'],
      branch_contacts: json['branch_contacts'],
      branch_department: json['branch_department'],
      branch_name: json['branch_name'],
      branch_phone: json['branch_phone'],
      cancel_at: json['cancel_at'],
      create_at: json['create_at'],
      customer_email: json['customer_email'],
      customer_landline_phone: json['customer_landline_phone'],
      customer_type: json['customer_type'],
      deliver_name: json['deliver_name'] ?? '',
      deliver_phone: json['deliver_phone'] ?? '',
      delivery_at: json['delivery_at'],
      distribute_at: json['distribute_at'],
      driver_name: json['driver_name'] ?? '',
      driver_phone: json['driver_phone'] ?? '',
      express_company: json['express_company'],
      express_num: json['express_num'],
      file_copies: json['file_copies'],
      final_sent_type: json['final_sent_type'],
      ip: json['ip'],
      lat: json['lat'],
      limit_line: json['limit_line'],
      limit_time: json['limit_time'],
      lng: json['lng'],
      may_arrived_begin: json['may_arrived_begin'],
      may_arrived_in: json['may_arrived_in'],
      member_organization_id: json['member_organization_id'],
      member_organization_name: json['member_organization_name'],
      modify_may_arrived: json['modify_may_arrived'],
      order_big_type: json['order_big_type'],
      order_id: json['order_id'],
      order_success_at: json['order_success_at'],
      order_type: json['order_type'],
      organization_name: json['organization_name'],
      original_file: json['original_file'],
      paid_at: json['paid_at'],
      platform: json['platform'],
      predict_delivery_at: json['predict_delivery_at'],
      prescription: json['prescription'],
      received_at: json['received_at'],
      receiver_area: json['receiver_area'],
      receiver_area_name: json['receiver_area_name'],
      receiver_city: json['receiver_city'],
      receiver_city_name: json['receiver_city_name'],
      receiver_detail_address: json['receiver_detail_address'],
      receiver_detail_address_alias: json['receiver_detail_address_alias'],
      receiver_province: json['receiver_province'],
      receiver_province_name: json['receiver_province_name'],
      receiver_town: json['receiver_town'],
      receiver_town_name: json['receiver_town_name'],
      rollback_tag: json['rollback_tag'],
      sales_manager_id: json['sales_manager_id'],
      sales_manager_name: json['sales_manager_name'],
      sales_manager_phone: json['sales_manager_phone'],
      secondary_sent_type: json['secondary_sent_type'],
      self_take_in: json['self_take_in'],
      self_take_phone: json['self_take_phone'],
      self_take_shop: json['self_take_shop'],
      self_take_warehouse: json['self_take_warehouse'],
      sent_type: json['sent_type'],
      ship_add_id: json['ship_add_id'],
      ship_at: json['ship_at'],
      shop_customer_type: json['shop_customer_type'],
      source: json['source'],
      temp_address: json['temp_address'],
      trade_closed_at: json['trade_closed_at'],
      trade_finished_at: json['trade_finished_at'],
      verify_code: json['verify_code'],
      version_code: json['version_code'],
      wanna_arrived_begin: json['wanna_arrived_begin'],
      wanna_arrived_in: json['wanna_arrived_in'],
      wanna_arrived_time_by: json['wanna_arrived_time_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audit_pass_at'] = this.audit_pass_at;
    data['belong_groupId'] = this.belong_groupId;
    data['branch_contacts'] = this.branch_contacts;
    data['branch_department'] = this.branch_department;
    data['branch_name'] = this.branch_name;
    data['branch_phone'] = this.branch_phone;
    data['cancel_at'] = this.cancel_at;
    data['create_at'] = this.create_at;
    data['customer_email'] = this.customer_email;
    data['customer_landline_phone'] = this.customer_landline_phone;
    data['customer_type'] = this.customer_type;
    data['delivery_at'] = this.delivery_at;
    data['distribute_at'] = this.distribute_at;
    data['express_company'] = this.express_company;
    data['express_num'] = this.express_num;
    data['file_copies'] = this.file_copies;
    data['final_sent_type'] = this.final_sent_type;
    data['ip'] = this.ip;
    data['lat'] = this.lat;
    data['limit_line'] = this.limit_line;
    data['limit_time'] = this.limit_time;
    data['lng'] = this.lng;
    data['may_arrived_begin'] = this.may_arrived_begin;
    data['may_arrived_in'] = this.may_arrived_in;
    data['member_organization_id'] = this.member_organization_id;
    data['member_organization_name'] = this.member_organization_name;
    data['modify_may_arrived'] = this.modify_may_arrived;
    data['order_big_type'] = this.order_big_type;
    data['order_id'] = this.order_id;
    data['order_success_at'] = this.order_success_at;
    data['order_type'] = this.order_type;
    data['organization_name'] = this.organization_name;
    data['original_file'] = this.original_file;
    data['paid_at'] = this.paid_at;
    data['platform'] = this.platform;
    data['predict_delivery_at'] = this.predict_delivery_at;
    data['prescription'] = this.prescription;
    data['received_at'] = this.received_at;
    data['receiver_area'] = this.receiver_area;
    data['receiver_area_name'] = this.receiver_area_name;
    data['receiver_city'] = this.receiver_city;
    data['receiver_city_name'] = this.receiver_city_name;
    data['receiver_detail_address'] = this.receiver_detail_address;
    data['receiver_detail_address_alias'] = this.receiver_detail_address_alias;
    data['receiver_province'] = this.receiver_province;
    data['receiver_province_name'] = this.receiver_province_name;
    data['receiver_town'] = this.receiver_town;
    data['receiver_town_name'] = this.receiver_town_name;
    data['rollback_tag'] = this.rollback_tag;
    data['sales_manager_id'] = this.sales_manager_id;
    data['sales_manager_name'] = this.sales_manager_name;
    data['sales_manager_phone'] = this.sales_manager_phone;
    data['secondary_sent_type'] = this.secondary_sent_type;
    data['self_take_in'] = this.self_take_in;
    data['self_take_phone'] = this.self_take_phone;
    data['self_take_shop'] = this.self_take_shop;
    data['self_take_warehouse'] = this.self_take_warehouse;
    data['sent_type'] = this.sent_type;
    data['ship_add_id'] = this.ship_add_id;
    data['ship_at'] = this.ship_at;
    data['shop_customer_type'] = this.shop_customer_type;
    data['source'] = this.source;
    data['temp_address'] = this.temp_address;
    data['trade_closed_at'] = this.trade_closed_at;
    data['trade_finished_at'] = this.trade_finished_at;
    data['verify_code'] = this.verify_code;
    data['version_code'] = this.version_code;
    data['wanna_arrived_begin'] = this.wanna_arrived_begin;
    data['wanna_arrived_in'] = this.wanna_arrived_in;
    data['wanna_arrived_time_by'] = this.wanna_arrived_time_by;
    if (this.deliver_name != null) {
      data['deliver_name'] = this.deliver_name;
    }
    if (this.deliver_phone != null) {
      data['deliver_phone'] = this.deliver_phone;
    }
    if (this.driver_name != null) {
      data['driver_name'] = this.driver_name;
    }
    if (this.driver_phone != null) {
      data['driver_phone'] = this.driver_phone;
    }
    return data;
  }
}


class XFSOrderCancle {
  // 取消角色（操作人）10：用户 20：平台管理员 其他：系统管理员
  int cancel_role;

  // 取消原因Code
  int cancle_reason;

  // 操作时间
  String created_at;

  // 驳回原因
  String cancel_remark;

  // 取消原因
  String cancle_name;

  int cancel_order_status;
  int id;
  int member_id;
  String operate_userid;
  String operate_username;
  String order_id;
  int shop_id;
  String status_updated_at;
  int warehouse_id;

  XFSOrderCancle({this.cancel_order_status,
    this.cancel_remark,
    this.cancel_role,
    this.cancle_name,
    this.cancle_reason,
    this.created_at,
    this.id,
    this.member_id,
    this.operate_userid,
    this.operate_username,
    this.order_id,
    this.shop_id,
    this.status_updated_at,
    this.warehouse_id});

  factory XFSOrderCancle.fromJson(Map<String, dynamic> json) {
    return XFSOrderCancle(
      cancel_order_status: json['cancel_order_status'],
      cancel_remark: json['cancel_remark'],
      cancel_role: json['cancel_role'],
      cancle_name: json['cancle_name'],
      cancle_reason: json['cancle_reason'],
      created_at: json['created_at'],
      id: json['id'],
      member_id: json['member_id'],
      operate_userid: json['operate_userid'],
      operate_username: json['operate_username'],
      order_id: json['order_id'],
      shop_id: json['shop_id'],
      status_updated_at: json['status_updated_at'],
      warehouse_id: json['warehouse_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancel_order_status'] = this.cancel_order_status;
    data['cancel_remark'] = this.cancel_remark;
    data['cancel_role'] = this.cancel_role;
    data['cancle_name'] = this.cancle_name;
    data['cancle_reason'] = this.cancle_reason;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['member_id'] = this.member_id;
    data['order_id'] = this.order_id;
    data['shop_id'] = this.shop_id;
    data['status_updated_at'] = this.status_updated_at;
    data['warehouse_id'] = this.warehouse_id;
    data['operate_userid'] = this.operate_userid;
    data['operate_username'] = this.operate_username;
    return data;
  }
}

/// 订单详情备注对象
class XFSOrderRemark {
  // 备注内容
  String remark;
  String bus_id;
  num bus_type;
  String created_at;
  num id;
  num operate_type;
  num operate_userid;
  String operate_username;
  num operator_role;
  String updated_at;

  XFSOrderRemark({this.bus_id,
    this.bus_type,
    this.created_at,
    this.id,
    this.operate_type,
    this.operate_userid,
    this.operate_username,
    this.operator_role,
    this.remark,
    this.updated_at});

  factory XFSOrderRemark.fromJson(Map<String, dynamic> json) {
    return XFSOrderRemark(
      bus_id: json['bus_id'],
      bus_type: json['bus_type'],
      created_at: json['created_at'],
      id: json['id'],
      operate_type: json['operate_type'],
      operate_userid: json['operate_userid'],
      operate_username: json['operate_username'],
      operator_role: json['operator_role'],
      remark: json['remark'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bus_id'] = this.bus_id;
    data['bus_type'] = this.bus_type;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['operate_type'] = this.operate_type;
    data['operate_userid'] = this.operate_userid;
    data['operate_username'] = this.operate_username;
    data['operator_role'] = this.operator_role;
    data['remark'] = this.remark;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

///最终支付模型（组合支付）
class XFSFinalPaidTypeModel {
  // 支付方式代码
  int code;

  // 支付金额
  num amount;
  String accountId;
  String companyCode;

  XFSFinalPaidTypeModel(
      {this.accountId, this.amount, this.code, this.companyCode});

  factory XFSFinalPaidTypeModel.fromJson(Map<String, dynamic> json) {
    return XFSFinalPaidTypeModel(
      accountId: json['accountId'],
      amount: json['amount'],
      code: json['code'],
      companyCode: json['companyCode'],
    );
  }

  /// 物流信息模型
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['amount'] = this.amount;
    data['code'] = this.code;
    data['companyCode'] = this.companyCode;
    return data;
  }

  fromJson(i) {}
}