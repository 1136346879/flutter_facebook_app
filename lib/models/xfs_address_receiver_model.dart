/// Created by ZhuMZ
/// Created on 2020/10/29
/// page xfs_address_receiver_model
/// desc 订单详情 收货人Model

class XFSAddressReceiverModel {
  // 收货人名称
  String receiver_name;

  // 收货人手机号
  String mobile;

  // 订单Id
  String order_id;

  num address_id;
  num id;

  XFSAddressReceiverModel(
      {this.address_id,
        this.id,
        this.mobile,
        this.order_id,
        this.receiver_name});

  factory XFSAddressReceiverModel.fromJson(Map<String, dynamic> json) {
    return XFSAddressReceiverModel(
      address_id: json['address_id'],
      id: json['id'],
      mobile: json['mobile'],
      order_id: json['order_id'],
      receiver_name: json['receiver_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.address_id;
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['order_id'] = this.order_id;
    data['receiver_name'] = this.receiver_name;
    return data;
  }
}






      