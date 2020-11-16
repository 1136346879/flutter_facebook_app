
import 'package:flutter_facebook/net/api.dart';
import 'package:flutter_facebook/net/http_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';

class XFSAddressServer {
  static getAddressList(
      {Map params,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {


    HttpUtils.getDataForCallback(API.ADDRESS_LIST,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POSTQUERY, params: params, success: (model) {
      Fluttertoast.showToast(msg: model.errorMessage);
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }
}
