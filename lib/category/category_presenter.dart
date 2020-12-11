import 'package:flutter_facebook/models/category_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

class CategoryPresenter extends XFSBasePresenter{





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
        // Fluttertoast.showToast(msg: "返回数据-------${val.data.toString()}");
        val.data.forEach((v) {
          data.add(new Data.fromJson(v));
        });
        data[0].selected = true;
        mView.showData(data: data);
      },
      failureBlock: (val) {},
    );
  }

  void removeElemet(Data item) {
    data.remove(item);
    mView.showData(data: data);
  }






  CategoryPresenter(XFSBaseView mView) : super(mView);

}