
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

class XFSSelfRaiseSearchPresenter extends XFSBasePresenter<XFSBaseView> {
  XFSSelfRaiseSearchPresenter(XFSBaseView mView) : super(mView);

  List<xfsSelfRaiseSearchModel> searchList = List();

  searchSelfRaiseData({List<xfsSelfRaiseSearchModel> list, String text}) {

    searchList = list.where((element) => (element.add_alias.contains(text)
        || element.allPinyin.contains(text)
        || element.simplePinyin.contains(text)
    )).toList();
    if (searchList.isEmpty){
      mView.showEmptyView(state: EmptyViewType.EMPTY);
    }else{
      mView.showData(data: searchList);
    }
  }
}