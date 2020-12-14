import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/category_to_list_model.dart';
import 'package:flutter_facebook/models/search_result_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class GoodsPresenter extends XFSBasePresenter<GoodsListView> {
  GoodsPresenter(GoodsListView mView) : super(mView);

  getSearchProData(CategoryToListModel arguments) {
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
    ScreenServer.getSearchPro(
      map,
      successBlock: (val) {
        SearchResult searchResult = SearchResult.fromJson(val.searchResult);
        mView.showData(data: searchResult);
      },
      failureBlock: (val) {},
    );
  }
}

abstract class GoodsListView extends XFSBaseView {
  priceSort();
}
