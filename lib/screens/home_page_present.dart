import 'dart:collection';

import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_facebook/models/category_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

class HomePagePresenter extends XFSBasePresenter<HomePageView> {
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
        // Fluttertoast.showToast(msg: "返回数据-------${val.data.toString()}");
        List<Data> data = new List<Data>();
        val.data.forEach((v) {
          data.add(new Data.fromJson(v));
        });
        mView.showData(data: data);
      },
      failureBlock: (val) {},
    );
  }

    getHomeBanner(){
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

  HomePagePresenter(HomePageView mView) : super(mView);
}


abstract class HomePageView extends XFSBaseView{

  void showBannerData(BannerModel bannerModel);
}