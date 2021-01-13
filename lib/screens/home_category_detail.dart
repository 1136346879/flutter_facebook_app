import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
///种类页面详情，hero动画使用
class HOmePageDetail extends XFSBasePage {
  final String arguments;

  HOmePageDetail({this.arguments});


  static push(BuildContext context,String arguments){
    Navigator.pushNamed(context,XFSAppRouteConfigure.homePageDetail,arguments: arguments).then((value) {

    });
  }

  @override
  XFSBasePageState getState() => _HOmePageDetailState();
}

class _HOmePageDetailState
    extends XFSBasePageState<HOmePageDetail, Object, XFSBasePresenter> {
  @override
  void initState() {
    timeDilation = 2.0; // 1.0 means normal animation speed.
    super.initState();
  }

  @override
  // TODO: implement naviTitle
  String get naviTitle => 'Hero动画---详情页面';
  @override
  XFSBasePresenter initPresenter() {}

  @override
  Widget buildWidget(BuildContext context, Object object) {
    return Container(
        child: Column(
          children: [
            // Hero(
            //   tag: widget.arguments,
            //   child:
              Image.network(
                widget.arguments,
                height: 300,
                width: double.infinity,
              ),
            // ),
            XFSText.container(
              "_HOmePageDetailState extends XFSBasePageState<HOmePageDetail, Object, XFSBasePresenter> ",
              padding: EdgeInsets.all(20),
            ),
            Expanded(
              child: XFSText.container(
                """_HOmePageDetailState extends XFSBasePageState<HOmePageDetail,
                 Object, XFSBasePresenter>  
                        final String imageUrl;
                        HOmePageDetail(this.imageUrl); 
                        @override
                        XFSBasePageState getState() => _HOmePageDetailState(); """,
                padding: EdgeInsets.only(left: 20),
              ),
            ),
          ],
      ),
    );
  }
}
