/// Created by zhumz
/// on 2020-10-10
/// XFSOrderRemittanceModel
/// 汇款信息Model

///订单详情-汇款信息
class XFSOrderRemittanceModel {
  // 户名
  String accountName;

  // 账号
  String accountNumber;

  // 开户行
  String bankName;

  // 联行号
  String lineNumber;

  // 仓库Id
  String warehouseId;

  // 订单编号
  String orderId;

  // 状态码
  String code;

  // 状态信息
  String msg;

  // subCode
  String sub_code;

  XFSOrderRemittanceModel({this.accountName, this.accountNumber, this.bankName, this.code, this.lineNumber, this.msg, this.orderId, this.sub_code, this.warehouseId});

  factory XFSOrderRemittanceModel.fromJson(Map<String, dynamic> json) {
    return XFSOrderRemittanceModel(
      accountName: json['accountName'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      code: json['code'],
      lineNumber: json['lineNumber'],
      msg: json['msg'],
      orderId: json['orderId'],
      sub_code: json['sub_code'],
      warehouseId: json['warehouseId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['code'] = this.code;
    data['lineNumber'] = this.lineNumber;
    data['msg'] = this.msg;
    data['orderId'] = this.orderId;
    data['warehouseId'] = this.warehouseId;
    data['sub_code'] = this.sub_code;
    return data;
  }
}