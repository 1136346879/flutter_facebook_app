/// Created by ZhuMZ
/// Created on 2020/10/29
/// class xfs_logistics_Info_model
/// desc 物流信息模型

class XFSLogisticsInfoModel {
  String courier;
  String courierPhone;
  String deliverystatus;
  String expName;
  String expPhone;
  String expSite;
  String issign;
  String logo;
  String number;
  String takeTime;
  String type;
  String updateTime;
  List<XFSLogisticsModel> list;

  XFSLogisticsInfoModel(
      {this.courier,
        this.courierPhone,
        this.deliverystatus,
        this.expName,
        this.expPhone,
        this.expSite,
        this.issign,
        this.list,
        this.logo,
        this.number,
        this.takeTime,
        this.type,
        this.updateTime});

  factory XFSLogisticsInfoModel.fromJson(Map<String, dynamic> json) {
    return XFSLogisticsInfoModel(
      courier: json['courier'],
      courierPhone: json['courierPhone'],
      deliverystatus: json['deliverystatus'],
      expName: json['expName'],
      expPhone: json['expPhone'],
      expSite: json['expSite'],
      issign: json['issign'],
      logo: json['logo'],
      number: json['number'],
      takeTime: json['takeTime'],
      type: json['type'],
      updateTime: json['updateTime'],

      list: json['list'] != null
          ? (json['list'] as List)
          .map((i) => XFSLogisticsModel.fromJson(i))
          .toList()
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courier'] = this.courier;
    data['courierPhone'] = this.courierPhone;
    data['deliverystatus'] = this.deliverystatus;
    data['expName'] = this.expName;
    data['expPhone'] = this.expPhone;
    data['expSite'] = this.expSite;
    data['issign'] = this.issign;
    data['logo'] = this.logo;
    data['number'] = this.number;
    data['takeTime'] = this.takeTime;
    data['type'] = this.type;
    data['updateTime'] = this.updateTime;
    data['List'] = this.list;
    return data;
  }
}

class XFSLogisticsModel {
  String status;
  String time;

  XFSLogisticsModel({this.status, this.time});

  factory XFSLogisticsModel.fromJson(Map<String, dynamic> json) {
    return XFSLogisticsModel(
      status: json['status'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}

 






      