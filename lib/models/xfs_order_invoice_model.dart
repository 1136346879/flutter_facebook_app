/// Created by ZhuMZ
/// Created on 2020/10/29
/// page xfs_order_invoice_model
/// desc 发票对象模型

class XFSOrderInvoice {
  // 是否开发票 10：已开 20：未开
  num invoice_sorce;

  // 发票类型 ：10：增值税专用发票 20：普通发票 30：不开发票
  num invoice_type;

  // 10|20|60：未开 30：部分开 其他：已开
  num invoice_status;

  // 订单号
  String order_id;

  // 创建时间
  String create_date;

  // 注册地址
  String register_address;

  // 注册电话
  String register_phone;

  // 开户银行
  String open_bank;

  // 银行账户
  String bank_account;

  // 发票抬头
  String invoice_title;

  // 纳税人识别号
  String taxpayer_identify_num;

  // CRM开票客户ID
  String crm_invoice_id;

  String province;
  String province_name;
  String city;
  String city_name;
  String area;
  String area_name;
  String town;
  String town_name;
  String detail_address;

  // 收件人
  String received_name;

  // 收件人联系方式
  String received_phone;

  // 快递公司
  String logistics_company;

  // 快递单号
  String logistics_num;

  num operator_userid;
  String operator_username;
  String organization_name;
  String invoice_remark;
  num invoice_role;

  num belong_groupId;

  String update_date;
  num id;

  XFSOrderInvoice(
      {this.area,
        this.area_name,
        this.bank_account,
        this.belong_groupId,
        this.city,
        this.city_name,
        this.create_date,
        this.crm_invoice_id,
        this.detail_address,
        this.id,
        this.invoice_remark,
        this.invoice_role,
        this.invoice_sorce,
        this.invoice_status,
        this.invoice_title,
        this.invoice_type,
        this.logistics_company,
        this.logistics_num,
        this.open_bank,
        this.operator_userid,
        this.operator_username,
        this.order_id,
        this.organization_name,
        this.province,
        this.province_name,
        this.received_name,
        this.received_phone,
        this.register_address,
        this.register_phone,
        this.taxpayer_identify_num,
        this.town,
        this.town_name,
        this.update_date});

  factory XFSOrderInvoice.fromJson(Map<String, dynamic> json) {
    return XFSOrderInvoice(
      area: json['area'],
      area_name: json['area_name'],
      bank_account: json['bank_account'],
      belong_groupId: json['belong_groupId'],
      city: json['city'],
      city_name: json['city_name'],
      create_date: json['create_date'],
      crm_invoice_id: json['crm_invoice_id'],
      detail_address: json['detail_address'],
      id: json['id'],
      invoice_remark: json['invoice_remark'],
      invoice_role: json['invoice_role'],
      invoice_sorce: json['invoice_sorce'],
      invoice_status: json['invoice_status'],
      invoice_title: json['invoice_title'],
      invoice_type: json['invoice_type'],
      logistics_company: json['logistics_company'],
      logistics_num: json['logistics_num'],
      open_bank: json['open_bank'],
      operator_userid: json['operator_userid'],
      operator_username: json['operator_username'],
      order_id: json['order_id'],
      organization_name: json['organization_name'],
      province: json['province'],
      province_name: json['province_name'],
      received_name: json['received_name'],
      received_phone: json['received_phone'],
      register_address: json['register_address'],
      register_phone: json['register_phone'],
      taxpayer_identify_num: json['taxpayer_identify_num'],
      town: json['town'],
      town_name: json['town_name'],
      update_date: json['update_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['area_name'] = this.area_name;
    data['bank_account'] = this.bank_account;
    data['belong_groupId'] = this.belong_groupId;
    data['city'] = this.city;
    data['city_name'] = this.city_name;
    data['create_date'] = this.create_date;
    data['crm_invoice_id'] = this.crm_invoice_id;
    data['detail_address'] = this.detail_address;
    data['id'] = this.id;
    data['invoice_remark'] = this.invoice_remark;
    data['invoice_role'] = this.invoice_role;
    data['invoice_sorce'] = this.invoice_sorce;
    data['invoice_status'] = this.invoice_status;
    data['invoice_title'] = this.invoice_title;
    data['invoice_type'] = this.invoice_type;
    data['open_bank'] = this.open_bank;
    data['operator_userid'] = this.operator_userid;
    data['operator_username'] = this.operator_username;
    data['order_id'] = this.order_id;
    data['organization_name'] = this.organization_name;
    data['province'] = this.province;
    data['province_name'] = this.province_name;
    data['received_name'] = this.received_name;
    data['received_phone'] = this.received_phone;
    data['register_address'] = this.register_address;
    data['register_phone'] = this.register_phone;
    data['taxpayer_identify_num'] = this.taxpayer_identify_num;
    data['town'] = this.town;
    data['town_name'] = this.town_name;
    data['update_date'] = this.update_date;
    data['logistics_company'] = this.logistics_company;
    data['logistics_num'] = this.logistics_num;
    return data;
  }
}



 






      