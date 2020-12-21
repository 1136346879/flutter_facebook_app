import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_server.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';

class XFSOrderListPresenter extends XFSBasePresenter<XfsOrderListView>{

  List<XFSOrderListModel> _orderList = List();
  XFSRequestOrderListModel _requestOrderListModel;
  XFSPageModel _pageModel;
  XFSOrderListPresenter(XfsOrderListView mView) : super(mView);
  /// 请求参数
  setRequestModel(XFSRequestOrderListModel model){

    _requestOrderListModel = model;
    _requestOrderListModel.member_id = 18;
    _requestOrderListModel.customer_id = "CN00069221";
    _requestOrderListModel.page_num =1;
    _requestOrderListModel.page_size =10;
  }


  getListData(){
    mView.showPageLoading();
    _getOrderListData(isRefresh: true, page: 1, showProgress: true);

  }

  /// 搜索订单
  /// [搜索关键词]
  searchData(String searchKey){
    _requestOrderListModel.search_param = searchKey;
    mView?.showPageLoading();
    _getOrderListData(isRefresh: true, page: 1, showProgress: true);
  }

  /// 刷新数据
  refreshData(){
    _getOrderListData(isRefresh: true, page: 1, showProgress: false);
  }

  /// 加载更多
  loadmoreData(int page){
    _getOrderListData(isRefresh: false, page: page, showProgress: false);
  }

  /// 获取订单列表数据
  /// [isRefresh] 是否刷新
  /// [page] 页面
  /// [showProgress] 是否显示loading框
  _getOrderListData({
    @required bool isRefresh,
    @required int page,
    @required bool showProgress=false,
  }){

    _requestOrderListModel.page_num = page;

    XFSOrderServer.getOrderList(
        requestModel: _requestOrderListModel,
        successBlock: (data) {
          _pageModel = data.pageStoreOrderPojoList;
          List<XFSOrderListModel> list = List();
          if (data.pageStoreOrderPojoList != null) {
            data.pageStoreOrderPojoList.result.forEach((v) {
              list.add(XFSOrderListModel.fromJson(v));
            });
          }
          if (isRefresh) {
            _orderList = _serialList(list);
          } else {
            _orderList.addAll(_serialList(list));
          }
          if (showProgress){
            mView?.hidePageLoading();
          }
          mView?.showData(data: _orderList);
          _refreshList(isRefresh, _pageModel?.hasNext??false);

        }, failureBlock: (data) {

      if (showProgress){
        mView?.hidePageLoading();
      }
      mView?.showEmptyView(state: EmptyViewType.ERROR, entity: data);
      _refreshList(isRefresh, _pageModel?.hasNext??true);

    });
  }




  /// 序列化订单数据,需要把拆分的订单取出来
  List<XFSOrderListModel> _serialList(List<XFSOrderListModel> list){
    List<XFSOrderListModel> serialLis = List();

    list.forEach((element) {
      serialLis.add(element);
      /// 20 已拆分，需要单独取出来
      if (element.order_split_status == 20){
        if (element?.subOrderList.isNotNullOrEmpty()){
          element.subOrderList[0].isChildOrder = true;
        }
        serialLis.addAll(element.subOrderList);
      }
    });

    return serialLis;
  }

  /// 结束请求刷新控件的调用
  _refreshList(bool isRefresh, bool hasData){
    if (isRefresh == null) return;
    if (isRefresh){
      mView?.refreshEnd(has: hasData);
    }else{
      mView?.loadingEnd(has: hasData);
    }
  }


  /// 商品展开与收起
  expandGoods(int section){
    XFSOrderListModel model = _orderList[section];
    _orderList[section].isExpand = !model.isExpand;
    mView?.showData(data: _orderList);
  }


}

abstract class XfsOrderListView extends XFSBaseListView {
  /// 显示alert提示
  void showAlert(String title, String content);
  /// 如果库存不足，显示弹出框
  void showBuyAgainAletView(XFSOrderListModel model);
  /// 去购物车
  void goCartShop();


}