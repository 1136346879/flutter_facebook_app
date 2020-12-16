import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';

///
///       创建时间：2020/12/15
///       修改人  ：zhangyan
///       描述    ：商品如图片详情
/// 
class GoodsImageDetailPage extends XFSBaseTabbarPage{
 final List<Images> images ;

  GoodsImageDetailPage({this.images});


  @override
  XFSBaseTabbarPageState getState() => _GoodsImageDetailPageState();

}

class _GoodsImageDetailPageState extends XFSBaseTabbarPageState<GoodsImageDetailPage, Object, XFSBasePresenter> {

  @override
  void initState() {
    super.initState();
  }
  @override
  String get naviTitle => "订单列表";

  @override
  bool get onWillPop => false;

  @override
  bool get wantKeepAlive => true;


  @override
  XFSBasePresenter initPresenter() {

  }
  @override
  List<Widget> buildTabViews() {
  return [
    // Expanded(
    //   child: ListView.builder(itemBuilder: (ctx,index){
    //     return  XFSNetImageLoader.loadNetImage(url: widget.images[index].imgUrl);
    //   },
    //   itemCount: 5,),
    // ),
    XFSContainer(
      alignment: Alignment.center,
      child: XFSText('商品介绍'),
    ),XFSContainer(
      alignment: Alignment.center,
      child: XFSText('包装清单'),
    ),

  ];
  }

  @override
  List<Widget> buildTabs() {
    return tabs.map((e) => Tab(text: e)).toList();
  }
  @override
  XFSTabbarTheme get theme => XFSTabbarTheme(isScrollable: true,indicatorSize: TabBarIndicatorSize.tab);

  @override
  List get tabs => ['商品介绍','包装清单'];
}







      