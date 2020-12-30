import 'package:flutter_facebook/net/api.dart';
import 'package:flutter_facebook/net/http_utils.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';

class XFSStoresChoiceServer {
  /// 获取门店列表数据
  static getStoreList(
      {SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.STORE_LIST,API.BASE_URL_xfs_t4,httpMethod: HttpMethod.POSTQUERY,
        success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }
}
