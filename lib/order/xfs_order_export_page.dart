import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_export_order_model.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/widgets/xfs_choose_wrap.dart';

class XFSOrderExportPage extends XFSBasePage {
  String arguments;

  XFSOrderExportPage({@required this.arguments});

  @override
  XFSBasePageState getState() => _XFSOrderExportPageState();
}

class _XFSOrderExportPageState
    extends XFSBasePageState<XFSOrderExportPage, Object, XFSBasePresenter> {

  XFSExportOrderModel _uploadModel = XFSExportOrderModel();
  /// 是否显示自定义时间
  bool _showCustomTimeView = false;
  TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  XFSBasePresenter initPresenter() {}

  @override
  String get naviTitle => "订单导出";

  @override
  bool get onWillPop => false;

  @override
  backAction() {
    if (Navigator.canPop(getContext())) {
      Navigator.pop(getContext());
    } else {
      XFSCommonUtils.goBackNative();
    }
  }

  @override
  bool get isUseSafeArea => true;

  @override
  Widget buildWidget(BuildContext context, Object object) {
    return ListView(padding: EdgeInsets.all(20.0), children: [
      _buileTimeView(),
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
          // multipleCallback: multipleCallback,
          singleCallback:  (tag, data){
            XFSLogUtil.info('----------------------------$data');
            /// 两次选择一样不做操作
            if (data == _uploadModel.time){
              return;
            }
            _uploadModel.time = data;
            if (data == '自定义'){
              setState(() {
                _showCustomTimeView = true;
              });
            }else {
              _uploadModel.beginDate = null;
              _uploadModel.endDate = null;
              setState(() {
                _showCustomTimeView = false;
              });
            }
          },
        ),
      ],
    );
  }

}

