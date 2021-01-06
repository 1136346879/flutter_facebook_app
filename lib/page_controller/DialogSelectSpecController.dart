import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

///
///       创建时间：2021/1/4
///       修改人  ：zhangyan
///       描述    ：
/// 
class DialogSelectSpecController extends XFSBasePageController{
  List<GoodsDetailModel> listGoodsDetailModel = List();
  List<String> listColors = List();
  getGoodsDetialData({int spuId}){
    Map<String, dynamic> map = Map();
    map["spuId"] = spuId??2584;
    map["cityId"] = 110100;
    map["wareHouseId"] = 1;
    map["platformType"] = 1;
    ScreenServer.goodsDetail(map: map,successBlock: (val){
      SectePrice rangeData = SectePrice.fromJson(val.sectePrice);
      String max = rangeData?.maxPrice?.isNullOrEmpty()? "0.00" : rangeData?.maxPrice;
      String min = rangeData?.minPrice?.isNullOrEmpty() ?"0.00" : rangeData?.minPrice;
      String priceRange = max==min? min: "$min~$max";

      listGoodsDetailModel.clear();
      listColors.clear();
      val.data.forEach((element) {
        listGoodsDetailModel.add(GoodsDetailModel.fromJson(element));
      });

        XFSUtils.jsonListToModelList(val.color, (colorValue) =>
            listColors.add(colorValue));
      // if(val.color.length<1){
      //   listColors.add("");
      // }
      showData(listGoodsDetailModel);
      update();
    },
        failureBlock: (val){

        });
  }
}








      