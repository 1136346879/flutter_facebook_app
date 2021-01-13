import 'package:flutter/material.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_list_page.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:flutter_facebook/router/xfs_route_configure.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_page.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/widgets/xfs_text.dart';

class XFSOrderPage extends XFSBasePage{

  final String arguments;
  final GlobalKey<_XFSOrderPageState> globalKey;
  XFSOrderPage({this.globalKey,@required this.arguments}):super(key: globalKey);

  static pushName(BuildContext context,{String arguments}){
    Navigator.pushNamed(context, XFSAppRouteConfigure.orderPage,arguments: arguments).then((value) => {

    });
  }

  @override
  XFSBasePageState getState() => _XFSOrderPageState();

}

class _XFSOrderPageState extends XFSBasePageState<XFSOrderPage, Object, XFSBasePresenter> with SingleTickerProviderStateMixin{

  List _tabs;
  String _currentTab;
  TabController _tabController;
  PageController _pageController;


  @override
  void initState() {
    super.initState();
    _tabs =XFSOrderUtils.getTabbarTitles();
    _currentTab = widget.arguments??'';

    int index =_tabs.indexOf(XFSOrderUtils.orderTabTitleWithCode(_currentTab??''));

    _tabController = TabController(length: _tabs.length, vsync: this,initialIndex: index);
    _pageController = PageController(initialPage: index);

  }


  @override
  List<Widget> actions() {

    return [
      XFSText.container('订单导出',
        padding: EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.white,
        onTap: (){
          Fluttertoast.showToast(msg: "订单导出");
          // Navigator.pushNamed(context, XFSAppRouteConfigure.consumerProvide);
          Navigator.pushNamed(context, XFSAppRouteConfigure.xfsOrderExportPage);
        },
      ),
    XFSText.container('搜索订单',
      padding: EdgeInsets.only(left: 10, right: 10),
      textColor: Colors.white,
      onTap: (){
      Fluttertoast.showToast(msg: "搜索订单");
        Navigator.pushNamed(context, XFSAppRouteConfigure.orderSearchPage);
      },
    ),
    ];
  }
  @override
  bool get wantKeepAlive => true;
  @override
  String get naviTitle => "我的订单";

  @override
  XFSBasePresenter initPresenter() {}

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return Column(
     children: [
      topBar(),
       Expanded(child: _tabPageView()),
     ],
   );
     Container(
     child: XFSText.normal('${this.runtimeType.toString()}'),
   );
  }

 Widget topBar() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: TabBar(
        tabs: _tabs.map((e) => Tab(text: e,)).toList(),
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.orange,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.black,
        indicatorWeight: 1,
        onTap: (index){
          Fluttertoast.showToast(msg: "点击----index---$index");
          _pageController.jumpToPage(index);
        },
      ),



    );
 }

  Widget _tabPageView() {

    return PageView(
      controller: _pageController,
      children: _tabs.map((e) =>  XFSOrderListpage(arguments: XFSRequestOrderListModel(tab_order_status: e),)).toList(),

      onPageChanged: (index){
      _tabController.animateTo(index);
      },

      physics: ClampingScrollPhysics(),
    );

  }
}