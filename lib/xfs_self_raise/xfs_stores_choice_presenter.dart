
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_stores_choice_server.dart';

class XFSStoreChoicePresenter extends XFSBasePresenter {
  XFSStoreChoicePresenter(XFSBaseView mView) : super(mView);
  List<xfsSelfRaiseSearchModel> storeList = List();
   getStores(String id)  {
      mView?.showPageLoading();
     XFSStoresChoiceServer.getStoreList(successBlock: (val){
       mView?.hidePageLoading();
       val.data.forEach((it) {
         storeList.add(xfsSelfRaiseSearchModel.fromJson(it));
       });
       if (storeList.isNotEmpty) {
         storeList.forEach((element) {
           element.isSelected = element.ship_add_id==id;
         });
         mView.showData(data: storeList);
       }
     },
     failureBlock: (val){
       mView?.showEmptyView(state:EmptyViewType.ERROR);
       mView?.hidePageLoading();
     });
  }

}
