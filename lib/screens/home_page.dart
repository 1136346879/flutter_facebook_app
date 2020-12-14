import 'dart:ffi';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_facebook/models/category_model.dart';
import 'package:flutter_facebook/models/category_to_list_model.dart';
import 'package:flutter_facebook/pages/az_city_list_page.dart';
import 'package:flutter_facebook/pages/city_list_page.dart';
import 'package:flutter_facebook/screens/home_category_detail.dart';
import 'package:flutter_facebook/screens/home_page_present.dart';
import 'package:flutter_facebook/subject/subject_page.dart';
import 'package:flutter_facebook/widgets/banner/commont_banner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/widgets/xfs_button.dart';


class HomePage extends XFSBasePage {
  @override
  XFSBasePageState getState() => _HomePageState();
}

class _HomePageState
    extends XFSBasePageState<HomePage, List<Data>, HomePagePresenter> implements HomePageView{
   List<BannerModelData> arr = [];
   String cityName='选择';
  @override
  void initState() {
    super.initState();
    presenter.getListFirstPlay();
    presenter.getHomeBanner();
  }

  @override
  backAction() {
    // presenter.getSearchProData();
    // presenter.getGoodsDetialData();
  }
  @override
  List<Widget> actions() {
    return [
      Container(
        child: XFSTextButton.icon(
          icon: Icon(Icons.shopping_cart,color: Colors.white,),
          width: 6,
          onPressed: (){

          },
        ),
      ),

      Container(
        child: XFSTextButton.icon(
          title: '${cityName}',
          textColor: Colors.white,
          width: 6,
          icon: Icon(Icons.location_on_outlined,color: Colors.white,),
          onPressed: (){
            // AzCityListPage.pushName(context);
            Navigator.pushNamed(context, XFSAppRouteConfigure.azCityListPage)
                .then((value) {
                  if(value == null) return
              Fluttertoast.showToast(msg: "$value");
              setState(() {
                cityName = value??"选择";
              });
            });
          },
        ),
      ),
      Container(
        child: XFSTextButton.icon(
          width: 6,
          icon: Icon(Icons.search,color: Colors.white,),
          onPressed: (){
            CityLiStPage.pushName(context);
          },
        ),
      ),
      Container(
        child: XFSTextButton.icon(
          width: 6,
          icon: Icon(Icons.add_a_photo_outlined,color: Colors.white,),
          onPressed: (){
            _scanQR();
          },
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
  String get naviTitle => "";

  @override
  Widget buildWidget(BuildContext context, List<Data> object) {
    return RefreshIndicator(
      onRefresh: (){
        return  _onRefresh();
      },
      child: Scrollable(

      physics: BouncingScrollPhysics(),

        controller: ScrollController(),
          viewportBuilder: (BuildContext context, ViewportOffset offset) {

        return  XFSContainer(
          child: ListView(
            children: [
              CommontBanner(swiperDataList:arr),
              // Pagination(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: GridView.count(
                    primary:false,
                      shrinkWrap:true,
                    controller: ScrollController(),
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
       },),
    );
  }

  List<Widget> getWidgetList(List<Data> object) {
    if(object.isNullOrEmpty()){
      return [];
    }
    return object?.map((item) => getItemContainer(item))?.toList();
  }
   static Future _scanQR() async {
     try {
       String qrResult = await BarcodeScanner.scan();
       Fluttertoast.showToast(msg:"扫码后返回信息---${qrResult}");
     } on PlatformException catch(ex) {
       if (ex.code == BarcodeScanner.CameraAccessDenied) {
         print(ex.code);
       } else {
         print(ex.code);
       }
     } on FormatException {
       print("pressed ths back button before scanning anyting");
     } catch(ex){
       print(ex);
     }
   }

  Widget getItemContainer(Data item) {
    return Dismissible(
      key: Key(UniqueKey().toString()),

      onDismissed: (direction){
        setState(() {
          presenter.removeElemet(item);
        });
      },
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Text(
          '滑动删除',
          style:
          TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: item?.pictureUrl,
                child: XFSTextButton.icon(
                  textColor: Colors.black,
                  fontSize: 14,
                  icon: Expanded(child: Image.network(item?.pictureUrl)),
                  title: item?.displayContent,
                  direction:XFSTextButtonIconTextDirection.textBIconT,

                  onLongPress: (){
                    Navigator.pushNamed(context, XFSAppRouteConfigure.goodsPage,arguments: CategoryToListModel(item.frontFirstCategoryId, 1));
                  },
                  onPressed: (){
                    HOmePageDetail.push(context, item?.pictureUrl);
                  },
                ),
              ),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  @override
  void showBannerData(BannerModel bannerModel) {

     arr = bannerModel.data;
     setState(() {});
  }

   Future<void> _onRefresh() async{
     await Future.delayed(Duration(seconds: 1), () {
       presenter.getListFirstPlay();
       presenter.getHomeBanner();
     });
     setState(() {

     });
  }
}
