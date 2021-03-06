import 'package:flutter_facebook/models/xfs_logistics_Info_model.dart';
import 'package:flutter_facebook/models/xfs_order_details_model.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/models/xfs_order_remittance_model.dart';
import 'package:flutter_facebook/models/xfs_order_tracking_model.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/net/api.dart';
import 'package:flutter_facebook/net/http_utils.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';
import 'package:flutter_facebook/config/xfs_header.dart';

/// Created by liuwei
/// on 2020-09-18
/// page xfs_order_server

class XFSOrderServer {
  /// 获取订单列表
  /// [requestModel] 请求参数
  static getOrderList(
      {XFSRequestOrderListModel requestModel,
      SuccessBlock<XFSOrderPageModel> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    Map map = requestModel.toJson();

    HttpUtils.getDataForCallback(API.ORDER_LIST,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST, params: map, success: (model) {
      XFSOrderPageModel orderPageModel = XFSOrderPageModel.fromJson(model.data);
      successBlock(orderPageModel);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 获取订单详情
  /// [requestModel] 请求参数
  static getOrderDetails(
      {String orderId,
      SuccessBlock<XFSOrderDetailsModel> successBlock,
      FailureBlock<XFSOrderDetailsModel> failureBlock}) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['order_id'] = orderId;
    var responseData = await Http().post(
      API.ORDER_DETAILS,API.BASE_URL_xfs,
      params: map,
    );
    XFSOrderDetailsModel orderDetailsModel;
    if (responseData != null) {
      orderDetailsModel = XFSOrderDetailsModel.fromJson(responseData);
    } else {
      orderDetailsModel = XFSOrderDetailsModel();
    }

    if (orderDetailsModel != null) {
      successBlock(orderDetailsModel);
    } else {
      failureBlock(orderDetailsModel);
    }
  }

  /// 物流信息
  /// [orderId] 订单id
  /// [expressNum] 物流单号
  static getLogisticsInfo(
      {@required String orderId,
      @required String expressNum,
      SuccessBlock<XFSLogisticsInfoModel> successBlock,
      FailureBlock<BaseEntity> failureBlock}) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['orderId'] = orderId;
    map['expressNum'] = expressNum;

    var responseData = await Http().post(
      API.ORDER_LOGISTICS_INFO,API.BASE_URL_xfs,
      data: map,
    );
    XFSLogisticsInfoModel infoModel;
    if (responseData != null) {
      infoModel = XFSLogisticsInfoModel.fromJson(responseData['data']['result']);
      successBlock(infoModel);
    } else {
      failureBlock(responseData);
    }
  }

  /// 获取汇款转账详情
  /// [orderId] 订单id
  static getBankInfo(
      {@required String orderId,
      SuccessBlock<XFSOrderRemittanceModel> successBlock,
      FailureBlock<BaseEntity> failureBlock}) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['orderId'] = orderId;

    var responseData = await Http().post(
      API.ORDER_BANK_INFO,API.BASE_URL_xfs,
      data: map,
    );

    XFSOrderRemittanceModel orderRemittanceModel;
    if (responseData != null) {
      orderRemittanceModel = XFSOrderRemittanceModel.fromJson(responseData);
    }

    if (orderRemittanceModel.code == '0') {
      successBlock(orderRemittanceModel);
    } else {
      failureBlock(responseData);
    }
  }

  /// 取消订单
  /// [orderId] 订单id
  /// [cancel_order_status] 订单状态
  /// [cancle_reason] 取消理由
  static cancelOrder(
      {@required String orderId,
      @required int cancel_order_status,
      @required int cancle_reason,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.ORDER_CANCEL,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST,
        params: {
          'order_id': orderId,
          'cancel_remark': '',
          'warehouse_id': xfsUserInfo.warehouseId,
          'cancel_role': 10,
          'cancel_order_status': cancel_order_status,
          'cancle_reason': cancle_reason,
          'cancle_name': xfsUserInfo.loginAccount,
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 删除订单
  /// [orderId] 订单id
  static deleteOrder(
      {@required String orderId,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.ORDER_DELETE,null,
        httpMethod: HttpMethod.POST,
        params: {
          'orderId': orderId,
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 确认收货
  /// [orderId] 订单id
  static confirmReceipt(
      {@required String orderId,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.ORDER_CONFIRM_RECEIPT,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST,
        params: {
          'orderId': orderId,
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 再次购买
  /// [orderId] 订单id
  /// [skuIdNumlist] 购买的商品
  static buyAgain(
      {@required String orderId,
      @required List skuIdNumlist,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.CART_BUY_AGAIN,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST,
        params: {
          'orderId': orderId,
          'skuIdNumlist': skuIdNumlist,
          'warehouseId': xfsUserInfo.warehouseId,
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 审批流查看
  /// [orderId] 订单id
  static orderApprovalProgress(
      {@required String orderId,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.APPROVAL_FLOW,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POSTQUERY,
        params: {
          'order_id': orderId,
          'account_type': '10',
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 审批驳回
  /// [orderId] 订单id
  /// [remark] 驳回备注
  static orderReject(
      {@required String orderId,
      String remark,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.ORDER_CHECK_NO_PASS,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST,
        params: {
          'order_id': orderId,
          'remark': remark,
          'account_type': '20',
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 审批通过
  /// [orderId] 订单id
  static orderPass(
      {@required String orderId,
      SuccessBlock<BaseEntity> successBlock,
      FailureBlock<BaseEntity> failureBlock}) {
    HttpUtils.getDataForCallback(API.ORDER_CHECK_PASS,API.BASE_URL_xfs,
        httpMethod: HttpMethod.POST,
        params: {
          'order_id': orderId,
          'account_type': '20',
        }, success: (model) {
      successBlock(model);
    }, failure: (model) {
      failureBlock(model);
    });
  }

  /// 获取订单追踪
  /// [orderId] 订单id
  static getOrderTracking({
    @required String orderId,
    SuccessBlock<XFSOrderTrackingPageModel> successBlock,
    FailureBlock<BaseEntity> failureBlock
  }){

    HttpUtils.getDataForCallback(
      API.ORDER_TRACKING,null,
      httpMethod: HttpMethod.POSTQUERY,
      params: {'orderId': orderId},
      success: (responseData){
        XFSOrderTrackingPageModel model = XFSOrderTrackingPageModel.fromJson(responseData);
        successBlock(model);
      },
      failure: (error){
        failureBlock(error);
      }
    );
  }

}
