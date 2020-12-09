import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_order_approval_model.dart';
import 'package:flutter_facebook/pages/xfs_order_approval_process_list_present.dart';
/// Created by wangDongXing
/// Created on 2020-10-13
/// page xfs_order_approval_process_page
/// desc 订单详情-审批流页面

///审批流查看
class XFSOrderApprovalProcessListPage extends XFSBaseListPage {

  String orderId;

  XFSOrderApprovalProcessListPage({this.orderId});

  static push(BuildContext buildContext, {String orderId}) {
    Navigator.pushNamed(
            buildContext, XFSAppRouteConfigure.xfsOrderApprovalProgressListPage,
            arguments: orderId)
        .then((it) {
    });
  }

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>> getState() {
    return _XFSOrderApprovalProcessListStates();
  }


}

class _XFSOrderApprovalProcessListStates extends XFSBaseListPageState<XFSOrderApprovalProcessListPage, XFSOrderApprovalModel, XFSOrderApprovalProcessListPresent>
    implements xfs_order_approval_process_listview{

  @override
  Widget buildItem(XFSOrderApprovalModel entity, int index) {
    if (index == 0){
      return _buildFirstIndexView();
    }
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, left: 10),
      color: setColorsIntBackground(entity),
      child: Row(
        children: [
          _leftView(entity, index),
          _centerView(entity, index),
          XFSTextView(
              entity.employ_user,
              textColor: setColorsIntAccountPremisson(entity),
              fontSize: 12
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    presenter.orderApprovalProgressApi(
        order_id: widget.orderId, result: (value) {});
  }

  @override
  XFSOrderApprovalProcessListPresent initPresenter() {
    return XFSOrderApprovalProcessListPresent(this);
  }

  @override
  String get naviTitle => '审批流查看';

  @override
  bool get isShowHeader => true;

  @override
  bool isRefresh() {
    return false;
  }

  /// 构建第一个index的view
  Widget _buildFirstIndexView(){
    return Container(
      color: Config.colorFFA200,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: XFSTextView(
              '权限',
              textColor: Colors.white,
            ),
          ),
          Expanded(
            child: XFSTextView(
              '账号',
              textColor: Colors.white,
            ),
          ),
          XFSTextView(
            '使用人',
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  /// 左侧名称列。
  Widget _leftView(XFSOrderApprovalModel entity, int index){
    return Expanded(
      flex: 1,
      child: XFSTextView(
        entity.accountTypeTitle,
        textColor: setColorsIntAccountPremisson(entity),
        fontSize: 12,
      ),
    );
  }

  /// 中间账号列。
  Widget _centerView(XFSOrderApprovalModel entity, int index){
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: getImageVisiable(entity),
                  child: Image.asset(getImageRString(entity),height: 15,width: 15,)
              ),
              XFSTextView(
                entity.login_account,
                textColor: setColorsIntAccountPremisson(entity),
                fontSize: 12,
              ),
            ],
          ),
          Visibility(
            visible: setVisiableBool(entity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getImageVisiable(entity) ? SizedBox(width: 15,height: 15,) : SizedBox(),
                XFSTextView(
                  entity.time??'',
                  textColor: Config.color999999,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 背景颜色
  Color setColorsIntBackground(XFSOrderApprovalModel entity) {
    if (entity.account_type == 30) {
      return Colors.white;
    } else if (entity.account_type == 10 || entity.account_type == 20) {
      if (entity.verify_status == 0) {
        return Config.colorFAFAFA;
      } else if (entity.verify_status == 10) {
        return Colors.white;
      } else if (entity.verify_status == 20) {
        return Config.colorFAFAFA;
      }
    }
  }

  ///权限文字颜色
  Color setColorsIntAccountPremisson(XFSOrderApprovalModel entity) {
    if (entity.account_type == 30) {
      return Config.color333333;
    } else if (entity.account_type == 10 || entity.account_type == 20) {
      if (entity.verify_status == 0 || entity.verify_status == 20) {
        return Config.color999999;
      } else if (entity.verify_status == 10) {
        return Config.color333333;
      }
    }
  }

  ///时间显示
  bool setVisiableBool(XFSOrderApprovalModel entity) {
    if (entity.account_type == 30) {
      return true;
    } else if (entity.account_type == 10 || entity.account_type == 20) {
      if (entity.verify_status == 0 || entity.verify_status == 20) {
        return false;
      } else if (entity.verify_status == 10) {
        return true;
      }
    }
    return false;
  }

  ///图标显示
  String getImageRString(XFSOrderApprovalModel entity) {
    if (entity.verify_status == 10) {
      return R.pass;
    } else {
      return R.noPass;
    }
  }

  ///通过和未通过图标显示与否
  bool getImageVisiable(XFSOrderApprovalModel entity) {
    if (entity.account_type == 10 || entity.account_type == 20) {
      if (entity.verify_status == 0) {
        return false;
      } else if (entity.verify_status == 10 || entity.verify_status == 20) {
        return true;
      }
    } else {
      return false;
    }
  }
}
