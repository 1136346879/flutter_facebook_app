/// Created by ZhuMZ
/// on 2020-09-25
/// page xfs_order_verify_model
/// 订单详情-审批记录模型

class XFSOrderVerifyRecordModel {
  // 审核状态 0未审核 10已通过 20已驳回
  int verify_status;

  // 操作账号
  String login_account;

  // 操作时间
  String created_at;

  int account_type;
  int approve_seq;
  String employ_user;
  int is_approve;
  int join_approval_tag;
  int member_id;
  String operated_at;
  String order_id;
  String remark;
  String telephone;
  double order_money_limit;
  int or_sign_tag;
  int settle_type;

  String get remarkTrim => remark != null ? remark.trimLeft() : '';

  XFSOrderVerifyRecordModel(
      {this.account_type,
      this.approve_seq,
      this.created_at,
      this.employ_user,
      this.is_approve,
      this.join_approval_tag,
      this.login_account,
      this.member_id,
      this.operated_at,
      this.or_sign_tag,
      this.order_id,
      this.order_money_limit,
      this.remark,
      this.settle_type,
      this.telephone,
      this.verify_status});

  factory XFSOrderVerifyRecordModel.fromJson(Map<String, dynamic> json) {
    return XFSOrderVerifyRecordModel(
      account_type: json['account_type'],
      approve_seq: json['approve_seq'],
      created_at: json['created_at'],
      employ_user: json['employ_user'],
      is_approve: json['is_approve'],
      join_approval_tag: json['join_approval_tag'],
      login_account: json['login_account'],
      member_id: json['member_id'],
      operated_at: json['operated_at'],
      or_sign_tag: json['or_sign_tag'],
      order_id: json['order_id'],
      order_money_limit: json['order_money_limit'],
      remark: json['remark'],
      settle_type: json['settle_type'],
      telephone: json['telephone'],
      verify_status: json['verify_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_type'] = this.account_type;
    data['approve_seq'] = this.approve_seq;
    data['created_at'] = this.created_at;
    data['employ_user'] = this.employ_user;
    data['is_approve'] = this.is_approve;
    data['join_approval_tag'] = this.join_approval_tag;
    data['login_account'] = this.login_account;
    data['member_id'] = this.member_id;
    data['operated_at'] = this.operated_at;
    data['order_id'] = this.order_id;
    data['remark'] = this.remark;
    data['telephone'] = this.telephone;
    data['verify_status'] = this.verify_status;
    data['or_sign_tag'] = this.or_sign_tag;
    data['order_money_limit'] = this.order_money_limit;
    data['settle_type'] = this.settle_type;
    return data;
  }
}
