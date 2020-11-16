import 'dart:core';

import 'dart:core';

/// total : 1
/// errorMessage : "调用成功!"
/// errorCode : 0
/// pageSize : "100"
/// list : [{"lng":"116.42016446643461","detail_address":"海鑫北路9号","warehouse_code":"1","city_code":"110100","addressPersonList":[{"receiverId":"0","createTime":"2019-01-14 11:00:32.0","receiverName":"刘仁河","mobile":"1**24563569","id":"3573","addressId":"2928","status":"0"}],"add_alias":"鑫方盛","is_default":"2","province_code":"110000","street_code":"","office_phone":"","ship_add_id":2928,"streetName":"","cityName":"北京市","areaLimitLine":"0","province_id":43543,"areaName":"大兴区","district_code":"110115","limitLine":20,"district_id":39529,"provinceName":"北京市","street_id":0,"email":"","lat":"39.72321355992667","city_id":43153}]
/// xMapTotal : {"total":1}
/// pageNum : "1"

///{"total":22,"errorMessage":"调用成功!","errorCode":0,"pageSize":"1","list":[{"lng":"116.44955872950158","detail_address":"兔来了","warehouse_code":"1","city_code":"110100","addressPersonList":[{"receiverId":"0","createTime":"2018-09-25 20:45:09.0","receiverName":"统计局","mobile":"1**01402058","id":"1590","addressId":"1512","status":"0"}],"add_alias":"斤斤计较","is_default":"2","province_code":"110000","street_
class XFSAddressModel {

  String lng;
  String detailAddress;
  String warehouseCode;
  String cityCode;
  List<AddressPersonList> addressPersonList;
  String addAlias;
  String isDefault;
  String provinceCode;
  String streetCode;
  String officePhone;
  int shipAddId;
  String streetName;
  String cityName;
  String areaLimitLine;
  int provinceId;
  String areaName;
  String districtCode;
  int limitLine;
  int districtId;
  String provinceName;
  int streetId;
  String email;
  String lat;
  int cityId;
  bool isSelected;

  XFSAddressModel(
      {this.lng,
      this.detailAddress,
      this.warehouseCode,
      this.cityCode,
      this.addressPersonList,
      this.addAlias,
      this.isDefault,
      this.provinceCode,
      this.streetCode,
      this.officePhone,
      this.shipAddId,
      this.streetName,
      this.cityName,
      this.areaLimitLine,
      this.provinceId,
      this.areaName,
      this.districtCode,
      this.limitLine,
      this.districtId,
      this.provinceName,
      this.streetId,
      this.email,
      this.lat,
      this.cityId,
      this.isSelected
      });

  XFSAddressModel.fromJson(Map<String, dynamic> json) {
    lng = json['lng'];
    detailAddress = json['detail_address'];
    warehouseCode = json['warehouse_code'];
    cityCode = json['city_code'];
    if (json['addressPersonList'] != null) {
      addressPersonList = new List<AddressPersonList>();
      json['addressPersonList'].forEach((v) {
        addressPersonList.add(new AddressPersonList.fromJson(v));
      });
    }
    addAlias = json['add_alias'];
    isDefault = json['is_default'];
    provinceCode = json['province_code'];
    streetCode = json['street_code'];
    officePhone = json['office_phone'];
    shipAddId = json['ship_add_id'];
    streetName = json['streetName'];
    cityName = json['cityName'];
    areaLimitLine = json['areaLimitLine'];
    provinceId = json['province_id'];
    areaName = json['areaName'];
    districtCode = json['district_code'];
    limitLine = json['limitLine'];
    districtId = json['district_id'];
    provinceName = json['provinceName'];
    streetId = json['street_id'];
    email = json['email'];
    lat = json['lat'];
    cityId = json['city_id'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lng'] = this.lng;
    data['detail_address'] = this.detailAddress;
    data['warehouse_code'] = this.warehouseCode;
    data['city_code'] = this.cityCode;
    if (this.addressPersonList != null) {
      data['addressPersonList'] =
          this.addressPersonList.map((v) => v.toJson()).toList();
    }
    data['add_alias'] = this.addAlias;
    data['is_default'] = this.isDefault;
    data['province_code'] = this.provinceCode;
    data['street_code'] = this.streetCode;
    data['office_phone'] = this.officePhone;
    data['ship_add_id'] = this.shipAddId;
    data['streetName'] = this.streetName;
    data['cityName'] = this.cityName;
    data['areaLimitLine'] = this.areaLimitLine;
    data['province_id'] = this.provinceId;
    data['areaName'] = this.areaName;
    data['district_code'] = this.districtCode;
    data['limitLine'] = this.limitLine;
    data['district_id'] = this.districtId;
    data['provinceName'] = this.provinceName;
    data['street_id'] = this.streetId;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['city_id'] = this.cityId;
    return data;
  }
}

class AddressPersonList {
  String receiverId;
  String createTime;
  String receiverName;
  String mobile;
  String id;
  String addressId;
  String status;

  AddressPersonList(
      {this.receiverId,
      this.createTime,
      this.receiverName,
      this.mobile,
      this.id,
      this.addressId,
      this.status});

  AddressPersonList.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    createTime = json['createTime'];
    receiverName = json['receiverName'];
    mobile = json['mobile'];
    id = json['id'];
    addressId = json['addressId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiverId'] = this.receiverId;
    data['createTime'] = this.createTime;
    data['receiverName'] = this.receiverName;
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    data['addressId'] = this.addressId;
    data['status'] = this.status;
    return data;
  }
}

