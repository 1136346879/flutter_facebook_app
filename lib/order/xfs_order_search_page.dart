import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_page.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/define/xfs_config.dart';

class XFSOrderSearchPage extends XFSBasePage {
  @override
  XFSBasePageState getState() => _XFSOrderSearchPageState();
}

class _XFSOrderSearchPageState
    extends XFSBasePageState<XFSOrderSearchPage, Object, XFSBasePresenter> {

  /// 开始时间
  DateTime _beginDate;
  /// 结束时间
  DateTime _endDate;
  TextEditingController _editingController = TextEditingController();
  /// 搜索关键词
  String _searchKey;
  /// 订单状态，对应tabbar
  String _selectedOrderStatus;
  /// 支付方式
  String _selectedPayment;
  /// 开票状态
  String _selectedInvoiceSorce;
  /// 订单状态数据
  List _orderStatus = XFSOrderUtils.getTabbarTitles();
  /// 支付方式数据
  List _paymentList = XFSOrderUtils.getPaymentList();
  /// 发票开票类型
  List _invoiceSorceList = XFSOrderUtils.getInvoiceSorce();

  @override
  String get naviTitle => '订单搜索';

  @override
  Color get backgroundColor => Config.colorEFEFF4;

  @override
  bool get isUseSafeArea => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  XFSBasePresenter initPresenter() {}

  @override
  Widget buildWidget(BuildContext context, Object object) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _buildItem(
                  title: '下单日期',
                  contentView: Row(
                    children: [
                      Expanded(
                        child: _buildStartDateView(),
                        flex: 1,
                      ),
                      XFSText.container(
                        '～',
                        textColor: Config.color999999,
                        padding: EdgeInsets.only(left: 6, right: 6),
                      ),
                      Expanded(
                        child: _buildEndDateView(),
                        flex: 1,
                      ),
                    ],
                  )
              ),
              _buildItem(
                  title: '搜索关键词',
                  contentView: XFSTextField(
                    controller: _editingController,
                    inputMaxLength: 20,
                    textFontSize: 12,
                    hintText: '请输入商品名称/订单号/收货人/收货手机号',
                    onChanged: (text){
                      _searchKey = text;
                    },
                  )
              ),
              _buildItem(
                  title: '订单状态',
                  contentView: Container(
                    child: XFSText.normal(_selectedOrderStatus??'', hint: '全部', textAlign: TextAlign.right, ),
                  ),
                  showNext: true,
                  onTap: (){
                    _showOrderStatusPicker();
                  }
              ),
              _buildItem(
                  title: '支付方式',
                  contentView: Container(
                    child: XFSText.normal(_selectedPayment??'', hint: '全部', textAlign: TextAlign.right,),
                  ),
                  showNext: true,
                  onTap: (){
                    _showPaymentPicker();
                  }
              ),
              _buildItem(
                  title: '开票状态',
                  contentView: Container(
                    child: XFSText.normal(_selectedInvoiceSorce??'', hint: '全部', textAlign: TextAlign.right,),
                  ),
                  showNext: true,
                  onTap: (){
                    _showInvoiceSorcePicker();
                  }
              ),
            ],
          ),
        ),
        _buildBottomView(),
      ],
    );
  }
  /// 时间显示
  _buildDateLabel(String title, {String hint,Function onTap}){
    return XFSText.container(title??'',
      height: 25,
      alignment: Alignment.center,
      hint: hint,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: Config.colorC8C7CC, width: 1),
      onTap: onTap,
    );
  }
  /// 开始时间
  _buildStartDateView(){
    return _buildDateLabel(XFSDateUtil.getDateStrByDateTime(_beginDate, format: XFSDateFormat.YEAR_MONTH_DAY),
        hint: '请选择开始日期',
        onTap: () {
          XFSDatePickerView.show(
              context: context,
              maximumDate: _endDate,
              initialDateTime: _beginDate,
              confirmCallback: (date) {
                _beginDate = date;
                setState(() {});
              }
          );
        }
    );
  }
  /// 显示订单状态选择器
  _showOrderStatusPicker(){

    XFSDataPickerView.show(
        title: '请选择订单状态',
        context: context,
        list: _orderStatus,
        data: _selectedOrderStatus,
        confirmCallback: (title, index){
          _selectedOrderStatus = title;
          setState(() {});
        }
    );
  }

  /// 显示支付方式选择器
  _showPaymentPicker(){

    XFSDataPickerView.show(
        context: context,
        list: _paymentList,
        title: '请选择支付方式',
        data: _selectedPayment,
        confirmCallback: (data, index){
          _selectedPayment = data;
          setState(() {});
        }
    );
  }

  /// 显示支付方式选择器
  _showInvoiceSorcePicker(){

    XFSDataPickerView.show(
        context: context,
        list: _invoiceSorceList,
        title: '请选择开票类型',
        data: _selectedInvoiceSorce,
        confirmCallback: (data, index){
          _selectedInvoiceSorce = data;
          setState(() {});
        }
    );
  }

  /// 结束时间
  _buildEndDateView(){
    return _buildDateLabel(XFSDateUtil.getDateStrByDateTime(_endDate, format: XFSDateFormat.YEAR_MONTH_DAY),
        hint: '请选择结束日期',
        onTap: () {
          XFSDatePickerView.show(
              context: context,
              initialDateTime: _endDate,
              minimumDate: _beginDate,
              confirmCallback: (date) {
                _endDate = date;
                setState(() {});
              }
          );
        }
    );
  }

  _buildBottomView() {
    return XFSContainer(
      height: 46,
      child: Row(
        children: [
          Expanded(
            child: XFSText.container(
              '重置',
              backgroudColor: Colors.white,
              alignment: Alignment.center,
              textColor: Config.color666666,
              fontSize: 16,
              onTap: () {
                XFSUtils.hideKeybaord(context);
                _resetData();
              },
            ),
          ),
          Expanded(
            child: XFSText.container(
              '搜索',
              backgroudColor: Config.colorFFA200,
              textColor: Colors.white,
              fontSize: 16,
              alignment: Alignment.center,
              onTap: () {
                XFSUtils.hideKeybaord(context);
                _confirmButtonClick();
              },
            ),
          ),
        ],
      ),
    );
  }


  /// 构建item
  _buildItem({String title, Widget contentView, bool showNext=false, Function onTap}){

    return XFSNormalItem(
      padding: EdgeInsets.only(left: 15, right: 12, bottom: 15, top: 15),
      backgroudColor: Colors.white,
      titleString: title,
      contentView: XFSContainer(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: contentView,
      ),
      showTrailing: showNext,
      onTap: onTap,
    );
  }
  ///重置数据
  void _resetData() {
    Fluttertoast.showToast(msg: "重置");
    setState(() {
      _editingController.text = '';
      _beginDate = null;
      _endDate = null;
      _searchKey = '';
      _selectedOrderStatus = '';
      _selectedPayment = '';
      _selectedInvoiceSorce = '';
    });
  }

    XFSRequestOrderListModel _requestOrderListModel = XFSRequestOrderListModel();
  ///点击搜索按钮
  void _confirmButtonClick() {
    Fluttertoast.showToast(msg: "搜索");

    _requestOrderListModel.search_param = _searchKey;
    _requestOrderListModel.beginTime = _beginDate;
    _requestOrderListModel.endTime = _endDate;
    _requestOrderListModel.tab_order_status = _selectedOrderStatus??'全部';
    _requestOrderListModel.paid_type = _selectedPayment??'';
    _requestOrderListModel.invoiceSorce = _selectedInvoiceSorce;
    Navigator.pushNamed(context, XFSAppRouteConfigure.orderSearchResultPage, arguments: _requestOrderListModel, ).then((value){
      if (value != null){
        _searchKey = value;
        _editingController.text = value;
      }
    });
  }
}
