import 'dart:collection';

import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_facebook/models/category_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

class HomePagePresenter extends XFSBasePresenter<HomePageView> {
  List<Data> data = new List<Data>();

  getListFirstPlay() {
    ///{
//     "loginAccount": "luoluo009",
//     "source": 20,
//     "platform": 10,
//     "customerId": "CN00069221",
//     "memberId": 122275,
//     "accountType": 10,
//     "warehouse": 1
// }
    Map<String, dynamic> map = Map();
    map['source'] = 20;
    map['warehouse'] = 1;
    map['platform'] = 10;

    ScreenServer.getCategory(
      map,
      successBlock: (val) {
        print("返回数据-分类-----${val.data.toString()}");
        data.clear();
        // Fluttertoast.showToast(msg: "返回数据-------${val.data.toString()}");
        val.data.forEach((v) {
          data.add(new Data.fromJson(v));
        });
        mView.showData(data: data);
      },
      failureBlock: (val) {},
    );
  }

  void removeElemet(Data item) {
    data.remove(item);
    mView.showData(data: data);
  }

  getHomeBanner() {
    Map<String, dynamic> map = Map();
    map['source'] = 20;
    map['warehouse'] = 1;
    map['platform'] = 10;
    ScreenServer.getHomeBanner(
      map,
      successBlock: (val) {
        print("返回数据-轮播图-----${val.data.toString()}");
        // Fluttertoast.showToast(msg: "返回数据-------${val.data.toString()}");
        BannerModel bannerModel = BannerModel.fromJson(val.data);
        mView.showBannerData(bannerModel);
      },
      failureBlock: (val) {},
    );
  }

  getCityList() {
    Map<String, dynamic> map = Map();

    ScreenServer.getAllCityList(
      map,
      successBlock: (val) {
        print("返回数据-城市列表-----${val.data.toString()}");
      },
      failureBlock: (val) {},
    );
  }

  getLinkedCategoryData() {
    Map<String, dynamic> map = Map();
    map["categoryLevel"] = "1";
    map["source"] = 20;
    map["platform"] = 10;
    List<int> list = [];
    list.add(15);
    map["afterCategoryIds"] = list;
    map["warehouse"] = 1;
    map["device_platform"] = "android";
    ScreenServer.getLinkedShowCategory(
      map,
      successBlock: (val) {
        print("返回数据-二级分类数据-----${val.data.toString()}");
      },
      failureBlock: (val) {},
    );
  }

  getSearchProData() {
    /**
     * 获取搜索结果 -- 通过分类搜索的
     *
     * @param map 参数集合
     *
     *  categoryName        品类名称
     *  categoryLevel       品类
     *  brandCatLevel       分类级别
     *  sort                价格排序    1  0
     *  scoreSort           综合排序   0
     *  page                当前页
     *  rows                每页显示条数
     *  cityId              城市id
     *  customerId          客户id
     *  attriNameAndValues  属性值字符串
     *  queryString         搜索框输入词
     *  stockSort           有无库存
     *  priceRange          价格区间
     *  brandNameStr        品牌名称
     *  brandCatName        分类
     *  brandCatLevel       分类级别
     */
    Map<String, dynamic> map = Map();
    map["stockSort"] = 0; //库存
    map["brandCatLevel"] = 0;
    map["platformType"] = 1;
    map["channel"] = "fsyuncai";
    map["activityPerson"] = 20;
    map["cityId"] = 110100;
    map["wareHouseId"] = 1;
    map["queryString"] = ""; //搜索的字符串
    map["rows"] = 20;
    map["curPage"] = 1; //当前页数
    map["joinActivity"] = 20;
    map["categoryId"] = 15;
    map["promotionSort"] = "0"; //促销
    map["device_platform"] = "android";
    ScreenServer.getSearchPro(
      map,
      successBlock: (val) {
        print("返回数据-三级商品数据-----${val.data.toString()}");
      },
      failureBlock: (val) {},
    );
  }

  getSubjectListData() {
    Map<String, dynamic> map = Map();
    map["subId"] = "Z200506091315";
    map["cityId"] = 110100;
    map["warehouse"] = 1;
    map["platform"] = 10;
    map["device_platform"] = "android";
    ScreenServer.getSubjectList(
      map,
      successBlock: (val) {
        print("返回数据-专题列表数据-----${val.modelList.toString()}");
      },
      failureBlock: (val) {},
    );
  }



  getGoodsDetialData(){
    Map<String, dynamic> map = Map();
    map["spuId"] = 2584;
    map["cityId"] = 110100;
    map["wareHouseId"] = 1;
    map["platformType"] = 1;
    ScreenServer.goodsDetail(map: map,successBlock: (val){
      print("返回数据-商品详情页数据-----${val.data.toString()}");
    },
    failureBlock: (val){

    });
  }

  HomePagePresenter(HomePageView mView) : super(mView);
}

abstract class HomePageView extends XFSBaseView {
  void showBannerData(BannerModel bannerModel);
}
