import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
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
    return _buildItemSpec(object);
  }

  @override
  bool get hasLoadMore => false;
  @override
  bool get hasRefresh => false;
  @override
  void onLoadMore() {}

  @override
  void onRefresh() {}


  @override
  DialogSelectSpecListController initController() {
    return DialogSelectSpecListController();
  }

  Widget _buildItemSpec(GoodsDetailModel object) {
    return XFSContainer(
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Row(children: [
          Flexible(
              flex: 2,
              child: XFSText.container("${object.color}/${object.subtitile}",maxLines: 2,fontSize: 14,textColor: Config.color333333,padding: EdgeInsets.all(10),)),
          Flexible(
              flex: 1,
              child: XFSText.container("¥${object.salePrice}",fontSize: 14,textColor: Config.color333333,padding: EdgeInsets.all(10),)),
          Flexible(
            flex: 2,
            child: XFSNumberChangeView(
              maxNumber: 9999,
              minNumber: 0,
              multiples:10,
              initNumber: object.selectCount??0,
              numberChange: (val){
                object.selectCount = val;
              },
            ),
          )
        ],),
          Row(children: [
            XFSText.container("商品编码：${object.skuCode}",textColor: Config.color666666,fontSize: 12,padding: EdgeInsets.symmetric(horizontal: 10),),
            XFSText.container(getDayNumString(object),textColor: Config.colorFFA200,fontSize: 12,padding: EdgeInsets.symmetric(horizontal: 10),),
          ],)

        ],
      ),
    );
  }

  String getDayNumString (GoodsDetailModel data){
    // 预计出货日
    int actualStock = data.actualStock;
    int virtualStock = data.virtualStock;
    int arrivalCycle = data.arrivalCycle??0;
    int selectCount = data.selectCount??0;
    /* 预计出货日判断 */
    if (selectCount <= actualStock && actualStock > 0) {
      return "预计出货日：1天";
    } else {
      return "预计出货日：${arrivalCycle + 1}天";
    }
  }
}
