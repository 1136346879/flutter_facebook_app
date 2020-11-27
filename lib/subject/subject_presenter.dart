import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/screens/screen_server.dart';

class SubjectPresenter extends XFSBasePresenter{



  getSubjectListData() {
    Map<String, dynamic> map = Map();
    map["subId"]= "Z200506091315";
    map["cityId"]= 110100;
    map["warehouse"]= 1;
    map["platform"]= 10;
    map["version_code"]= 86;
    map["device_platform"]= "android";
    ScreenServer.getSubjectList(
      map,
      successBlock: (val) {
        print("返回数据-专题列表数据-----${val.modelList.toString()}");
        mView.showData(data: val.modelList);
      },
      failureBlock: (val) {},
    );
  }





  SubjectPresenter(XFSBaseView mView) : super(mView);

}