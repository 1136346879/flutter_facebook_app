import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_list_page.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';

class XFSOrderTabPage extends XFSBaseTabbarPage {
  final String arguments;

  XFSOrderTabPage({this.arguments});

  @override
  XFSBaseTabbarPageState<XFSBaseTabbarPage, Object,
      XFSBasePresenter<XFSBaseView>> getState() {
    return _XFSOrderTabPageState();
  }
}

class _XFSOrderTabPageState
    extends XFSBaseTabbarPageState<XFSOrderTabPage, Object, XFSBasePresenter> {

  String get naviTitle => "订单列表";

  @override
  bool get onWillPop => false;

  @override
  bool get wantKeepAlive => true;

  @override
  int get initialIndex => tabs.indexOf(XFSOrderUtils.orderTabTitleWithCode(widget.arguments??""));
  @override
  List<Widget> actions() {
    return [
      XFSText(
        '订单导出',
        padding: EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.white,
        onTap: () {
          Navigator.pushNamed(context, XFSAppRouteConfigure.xfsOrderExportPage);
          // Navigator.pushNamed(context, XFSAppRouteConfigure.shoppingCartSharePage);
        },
      ),
      XFSText(
        '搜索',
        padding: EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.white,
        onTap: () {
          Navigator.pushNamed(context, XFSAppRouteConfigure.orderSearchPage);
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  XFSBasePresenter initPresenter() {}

  @override
  List<Widget> buildTabViews() {
    return tabs.map((e) => XFSOrderListpage(arguments: XFSRequestOrderListModel(tab_order_status: e))).toList();
  }

  @override
  List<Widget> buildTabs() {
    return tabs.map((e) => Tab(text: e)).toList();
  }
  @override
  XFSTabbarTheme get theme => XFSTabbarTheme(isScrollable: true,indicatorSize: TabBarIndicatorSize.tab);

  @override
  List get tabs => XFSOrderUtils.getTabbarTitles();
}
