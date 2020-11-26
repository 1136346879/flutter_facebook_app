import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_facebook/models/category_model.dart';
import 'package:flutter_facebook/screens/home_page_present.dart';
import 'package:flutter_facebook/widgets/banner/commont_banner.dart';
import 'package:flutter_facebook/widgets/banner/home_banner.dart';
import 'package:flutter_facebook/widgets/banner/pagination.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends XFSBasePage {
  @override
  XFSBasePageState getState() => _HomePageState();
}

class _HomePageState
    extends XFSBasePageState<HomePage, List<Data>, HomePagePresenter> implements HomePageView{
   List<BannerModelData> arr = [];
  @override
  void initState() {
    super.initState();
    presenter.getListFirstPlay();
    presenter.getHomeBanner();
  }

  @override
  backAction() {
    presenter.getHomeBanner();
  }
  @override
  List<Widget> actions() {
    return [
      Container(
        margin: EdgeInsets.only(right: 10),
        child: XFSNormalButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: (){

          },
        ),
      ),

      Container(
        margin: EdgeInsets.only(right: 10),
        child: XFSNormalButton(
          icon: Icon(Icons.search),
          onPressed: (){},
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 10),
        child: XFSNormalButton(
          icon: Icon(Icons.location_on_outlined),
          onPressed: (){},
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 10),
        child: XFSNormalButton(
          icon: Icon(Icons.add_a_photo_outlined),
          onPressed: (){},
        ),
      ),

    ];
  }
  @override
  HomePagePresenter initPresenter() {
    return HomePagePresenter(this);
  }

  @override
  bool get isShowBackButton => false;
  @override
  String get naviTitle => "方盛云采";

  @override
  Widget buildWidget(BuildContext context, List<Data> object) {
    return XFSContainer(
      child: Column(
        children: [
          CommontBanner(swiperDataList:arr),
          // Pagination(),
          Expanded(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 10,right: 10),
              child: GridView.count(
                  padding: EdgeInsets.all(10),
                //水平子Widget之间间距
                crossAxisSpacing: 10.0,
                //垂直子Widget之间间距
                mainAxisSpacing: 10.0,
                //GridView内边距
                // padding: EdgeInsets.all(10.0),
                //一行的Widget数量
                crossAxisCount: 4,
                //子Widget宽高比例
                // childAspectRatio: 2.0,
                //子Widget列表
                children: getWidgetList(object),
              ),
            ),
          ),

        ],
      ),
      onTap: () {
        presenter.getListFirstPlay();
      },
    );
  }

  List<Widget> getWidgetList(List<Data> object) {
    return object.map((item) => getItemContainer(item)).toList();
  }

  Widget getItemContainer(Data item) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: XFSNormalButton(
              textColor: Colors.black,
              textSize: 16,
              icon: Expanded(child: Image.network(item.pictureUrl)),
              text: item.displayContent,
              iconTextAlignment:XFSNormalButtonAlignment.iconTopTextBottom,
              onLongPress: (){
                Fluttertoast.showToast(msg: '${item.displayContent}');
              },
              onPressed: (){
                Fluttertoast.showToast(msg: '${item.frontFirstCategoryId}');
              },
            ),
          ),
        ],
      ),
      color: Colors.white,
    );
  }

  @override
  void showBannerData(BannerModel bannerModel) {

     arr = bannerModel.data;
     setState(() {});
  }
}
