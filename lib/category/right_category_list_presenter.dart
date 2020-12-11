import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/right_category_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class RightCategoryListPresenter extends XFSBasePresenter{

List<RightCategoryModel> listRightCategoryModel = List();
  getLinkedCategoryData(int categoryId) {
    Map<String, dynamic> map = Map();
    map["categoryLevel"] = "1";
    map["source"] = 20;
    map["platform"] = 10;
    List<int> list = [];
    list.add(categoryId);
    map["afterCategoryIds"] = list;
    map["warehouse"] = 1;
    map["device_platform"] = "android";
    ScreenServer.getLinkedShowCategory(
      map,
      successBlock: (val) {
        listRightCategoryModel.clear();
        // print("返回数据-二级分类数据-----${val.data.toString()}");
        val.data.forEach((element) {
          listRightCategoryModel.add(RightCategoryModel.fromJson(element));
        });
       // SecondListNext secondListNext =  SecondListNext();
       //  List secondList = List();
       //  secondList.add(secondListNext);
        print("1返回数据-二级分类数据${listRightCategoryModel[0].secondList.length}");
        listRightCategoryModel[0].secondList.insert(0,SecondList(afterCategoryName:listRightCategoryModel[0].afterCategoryName));
        print("2返回数据-二级分类数据${listRightCategoryModel[0].secondList.length}");
        mView.showData(data: listRightCategoryModel[0].secondList);
      },
      failureBlock: (val) {},
    );
  }

  RightCategoryListPresenter(XFSBaseView mView) : super(mView);

}