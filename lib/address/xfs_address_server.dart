
import 'package:flutter_facebook/net/api.dart';
import 'package:flutter_facebook/net/http_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';

import 'xfs_address_model.dart';

class XFSAddressServer {
  static getAddressList(
      {Map params,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    var map = new Map<String, dynamic>();
    map['pageNum'] = 1;
    map['pageSize'] = 100;
    map['type'] = 10;
    map['memberId'] = 1047;
    map['member_id'] = 1047;
    HttpUtils.getDataForCallback(API.ADDRESS_LIST,
        httpMethod: HttpMethod.POSTQUERY, params: map, success: (model) {
      Fluttertoast.showToast(msg: model.errorMessage);
//        XFSAddressModel xfsAddressModel = new XFSAddressModel(model.errorMessage);
//      XFSAddressModel orderPageModel = XFSAddressModel.fromJson(xfsAddressModel);
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }
}
