import 'package:flutter_facebook/models/xfs_order_approval_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

///审批流列表
class XFSOrderApprovalProcessListPresent
    extends XFSBasePresenter<xfs_order_approval_process_listview> {
  XFSOrderApprovalProcessListPresent(XFSBaseView mView) : super(mView);
  List<XFSOrderApprovalModel> modelList = List();
  Map<String, dynamic> _xfsMineIntegralModel;
  List<XFSOrderApprovalModel> list = List();
  List<XFSOrderApprovalModel> dataList = List();

  orderApprovalProgressApi(
      {String order_id, Function(Map<String, dynamic>) result}) {
    mView?.showPageLoading();
    ScreenServer.orderApprovalProgress(
        orderId: order_id,
        successBlock: (model) {
          mView?.hidePageLoading();
          List resList;
          list.clear();
          list.add(XFSOrderApprovalModel());
          if (model.data != null) {
            resList = model?.data;
          }
          resList?.forEach((element) {
            list.add(XFSOrderApprovalModel.fromJson(element));
          });
           dataList.addAll(list.where((element) =>
          !(10 == element.account_type && (10 == element.is_approve || 10 == element.join_approval_tag))));
          mView?.showData(data: dataList);
        },
        failureBlock: (model) {
          mView?.hidePageLoading();
        });
  }


}
class xfs_order_approval_process_listview extends XFSBaseListView{}
