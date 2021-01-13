import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/base_tab_page.dart';
import 'package:flutter_facebook/order/xfs_order_list_page.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

class TabPage extends BaseTabPage{
  final String arguments;
  TabPage({this.arguments});
  @override
  BaseTabPageState<BaseTabPage, Object, XFSBasePresenter<XFSBaseView>> getState() {
   return _TabPageState();
  }
}

class _TabPageState extends BaseTabPageState<TabPage, Object, XFSBasePresenter> {

  @override
  String get naviTitle => "订单列表";

  @override
  bool get onWillPop => false;

  @override
  bool get wantKeepAlive => true;
  @override
  int get initialIndex => tabs.indexOf(XFSOrderUtils.orderTabTitleWithCode(widget.arguments??''));
  @override
  List<Widget> actions() {
    return [
      XFSText.container(
        '订单导出',
        padding: EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.white,
        onTap: () {
          Navigator.pushNamed(context, XFSAppRouteConfigure.xfsOrderExportPage);
          // Navigator.pushNamed(context, XFSAppRouteConfigure.shoppingCartSharePage);
        },
      ),
      XFSText.container(
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
  XFSBasePresenter initPresenter() {
  }

  @override
  List<Widget> buildTabViews() {
    print("-----------${tabs.length}");
    return tabs.map((e) => XFSOrderListpage(arguments:XFSRequestOrderListModel(tab_order_status:e))).toList();

  }
  @override
  TabbarTheme get theme => TabbarTheme(isScrollable: true, indicatorSize: TabBarIndicatorSize.tab);
  @override
  List<Widget> buildTabs() {
    print("-----------${tabs.length}");
    return tabs.map((e) => Tab(text: e)).toList();
  }

  @override
  List get tabs => XFSOrderUtils.getTabbarTitles();
  @override
  backAction() {
    super.backAction();
    XFSCommonUtils.goBackNative();
  }
}