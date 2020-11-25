import 'dart:collection';

import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

class HomePagePresenter extends XFSBasePresenter {
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
        print("返回数据------${val.errorMessage.toString()}");
        Fluttertoast.showToast(
            msg: "返回数据-------${val.errorMessage.toString()}");
      },
      failureBlock: (val) {},
    );
  }

  HomePagePresenter(XFSBaseView mView) : super(mView);
}
