import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_export_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_export_presenter.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/widgets/xfs_choose_wrap.dart';

class XFSOrderExportPage extends XFSBasePage {
  String arguments;

  XFSOrderExportPage({@required this.arguments});

  @override
  XFSBasePageState getState() => _XFSOrderExportPageState();
}

class _XFSOrderExportPageState
    extends XFSBasePageState<XFSOrderExportPage, Object, XfsOrderExportPresenter> implements XfsOrderExportView{
  XFSExportOrderModel _uploadModel = XFSExportOrderModel();

  /// 是否显示自定义时间
  bool _showCustomTimeView = false;
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  XfsOrderExportPresenter initPresenter() {
    return XfsOrderExportPresenter(this);
  }

  @override
  String get naviTitle => "订单导出";

  @override
  bool get onWillPop => false;

  @override
  bool get isUseSafeArea => true;
  @override
  backAction() {
    if (Navigator.canPop(getContext())) {
      Navigator.pop(getContext());
    } else {
      XFSCommonUtils.goBackNative();
    }
  }


@override
  Widget buildBottom(Object object) {
  return XFSText(
    '确认导出',
    height: 44,
    textColor: Colors.white,
    backgroudColor: Config.app_main,
    alignment: Alignment.center,
    onTap: (){
      presenter.exprotOrder(_uploadModel);
    },
  );
  }


  @override
  Widget buildWidget(BuildContext context, Object object) {
    return ListView(padding: EdgeInsets.all(20.0), children: [
      _buileTimeView(),
      _buildOrderStatusView(),
      _buildInvoiceSorceView(),
      _buildPaymentView(),
      _buildEmailView(),
    ]);
  }

  _buileTimeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XFSText(
          "请选择订单时间",
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        ),
        XFSChooseWrap(
          padding: EdgeInsets.symmetric(horizontal: 15),
          theme: XFSChooseWrapTheme.text(
            activeColor: Colors.white,
            activeTextColor: Config.colorFFA200,
            textColor: Config.color333333,
            backgroudColor: Colors.white,
            selectedBackgroundImage: R.checkSelected,
            normalBorder: Border.all(
              color: Config.color333333,
            ),
            selectedBorder: Border.all(color: Config.app_main),
            radius: BorderRadius.all(Radius.circular(6)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          list: [
            '近三月',
            '近半年',
            '近一年',
            '自定义',
          ],
          runSpacing: 20,
          spacing: 10,
          isMultipleChoice: false,
          singleCallback: (tag, data) {
            XFSLogUtil.info('----------------------------$data');

            /// 两次选择一样不做操作
            if (data == _uploadModel.time) {
              return;
            }
            _uploadModel.time = data;
            if (data == '自定义') {
              setState(() {
                _showCustomTimeView = true;
              });
            } else {
              _uploadModel.beginDate = null;
              _uploadModel.endDate = null;
              setState(() {
                _showCustomTimeView = false;
              });
            }
          },
        ),
        Visibility(
          child: _buildCustomTimeView(),
          visible: _showCustomTimeView,
        )
      ],
    );
  }

  _buildOrderStatusView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XFSText(
          "请选择订单状态",
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        ),
        XFSChooseWrap(
          padding: EdgeInsets.symmetric(horizontal: 15),
          list: XFSOrderUtils.getTabbarTitles()..remove('全部'),
          theme: XFSChooseWrapTheme.text(
            activeColor: Colors.white,
            textColor: Config.color333333,
            activeTextColor: Colors.white,
            backgroudColor: Colors.white,
            selectedBackgroundImage: R.checkSelected,
            normalBorder: Border.all(
              color: Config.color333333,
            ),
            selectedBorder: Border.all(color: Config.app_main),
            radius: BorderRadius.all(Radius.circular(6)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          isMultipleChoice: true,
          multipleCallback: (tag, data) {
            XFSLogUtil.info('----------------------------${data.toString()}');
            _uploadModel.orderStatus = data;
          },
          runSpacing: 20,
          spacing: 10,
        )
      ],
    );
  }

  _buildInvoiceSorceView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XFSText(
          "请选择开票状态",
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        ),
        XFSChooseWrap(
          padding: EdgeInsets.symmetric(horizontal: 15),
          list: XFSOrderUtils.getInvoiceSorce()..remove('全部'),
          theme: XFSChooseWrapTheme.text(
            activeColor: Colors.white,
            textColor: Config.color333333,
            activeTextColor: Colors.white,
            backgroudColor: Colors.white,
            selectedBackgroundImage: R.checkSelected,
            normalBorder: Border.all(
              color: Config.color333333,
            ),
            selectedBorder: Border.all(color: Config.app_main),
            radius: BorderRadius.all(Radius.circular(6)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          isMultipleChoice: true,
          multipleCallback: (tag, data) {
            XFSLogUtil.info('----------------------------${data.toString()}');
            _uploadModel.invoiceSorce = data;
          },
          runSpacing: 20,
          spacing: 10,
        )
      ],
    );
  }

  _buildPaymentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XFSText(
          "请选择支付方式",
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        ),
        XFSChooseWrap(
          padding: EdgeInsets.symmetric(horizontal: 15),
          list: XFSOrderUtils.getPaymentList()..remove('全部'),
          theme: XFSChooseWrapTheme.text(
            activeColor: Colors.white,
            textColor: Config.color333333,
            activeTextColor: Colors.white,
            backgroudColor: Colors.white,
            selectedBackgroundImage: R.checkSelected,
            normalBorder: Border.all(
              color: Config.color333333,
            ),
            selectedBorder: Border.all(color: Config.app_main),
            radius: BorderRadius.all(Radius.circular(6)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          isMultipleChoice: true,
          multipleCallback: (tag, data) {
            XFSLogUtil.info('----------------------------${data.toString()}');
            _uploadModel.payments = data;
          },
          runSpacing: 20,
          spacing: 10,
        )
      ],
    );
  }

  _buildEmailView() {
    return Column(
      children: [
        _buildTitle('请填写接收订单的邮箱'),
        XFSCupertinoTextField(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          controller: _editingController,
          margin: EdgeInsets.symmetric(horizontal: 15),
          border: Border.all(color: Config.colorD7D7D7, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          backgroudColor: Colors.white,
          inputMaxLength: 40,
          keyboardType: TextInputType.emailAddress,
          onChanged: (val) {
            _uploadModel.email = val;
          },
        )
      ],
    );
  }

  /// 构建标题
  _buildTitle(
    String title,
  ) {
    return XFSText(
      title,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    );
  }

  @override
  exportSucess() {
    Navigator.pop(context);
  }

  @override
  showToast(String msg) {
    XFSCommonUtils.showToast(msg: msg);
  }

  _buildCustomTimeView(){
    return XFSContainer(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStartDateView(),
            flex: 1,
          ),
          XFSText(
            '～',
            textColor: Config.color999999,
            padding: EdgeInsets.only(left: 6, right: 6),
          ),
          Expanded(
            child: _buildEndDateView(),
            flex: 1,
          ),
        ],
      ),
    );
  }
  /// 开始时间,时间间隔不能大于一年，
  _buildStartDateView(){
    return _buildDateLabel(XFSDateUtil.getDateStrByDateTime(_uploadModel.beginDate, format: XFSDateFormat.YEAR_MONTH_DAY),
        hint: '请选择开始日期',
        onTap: () {
          XFSDatePickerView.show(
              context: context,
              maximumDate: _uploadModel.endDate,
              minimumDate: _uploadModel.beginMinDate(),
              initialDateTime: _uploadModel.beginInitDate(),
              confirmCallback: (date) {
                _uploadModel.beginDate = date;
                setState(() {});
              }
          );
        }
    );
  }

  /// 结束时间
  _buildEndDateView(){
    return _buildDateLabel(XFSDateUtil.getDateStrByDateTime(_uploadModel.endDate, format: XFSDateFormat.YEAR_MONTH_DAY),
        hint: '请选择结束日期',
        onTap: () {
          XFSDatePickerView.show(
              context: context,
              initialDateTime: _uploadModel.endInitDate(),
              minimumDate: _uploadModel.beginDate,
              maximumDate: _uploadModel.endMaxDate(),
              confirmCallback: (date) {
                _uploadModel.endDate = date;
                setState(() {});
              }
          );
        }
    );
  }
  /// 时间显示
  _buildDateLabel(String title, {String hint,Function onTap}){
    return XFSText(title??'',
      height: 25,
      alignment: Alignment.center,
      hint: hint,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: Config.colorC8C7CC, width: 1),
      onTap: onTap,
    );
  }
}
