import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/widgets/xfs_choose_wrap.dart';
class XFSOrderExportPage extends XFSBasePage{

  String arguments;
  XFSOrderExportPage({@required this.arguments});

  @override
  XFSBasePageState getState() => _XFSOrderExportPageState();

}

class _XFSOrderExportPageState extends XFSBasePageState<XFSOrderExportPage, Object, XFSBasePresenter> {


  @override
  void initState() {
    super.initState();
  }



  @override
  XFSBasePresenter initPresenter() {

  }

  @override
  String get naviTitle => "订单导出";

  @override
  bool get onWillPop => false;

  @override
  backAction() {
if(Navigator.canPop(getContext())){
  Navigator.pop(getContext());

}else{
XFSCommonUtils.goBackNative();
}


  }
@override
  bool get isUseSafeArea => true;

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return ListView(
     padding: EdgeInsets.all(20.0),
     children:[

       XFSText('订单导出'),
       _buileTimeView(),

     ]
   );
  }
}




 _buileTimeView() {

return Column(
  children: [
  XFSText(
  "请选择订单时间",
  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),


),
    XFSChooseWrap(
      padding: EdgeInsets.symmetric(horizontal: 15),
      theme: XFSChooseWrapTheme.text(activeColor: Colors.white,
          activeTextColor: Colors.white,
          backgroudColor: Colors.white,
          selectedBackgroundImage: R.checkSelected,
          normalBorder: Border.all(color: Config.color333333, ),
        selectedBorder: Border.all(color: Config.app_main),
        radius: BorderRadius.all(Radius.circular(6)),

        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),


      ),
      list: ['近三月', '近半年', '近一年', '自定义',],
    ),


  ],
);

}