import 'package:flutter_facebook/address/xfs_address_model.dart';
import 'package:flutter_facebook/address/xfs_address_server.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';
import 'package:xfs_flutter_utils/utils/xfs_log_util.dart';


class XFSAddressListPresenter extends XFSBasePresenter<XFSBaseListView> {
  XFSAddressModel _pageModel;
  XFSAddressListPresenter(XFSBaseView mView) : super(mView);
  List<XFSAddressModel> modelList = List();
  Map<String, dynamic> _xfsMineIntegralModel;

  ///地址列表获取
  refreshData({Map params, Function(Map<String, dynamic>) result}) {
    mView?.showPageLoading();
    XFSAddressServer.getAddressList(
      params: params,
      successBlock: (res) {
        XFSLogUtil.info( "地址接口   正确---${res.total.toString()}");
        List list = res.list;
        if(params['pageNum']==1){
          modelList.clear();
          mView.refreshEnd(has: true);
        }
        list.forEach((element) {
          modelList.add(XFSAddressModel.fromJson(element));
        });
        mView.showData(data:modelList);
        mView.hidePageLoading();

        if(params['pageNum']==1) return;
        if (modelList.length < res.total) {
          mView?.loadingEnd(has: true);
        }else{
          mView?.loadingEnd(has: false);
        }
      },
       failureBlock : (error) {
         XFSLogUtil.info( "地址接口   错误---${error.sub_code.toString()}");
        mView?.hidePageLoading();
      },
    );
  }

  void removeElements(XFSAddressModel entity) {
    modelList.remove(entity);
    mView.showData(data: modelList);
  }

}