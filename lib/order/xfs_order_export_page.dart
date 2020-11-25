import 'package:flutter_facebook/config/xfs_header.dart';

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
  bool get isUseSafeArea => true;

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return ListView(
     padding: EdgeInsets.all(10.0),
     children:[

       XFSText('订单导出'),

     ]
   );
  }
}