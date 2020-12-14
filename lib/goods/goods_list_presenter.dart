import 'package:flutter_facebook/models/search_result_model.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

class GoodsListPagePresenter extends XFSBasePresenter{

  getData(List<SpuList> spuList){
    mView.showData(data: spuList);
  }
  GoodsListPagePresenter(XFSBaseView mView) : super(mView);

}