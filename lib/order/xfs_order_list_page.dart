import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_list_item.dart';
import 'package:flutter_facebook/order/xfs_order_list_presenter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_list_page.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';
import 'package:xfs_flutter_utils/widgets/xfs_text.dart';

class XFSOrderListpage extends XFSBaseListPage {

  /// 请求参数
  final XFSRequestOrderListModel arguments;

  final GlobalKey<XFSOrderListpageState> globalKey;
  XFSOrderListpage({@required this.arguments,this.globalKey}): super(key:globalKey);
  @override
  XFSBaseListPageState<XFSBaseListPage, XFSOrderListModel, XFSBasePresenter> getState() => XFSOrderListpageState();

}

class XFSOrderListpageState extends XFSBaseListPageState<XFSOrderListpage, XFSOrderListModel, XFSOrderListPresenter>
    implements XfsOrderListView,XFSItemClickDelegate{



  @override
  void initState() {
    super.initState();
    presenter.setRequestModel(widget.arguments);
    print("====-------------------${this.runtimeType.toString()}");
    presenter.getListData();
  }
  @override
  XFSBaseListPageType get pageType => XFSBaseListPageType.CUSTOM;
  @override
  Color get backgroundColor => xfsColor(light: Colors.white,);
  @override
  bool get isUseScaffold => false;
  @override
  bool get autoRefresh => true;
  @override
  Widget buildItem(XFSOrderListModel, int index) {//默认使用这个
    // return Container(
    //   child: XFSText("页面显示---${widget.arguments.tab_order_status}"),
    // );
  }

  @override
  Widget buildCustomList() {//特殊情况
    return XFSListView(context: context, delegate: XFSOrderListDelegate(clickDelegate: this, list: modelList,));
  }

  @override
  errorViewAction() {
     super.errorViewAction();
     beginRefrsh();
  }
  @override
  void onLoadMore() {
    super.onLoadMore();
    presenter.loadmoreData(pageNumber);
  }
  /// 搜索订单
  void searchOrder(String searchKey){
    presenter.searchData(searchKey);
  }
@override
  emptyViewAction() {
     super.emptyViewAction();
      Fluttertoast.showToast(msg: '${this.runtimeType.toString()}-逛一逛');
  }

  @override
  bool get isShowHeader => false;

  @override
  void onRefresh() {
    super.onRefresh();

    presenter.refreshData();
  }

  @override
  XFSOrderListPresenter initPresenter() {
    return XFSOrderListPresenter(this);
  }

  @override
  void didSelectCell({int section, int row, int clickType, data, data1}) {
    Fluttertoast.showToast(msg: "点击cell--$data1");
  }

  @override
  void goCartShop() {

  }

  @override
  void showAlert(String title, String content) {
  }

  @override
  void showBuyAgainAletView(XFSOrderListModel model) {
  }

}

class XFSOrderListDelegate extends XFSListDelegate {
  final XFSItemClickDelegate clickDelegate;
  final List<XFSOrderListModel> list;

  XFSOrderListDelegate({this.clickDelegate, this.list});
  @override
  Widget buildItem(BuildContext context, int section, int row) {
    XFSOrderListModel model = list[section];
    return XFSOrderListItem(clickDelegate: clickDelegate, section: section, row: row, model: model.listOrderItems[row], listModel: model,);
  }

  @override
  Widget buildSectionHeader(BuildContext context, int section) {
    return XFSOrderListHeader(model: list[section], clickDelegate: clickDelegate, section: section,);
  }

  @override
  Widget buildSectionFooter(BuildContext context, int section) {
    XFSOrderListModel model = list[section];
    /// 如果是拆分订单就不显示底部信息
    if (model.order_split_status == 20){
      return null;
    }
    return XFSOrderListFooter(clickDelegate: clickDelegate, section: section, model: model,);
  }
  @override
  int itemCount(int section) {
    XFSOrderListModel model = list[section];
    /// 如果是拆分订单就没有商品
    print('model-${model.order_split_status ?? 0}');
    if (model.order_split_status == 20){
      return 0;
    }
    return model.goodsCount ?? 0;
  }

  @override
  int sectionCount() {
    print('list-length-${list?.length ?? 0}');
    return list?.length ?? 0;
  }
}