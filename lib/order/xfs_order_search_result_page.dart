import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_list_page.dart';


/// Created by liuwei
/// on 2020-09-29
/// page xfs_order_search_result_page
/// 搜索结果页面

class XFSOrderSearchResultPage extends XFSBasePage{

  /// 搜索筛选条件
  final XFSRequestOrderListModel arguments;

  XFSOrderSearchResultPage({this.arguments});

  @override
  XFSBasePageState getState() => _XFSOrderSearchResultPageState();

}

class _XFSOrderSearchResultPageState extends XFSBasePageState<XFSOrderSearchResultPage, Object, XFSBasePresenter> {

  TextEditingController _editingController;
  GlobalKey<XFSOrderListpageState> globalKey = GlobalKey();
  String _searchKey;

  @override
  void initState() {
    super.initState();
    _searchKey = widget.arguments?.search_param??'';
    _editingController = TextEditingController(text: _searchKey);
  }

  @override
  bool get resizeToAvoidBottomPadding => false;


  @override
  List<Widget> actions() {
    return [
      XFSText('搜索',
        padding: EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.white,
        onTap: (){
          Navigator.pop(context, _searchKey);
        },
      ),
    ];
  }

  @override
  Widget buildAppBarTitleView() {

    return XFSTextField(
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      hintText: '请输入商品名称/订单号/收货人/收货手机号',
      controller: _editingController,
      textInputAction: TextInputAction.search,
      onChanged: (text){
        _searchKey = text;
      },
      onSubmitted: (text){
        // 点击搜索
        globalKey.currentState.searchOrder(text);
      },
    );
  }

  @override
  XFSBasePresenter initPresenter() {}

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return XFSOrderListpage(arguments: widget.arguments, globalKey: globalKey,);
  }

}