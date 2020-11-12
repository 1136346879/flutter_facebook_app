import 'package:flutter_facebook/models/user_model.dart';
import 'package:flutter_facebook/screens/screen_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

class HomeScreenPresenter extends XFSBasePresenter{
  HomeScreenPresenter(XFSBaseView mView) : super(mView);

      User user = null;
  getCurrentUserInf(){

    ScreenServer.getCurrentUserInfo(successBlock:(data){
      Fluttertoast.showToast(msg: "返回数据-------${data.name.toString()}");
      mView.showData(data: data);
    },
    failureBlock: (data){

    }
    );

  }

}