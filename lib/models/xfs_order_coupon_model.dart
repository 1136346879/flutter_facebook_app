/// Created by zhumz
/// Created on 2020/10/29
/// page xfs_order_coupon_model
/// desc 订单详情-优惠券模型

/// 订单详情优惠券对象
class XFSOrderCouponModel {
  // 优惠券金额
  num coupon_value;

  // 优惠券real金额
  num coupon_real_value;

  // 优惠券Code
  String coupon_code;

  // 优惠券说明
  String coupon_desc;

  // 优惠券类型 10：
  num coupon_type;

  // 优惠券订单号
  String order_id;

  // 优惠券创建时间
  String created_time;

  // 优惠券使用条件
  num use_condition;

  num coupon_scope;

  XFSOrderCouponModel(
      {this.coupon_code,
        this.coupon_desc,
        this.coupon_real_value,
        this.coupon_scope,
        this.coupon_type,
        this.coupon_value,
        this.created_time,
        this.order_id,
        this.use_condition});

  factory XFSOrderCouponModel.fromJson(Map<String, dynamic> json) {
    return XFSOrderCouponModel(
      coupon_code: json['coupon_code'],
      coupon_desc: json['coupon_desc'],
      coupon_real_value: json['coupon_real_value'],
      coupon_scope: json['coupon_scope'],
      coupon_type: json['coupon_type'],
      coupon_value: json['coupon_value'],
      created_time: json['created_time'],
      order_id: json['order_id'],
      use_condition: json['use_condition'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_code'] = this.coupon_code;
    data['coupon_desc'] = this.coupon_desc;
    data['coupon_real_value'] = this.coupon_real_value;
    data['coupon_scope'] = this.coupon_scope;
    data['coupon_type'] = this.coupon_type;
    data['coupon_value'] = this.coupon_value;
    data['created_time'] = this.created_time;
    data['order_id'] = this.order_id;
    data['use_condition'] = this.use_condition;
    return data;
  }
}






      