import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_export_order_model.dart';

class XfsOrderExportPresenter extends XFSBasePresenter<XfsOrderExportView>{


  exprotOrder(XFSExportOrderModel model){

    if (_validationData(model)){
      XFSLogUtil.info('---------------订单导出参数------------${model.toJson().toString()}');
      _uploadData(model);
    }
  }

  /// 验证数据
  _validationData(XFSExportOrderModel model){

    if (model.time == '自定义'){
      if (model.beginDate.isNullOrEmpty()){
        mView?.showPageToast(msg: '请选择要导出的自定义开始时间');
        return false;
      }
      else if (model.endDate.isNullOrEmpty()){
        mView?.showPageToast(msg: '请选择要导出的自定义结束时间');
        return false;
      }
    }
    else {
      if (model.time.isNullOrEmpty()){
        mView?.showPageToast(msg: '请选择要导出的时间');
        return false;
      }
    }

    if (model.orderStatus.isNullOrEmpty()){
      mView?.showPageToast(msg: '请选择要导出的订单类型');
      return false;
    }

    if (model.invoiceSorce.isNullOrEmpty()){
      mView?.showPageToast(msg: '请选择要导出的开票状态');
      return false;
    }

    if (model.email.isNullOrEmpty()){
      mView?.showPageToast(msg: '请填写邮箱');
      return false;
    }

    if (!model.email.isOrEmail()){
      mView?.showPageToast(msg: '请填写正确邮箱');
      return false;
    }
    return true;
  }
  _uploadData(XFSExportOrderModel model){
    mView?.showPageLoading();
    Future.delayed(Duration(milliseconds: 500), (){
      mView?.exportSucess();
      mView?.showPageToast(msg: '订单导出成功');
      mView?.hidePageLoading();
    });
  }
  XfsOrderExportPresenter(XfsOrderExportView mView) : super(mView);

}

abstract class XfsOrderExportView extends XFSBaseView{

  exportSucess();//导出成功
}