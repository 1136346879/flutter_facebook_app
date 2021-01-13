import 'package:flutter/material.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/page_controller/DialogSelectSpecController.dart';
import 'package:flutter_facebook/page_controller/DialogSelectSpecListController.dart';
import 'package:xfs_flutter_utils/base/xfs_get_base_tabbar_page.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

///
///       创建时间：2020/12/31
///       修改人  ：zhangyan
///       描述    ：规格选择页面
///

class DialogSelectSpecPage extends XFSGetBaseTabbarPage {
  final int spuId;
  final List<String> listColors;

  DialogSelectSpecPage({this.spuId,this.listColors});
  @override
  XFSGetBaseTabbarPageState<XFSGetBaseTabbarPage, Object,
      XFSBasePageController> getState() {
    return _DialogSelectSpecPageState();
  }
}

class _DialogSelectSpecPageState
    extends XFSGetBaseTabbarPageState<DialogSelectSpecPage, Object, DialogSelectSpecController> {
  @override
  bool get  useController => true;
  @override
  void initState() {
    super.initState();
    baseC.getGoodsDetialData(spuId:widget.spuId);
  }
   @override
  List<Widget> buildTabViews() {
    return tabs.map((e) =>  DialogSelectSpecListPage(spuId:widget.spuId)).toList();
  }

  @override
  List<Widget> buildTabs() {
    return    tabs.map((e) => Tab(text: e)).toList();
  }

  @override
  bool get onWillPop => false;

  @override
  bool get isUseSafeArea => true;
  @override
  bool get wantKeepAlive => true;
  @override
  List get tabs => widget?.listColors?.toList() ;
  @override
  bool get isShowHeader => false;
  @override
  XFSTabbarTheme get theme => XFSTabbarTheme(isScrollable: true,indicatorSize: TabBarIndicatorSize.tab);

  @override
  DialogSelectSpecController initController() {
    return DialogSelectSpecController();
  }
}
class DialogSelectSpecListPage extends XFSGetBaseListPage {
  final int spuId;

  DialogSelectSpecListPage({this.spuId});

  @override
  XFSGetBaseListPageState<XFSGetBaseListPage, Object, XFSBaseListPageController>
      getState() => _DialogSelectSpecListPageState();
}

class _DialogSelectSpecListPageState extends XFSGetBaseListPageState<
    DialogSelectSpecListPage, GoodsDetailModel, DialogSelectSpecListController> {
  @override
  bool get isShowHeader => false;

  @override
  void initState() {
    super.initState();
    baseC.getGoodsDetialData(spuId: widget.spuId);
  }

  @override
  Widget buildItem(GoodsDetailModel object, int index) {
    return XFSText.normal('${object.color}--$index');
  }

  @override
  void onLoadMore() {}

  @override
  void onRefresh() {}

  @override
  DialogSelectSpecListController initController() {
    return DialogSelectSpecListController();
  }
}
