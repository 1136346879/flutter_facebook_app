import 'package:xfs_flutter_utils/utils/xfs_utils.dart';

class xfsSelfRaiseSearchModel {

  String id;
  String distance; //自提地址到当前位置距离，单位米
  bool isLastAddress = false; //是否是上次使用过的自提地址 true 是，false 不是
  String ship_add_id;
  String province_id;
  String district_id;
  String street_id;
  String city_id;
  String warehouse_code;
  String parent_warehouse_code;
  String linkman;
  String address_type;
  String detail_address;
  String add_alias;
  String is_default; //1默认
  String office_phone;
  String cityName;
  String areaName;
  String provinceName;
  String email;
  String streetName;
  String time;
  String limitLine; //10限行 20不限行
  String city_code;
  String province_code;
  String street_code;
  String areaLimitLine;
  String lng; //地址经度
  String lat; //地址纬度
  String district_code;
  String address_source; //20  自提  10 正常地址
  List<AddressPersonListBean> addressPersonList;
  //  //是否选中
  bool isSelected = false;
  String allPinyin;
  String simplePinyin;

  xfsSelfRaiseSearchModel.fromJson(Map<dynamic, dynamic> json) {

    id = json['id'];
    distance = json['distance'].toString();
    isLastAddress = XFSUtils.iOSNSStringToBool(json['isLastAddress']);
    ship_add_id = json['ship_add_id'].toString();
    province_id = json['province_id'].toString();
    district_id = json['district_id'].toString();
    street_id = json['street_id'].toString();
    city_id = json['city_id'].toString();
    warehouse_code = json['warehouse_code'];
    parent_warehouse_code = json['parent_warehouse_code'];
    linkman = json['linkman'];
    address_type = json['address_type'];
    detail_address = json['detail_address'];
    add_alias = json['add_alias'];
    is_default = json['is_default'];
    office_phone = json['office_phone'];
    cityName = json['cityName'];
    areaName = json['areaName'];
    provinceName = json['provinceName'];
    email = json['email'];
    streetName = json['streetName'];
    time = json['time'].toString();
    limitLine = json['limitLine'];
    city_code = json['city_code'];
    province_code = json['province_code'];
    street_code = json['street_code'];
    areaLimitLine = json['areaLimitLine'];
    lng = json['lng'];
    lat = json['lat'];
    district_code = json['district_code'];
    address_source = json['address_source'];
    isSelected = json['isSelected'];
    allPinyin = XFSUtils.stringToPinyin(json['add_alias']).toString().replaceAll(" ", "");
    simplePinyin = XFSUtils.stringToPinyinSimpleFirst(json['add_alias']);
    addressPersonList = XFSUtils.jsonListToModelList(json['addressPersonList'], (value) => AddressPersonListBean.fromJson(value));
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ship_add_id'] = this.ship_add_id;
    data['province_id'] = this.province_id;
    data['province_code'] = this.province_code;
    data['provinceName'] = this.provinceName;
    data['city_id'] = this.provinceName;
    data['city_code'] = this.city_code;
    data['cityName'] = this.cityName;
    data['district_id'] = this.district_id;
    data['district_code'] = this.district_code;
    data['areaName'] = this.areaName;
    data['street_id'] = this.street_id;
    data['street_code'] = this.street_code;
    data['streetName'] = this.streetName;
    data['detail_address'] = this.detail_address;
    data['add_alias'] = this.add_alias;
    data['address_type'] = this.address_type;
    data['office_phone'] = this.office_phone;
    data['email'] = this.email;
    data['is_default'] = this.is_default;
    data['parent_warehouse_code'] = this.parent_warehouse_code;
    data['warehouse_code'] = this.warehouse_code;
    data['limitLine'] = this.limitLine;
    data['address_source'] = this.address_source;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['longitude'] = this.lng;
    data['latitude'] = this.lat;
    data['distance'] = this.distance;
    data['isLastAddress'] = this.isLastAddress;
    return data;
  }

}

class AddressPersonListBean {
  String receiverName;
  num addressId;
  String receiverId;
  String mobile;
  String name;
  String id;
  num status;

  AddressPersonListBean.fromJson(Map<dynamic, dynamic> json) {
    receiverName = json['receiverName'];
    addressId = json['addressId'];
    receiverId = json['receiverId'];
    mobile = json['mobile'];
    name = json['name'];
    id = json['id'];
    status = json['status'];
  }
}
