import 'package:xfs_flutter_utils/widgets/xfs_azlist_view.dart';

class CityListModel {
  List<CityCategory> data;
  String errorMessage;
  int errorCode;

  CityListModel({this.data, this.errorMessage, this.errorCode});

  CityListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CityCategory>();
      json['data'].forEach((v) {
        data.add(new CityCategory.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    data['errorCode'] = this.errorCode;
    return data;
  }
}

class CityCategory {
  String item;
  List<City> list;

  CityCategory({this.item, this.list});

  CityCategory.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    if (json['list'] != null) {
      list = new List<City>();
      json['list'].forEach((v) {
        list.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City extends XFSAZModel{
  Null id;
  int addressId;
  Null warehouseId;
  String code;
  String name;
  String warehouseCode;
  String parentCode;
  int level;
  int isShowChild;

  City(
      {this.id,
        this.addressId,
        this.warehouseId,
        this.code,
        this.name,
        this.warehouseCode,
        this.parentCode,
        this.level,
        this.isShowChild});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressId = json['address_id'];
    warehouseId = json['warehouse_id'];
    code = json['code'];
    name = json['name'];
    warehouseCode = json['warehouse_code'];
    parentCode = json['parent_code'];
    level = json['level'];
    isShowChild = json['is_show_child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_id'] = this.addressId;
    data['warehouse_id'] = this.warehouseId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['warehouse_code'] = this.warehouseCode;
    data['parent_code'] = this.parentCode;
    data['level'] = this.level;
    data['is_show_child'] = this.isShowChild;
    return data;
  }
  @override
  String getSuspensionTag() {
    return tagIndex;
  }

  @override
  String getTitle() {
    return name;
  }
}

