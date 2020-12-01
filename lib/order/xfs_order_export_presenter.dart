import 'package:flutter_facebook/config/xfs_header.dart';

class XfsOrderExportPresenter extends XFSBasePresenter{





  XfsOrderExportPresenter(XFSBaseView mView) : super(mView);

}

abstract class XfsOrderExportView extends XFSBaseView{

  exportSucess();//导出成功
}