import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/city_list_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class AZCityListPresenter extends XFSBasePresenter{


  getCityListData() {

    Map<String, dynamic> map = Map();
    List<CityCategory> cityCategoryList = List();
    List<City> cityList = List();

    ScreenServer.getAllCityList(
      map,
      successBlock: (val) {
        print("返回数据-城市列表-----${val.data.toString()}");
        List listRes = val.data;
        listRes.forEach((element) {
          cityCategoryList.add(CityCategory.fromJson(element));
        });
        cityCategoryList.forEach((cityCategory) {
          // cityList.add(City(name: cityCategory.item));
          cityCategory.list.forEach((element) {
            cityList.add(element);
          });
        });
        mView.showData(data: cityList);

      },
      failureBlock: (val) {},
    );

  }

  AZCityListPresenter(XFSBaseView mView) : super(mView);
}