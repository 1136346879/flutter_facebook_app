import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
abstract class GoodsDetailView extends XFSBaseView{
  colors(List<String> listColors);
}
class GoodsDetailPresenter extends XFSBasePresenter<GoodsDetailView>{


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

      listColors.clear();
      val.data.forEach((element) {
        listGoodsDetailModel.add(GoodsDetailModel.fromJson(element));
      });
      XFSUtils.jsonListToModelList(val.color, (colorValue) =>
          listColors.add(colorValue));
      mView.showData(data: listGoodsDetailModel);
      mView.colors(listColors);
    },
        failureBlock: (val){

        });
  }





  GoodsDetailPresenter(XFSBaseView mView) : super(mView);

}

