import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class GoodsDetailPresenter extends XFSBasePresenter{


  List<GoodsDetailModel> listGoodsDetailModel = List();


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

      val.data.forEach((element) {
        listGoodsDetailModel.add(GoodsDetailModel.fromJson(element));
      });
      mView.showData(data: listGoodsDetailModel);
    },
        failureBlock: (val){

        });
  }





  GoodsDetailPresenter(XFSBaseView mView) : super(mView);

}