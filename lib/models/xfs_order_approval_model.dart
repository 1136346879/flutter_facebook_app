/// 审批流
class XFSOrderApprovalModel {
  /// 订单号
  String order_id;
  /// 用户id
  int member_id;
  ///账户类型:10=>审批帐号；20=>结算账号；30=>下单账号
  int account_type;
  /// 登录帐号
  String login_account;
  /// 审核状态：0=>未审批 ；10=>通过  ;20=>未通过
  int verify_status;
  /// 审批序列号（数字越小越优先审核）
  int approve_seq;
  /// 是否必须审批：10=>否；20=>是
  // 会员系统设置
  int is_approve;

  /// 是否参与审批：10=>否，20=>是
  //  如 审批序列：A A B  审批账号A不参与审批 审批账号A此字段为10
  //  审批序列：A AB B  审批账号AB不参与审批 审批账号AB此字段为10
  //  审批序列：A B B  审批账号AB不参与审批 审批账号B此字段为10
  //  审批序列：A C B  审批账号C参与审批 审批账号C此字段为20
  int join_approval_tag;
  /// 审批人姓名
  String employ_user;
  /// 创建时间
  String created_at;
  /// 审核时间
  String operated_at;
  /// 备注信息
  String remark;
  /// '是否或签: 10-否;20-是'
  int or_sign_tag;
  /// '订单金额限制，小于此数跳过本级审批'
  double order_money_limit;

  /// 审批类型对应的标题
  String get accountTypeTitle => account_type == 30 ? '下单' : account_type == 10 ? '审批' : '结算';
  String get time => account_type == 30 ? created_at : operated_at;

  XFSOrderApprovalModel();
  XFSOrderApprovalModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    order_id = json['order_id'];
    member_id = json['member_id'];
    account_type = json['account_type'];
    login_account = json['login_account'];
    verify_status = json['verify_status'];
    approve_seq = json['approve_seq'];
    is_approve = json['is_approve'];
    join_approval_tag = json['join_approval_tag'];
    employ_user = json['employ_user'];
    created_at = json['created_at'];
    operated_at = json['operated_at'];
    remark = json['remark'];
    or_sign_tag = json['or_sign_tag'];
    order_money_limit = json['order_money_limit'];
  }
}
