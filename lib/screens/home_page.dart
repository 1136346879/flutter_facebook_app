import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/screens/home_page_present.dart';

class HomePage extends XFSBasePage{

  @override
  XFSBasePageState getState() => _HomePageState();

}

class _HomePageState extends XFSBasePageState<HomePage, Object, HomePagePresenter> {


  @override
  void initState() {
    super.initState();
    presenter.getListFirstPlay();
  }



  @override
  HomePagePresenter initPresenter() {
    return HomePagePresenter(this);

  }

  @override
  // TODO: implement naviTitle
  String get naviTitle => "方盛云采";

  @override
  Widget buildWidget(BuildContext context, Object object) {
   return XFSContainer(
     child: XFSText('首页',),
         onTap: (){
       presenter.getListFirstPlay();
   },

   );
  }
}