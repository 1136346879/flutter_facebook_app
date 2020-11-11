
import 'dart:collection';

class XFSAddressModel {
  String detail_address;
  XFSAddressModel(this.detail_address);
  XFSAddressModel.fromJson(LinkedHashMap<String, dynamic> json){
    detail_address = json['detail_address'];
  }
}