 import 'package:flutter_facebook/config/xfs_header.dart';

class XFSOrderDetailsPage extends XFSBasePage{

  /// 订单详情的订单号
  final Map arguments;

  XFSOrderDetailsPage({
    this.arguments,
  });
  static push(BuildContext buildContext,
      {String orderId, bool isNative = false}) {
    Navigator.pushNamed(buildContext, XFSAppRouteConfigure.orderDetailsPage,
        arguments: {'orderId': orderId, 'isNative': isNative}).then((it) {});
  }

   @override
   XFSBasePageState getState() => _XFSOrderDetailsPageState();

 }

 class _XFSOrderDetailsPageState extends XFSBasePageState<XFSOrderDetailsPage, Object, XFSBasePresenter> {


   @override
   void initState() {
     super.initState();
   }



   @override
   XFSBasePresenter initPresenter() {

   }

   @override
   Widget buildWidget(BuildContext context, Object object) {
    return Container(
      child: XFSText('订单详情页'),

    );
   }
 }