import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/category_to_list_model.dart';
import 'package:flutter_facebook/models/search_result_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class GoodsPresenter extends XFSBasePresenter<GoodsListView> {
  GoodsPresenter(GoodsListView mView) : super(mView);

  getSearchProData(CategoryToListModel arguments, bool listBool) {
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
    map["categoryId"] = arguments.categoryId ?? 15;
    map["promotionSort"] = "0"; //促销
    map["device_platform"] = "android";
    List<String> brandListString = [];
    ScreenServer.getSearchPro(
      map,
      successBlock: (val) {
        SearchResultModel searchResultModel = SearchResultModel.fromJson(val);
        if(listBool){
          mView.showData(data: searchResultModel.searchResult);
        }else{
           mView.showData(data: searchResultModel.searchResult?.spuList,);
        }
        mView.categoryData(searchResultModel.catAndNumXList);
        BaseEntity baseEntity = BaseEntity.fromJson(val);
        List<dynamic> brandListTest = List();
        Map<dynamic,dynamic> map = Map();
        baseEntity.brandList.forEach((val){
            map.addAll(val);
        });
        map.keys.forEach((element) {
        brandListTest.add(map[element]);
        });
        brandListTest.forEach((val) {
          val.forEach((element) {
            brandListString.add(element);
          });
        });

        // searchResultModel.brandList.forEach((element) {
        //     brandListString.addAll(element.a??[]);
        //     brandListString.addAll(element.b??[]);
        //     brandListString.addAll(element.c??[]);
        //     brandListString.addAll(element.d??[]);
        //     brandListString.addAll(element.e??[]);
        //     brandListString.addAll(element.f??[]);
        //     brandListString.addAll(element.g??[]);
        //     brandListString.addAll(element.h??[]);
        //     brandListString.addAll(element.i??[]);
        //     brandListString.addAll(element.j??[]);
        //     brandListString.addAll(element.k??[]);
        //     brandListString.addAll(element.l??[]);
        //     brandListString.addAll(element.m??[]);
        //     brandListString.addAll(element.n??[]);
        //     brandListString.addAll(element.o??[]);
        //     brandListString.addAll(element.p??[]);
        //     brandListString.addAll(element.q??[]);
        //     brandListString.addAll(element.r??[]);
        //     brandListString.addAll(element.s??[]);
        //     brandListString.addAll(element.t??[]);
        //     brandListString.addAll(element.u??[]);
        //     brandListString.addAll(element.v??[]);
        //     brandListString.addAll(element.w??[]);
        //     brandListString.addAll(element.x??[]);
        //     brandListString.addAll(element.y??[]);
        //     brandListString.addAll(element.z??[]);
        // });
        mView.siftData(brandListString);
      },
      failureBlock: (val) {},
    );
  }
}

abstract class GoodsListView extends XFSBaseView {
  priceSort();
  siftData(List<String> brandListString);
  categoryData(List<CatAndNumXList> categoryList);
}
