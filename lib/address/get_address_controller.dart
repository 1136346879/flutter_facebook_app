import 'package:flutter_facebook/address/xfs_address_model.dart';
import 'package:flutter_facebook/address/xfs_address_server.dart';
import 'package:xfs_flutter_utils/base/xfs_base_page_controller.dart';
import 'package:xfs_flutter_utils/utils/xfs_log_util.dart';
import 'package:get/get.dart';

///
///       创建时间：2021/1/26
///       修改人  ：zhangyan
///       描述    ：
/// 
class GetAddressController extends  XFSBaseListPageController{
  XFSAddressModel _pageModel;
  List<XFSAddressModel> modelList = List();
  Map<String, dynamic> _xfsMineIntegralModel;

  var count = 0.obs;

  increment() => count++;

  ///地址列表获取
  refreshAddressData({Map params, Function(Map<String, dynamic>) result}) {
    showLoading();
    XFSAddressServer.getAddressList(
      params: params,
      successBlock: (res) {
        XFSLogUtil.info( "地址接口   正确---${res.total.toString()}");
        List list = res.list;
        if(params['pageNum']==1){
          modelList.clear();
          finishRefresh(true, true);
        }
        list.forEach((element) {
          modelList.add(XFSAddressModel.fromJson(element));
        });
        showData(modelList);
          hideLoading();
        if(params['pageNum']==1) return;
        if (modelList.length < res.total) {
          finishRefresh(true, true);
        }else{
          finishRefresh(true, false);
        }
      },
      failureBlock : (error) {
        XFSLogUtil.info( "地址接口   错误---${error.sub_code.toString()}");
        hideLoading();
      },
    );
  }

  void removeElements(XFSAddressModel entity) {
    modelList.remove(entity);
    showData( modelList);
  }
}







      