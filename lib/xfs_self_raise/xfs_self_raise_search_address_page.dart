import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/router/xfs_route_configure.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_item_build_widget.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_search_presenters.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';
/// Created by wdx
/// on 2020-09-17
/// page XFSSelfRaiseSearchAddressPage 自提地址搜索页

class XFSSelfRaiseSearchAddressPage extends XFSBasePage {
  List arguments;

  XFSSelfRaiseSearchAddressPage({this.arguments});

  static push(BuildContext context, List arguments) {
    Navigator.pushNamed(
      context,
      XFSAppRouteConfigure.xfsSelfRaiseSearchAddress,
      arguments: arguments,
    );
  }

  @override
  XFSBasePageState<XFSBasePage, Object, XFSBasePresenter<XFSBaseView>>
      getState() {
    return _xfsSelfRaiseSearchAddressState();
  }
}

class _xfsSelfRaiseSearchAddressState extends XFSBasePageState<
    XFSSelfRaiseSearchAddressPage,
    List<xfsSelfRaiseSearchModel>,
    XFSSelfRaiseSearchPresenter> {
  List<xfsSelfRaiseSearchModel> list = List();
  bool storeList=false;//自提点列表
  @override
  void initState() {
    super.initState();
    list.clear();
    widget.arguments?.forEach((element) {
      if (element.runtimeType == xfsSelfRaiseSearchModel) {
        storeList = true;//门店列表
        list.add(element);
      } else {
        list.add(xfsSelfRaiseSearchModel.fromJson(element));
      }
    });
    presenter.searchSelfRaiseData(list: list, text: "twertertgrthyutjuytij");
  }

  @override
  Widget buildAppBarTitleView() {
    return XFSCupertinoTextField(
      prefix: Icon(
        Icons.search,
        size: 15,
        color: Colors.grey,
      ),
      prefixMode: OverlayVisibilityMode.always,
      clearButtonMode: OverlayVisibilityMode.editing,
      backgroudColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      hintText: storeList ? " 请输入搜索的门店" : " 请输入搜索的自提点",
      maxLines: 1,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      hintTextFontSize: 16.0,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        presenter.searchSelfRaiseData(list: list, text: value);
      },
      onSubmitted: (text) {
        presenter.searchSelfRaiseData(list: list, text: text);
      },
    );
  }

  @override
  Widget buildWidget(
      BuildContext context, List<xfsSelfRaiseSearchModel> searchList) {
    return ListView.builder(
        itemCount: searchList?.length ?? 0,
        itemBuilder: (context, index) {
          return XFSSelfRaiseAddressListItem(
            model: searchList[index],storeList:storeList
          );
        });
  }

  @override
  XFSSelfRaiseSearchPresenter initPresenter() {
    return XFSSelfRaiseSearchPresenter(this);
  }

  @override
  List<Widget> actions() {
    return <Widget>[
      SizedBox(
        height: 20,
        width: 20,
      )
    ];
  }

  @override
  bool get isShowHeader => true;

  @override
  backAction() {
    if(storeList){
      Navigator.pop(context);
    }else XFSCommonUtils.goBackNative();
  }

  @override
  bool get resizeToAvoidBottomPadding => false;

  @override
  String get emptyBtnTitle => "";

  @override
  String get emptyTitle => storeList ?"不好意思，暂时没有找到'相关'门店~":"不好意思，暂时没有找到'相关'自提点~";
}

class XFSSelfRaiseAddressListItem extends StatelessWidget {
  xfsSelfRaiseSearchModel model;
  bool storeList;
  XFSSelfRaiseAddressListItem({this.model,this.storeList}) : super();

  @override
  Widget build(BuildContext context) {
    return XFSSelfItemBuildWidget(model: model,storeList:storeList);
  }
}
