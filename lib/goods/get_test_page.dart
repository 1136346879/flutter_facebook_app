import 'package:flutter_facebook/config/xfs_header.dart';

///
///       创建时间：2021/1/4
///       修改人  ：zhangyan
///       描述    ：
/// 
class GetTestPage extends XFSGetBasePage{
  final int arguments;

  GetTestPage({this.arguments});

  static push(BuildContext context, {int arguments}) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.getTestPage,
        arguments: arguments)
        .then((value) {});
  }
  @override
  XFSGetBasePageState getState() => _GetTestPageState();

}

class _GetTestPageState extends XFSGetBasePageState<GetTestPage, Object, XFSBasePageController> {


  @override
  void initState() {
    super.initState();
  }



  @override
  XFSBasePresenter initPresenter() {

  }

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return XFSContainer(
     child: XFSText.normal('get_page'),
   );
  }

  @override
  XFSBasePageController initController() {
   return XFSGetTestPageController();
  }
}

class XFSGetTestPageController extends XFSBasePageController{

}





      