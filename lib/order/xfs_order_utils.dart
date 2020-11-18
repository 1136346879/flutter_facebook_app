import 'package:flutter_facebook/config/xfs_r.dart';
import 'package:flutter_facebook/models/xfs_key_value_model.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/extension/xfs_extension.dart';

/// Created by liuwei
/// on 2020-09-17
/// page xfs_order_status

class XFSOrderUtils {
  /// 订单取消理由
  static List<XFSKeyValueModel> getOrderCancelReasonList() {
    List<XFSKeyValueModel> list = List();

    list.add(XFSKeyValueModel(id: 10, name: '订购错误'));
    list.add(XFSKeyValueModel(id: 11, name: '价格高'));
    list.add(XFSKeyValueModel(id: 12, name: '无法满足到货时效'));
    list.add(XFSKeyValueModel(id: 13, name: '支付问题'));
    list.add(XFSKeyValueModel(id: 14, name: '重复下单'));
    list.add(XFSKeyValueModel(id: 15, name: '暂时不需要了'));
    list.add(XFSKeyValueModel(id: 16, name: '订单信息有误'));
    list.add(XFSKeyValueModel(id: 17, name: '无货'));
    list.add(XFSKeyValueModel(id: 18, name: '其他'));
    list.add(XFSKeyValueModel(id: 100, name: '公司产品原因'));
    return list;
  }

  /// 获取订单tabb状态
  static getTabbarTitles() {
    if (XFSCommonUtils.contract()) {
      return ['全部', '待审批', '待付款', '待发货', '待收货', '已收货待结算', '订单成功', '取消', '订单关闭'];
    } else {
      return ['全部', '待付款', '待发货', '待收货', '订单成功', '取消', '订单关闭'];
    }
  }

  /// 获取支付方式
  static getPaymentList() {
    if (XFSCommonUtils.contract()) {
      return ['全部', '在线支付', '货到付款', '账期支付', '银行汇票', '银行转账'];
    } else {
      return [
        '全部',
        '在线支付',
        '银行汇票',
        '银行转账',
        '门店付款',
      ];
    }
  }


  /// 获取开票类型
  static List getInvoiceSorce() {
    return ['全部', '未开票', '已开票', '开票中',];
  }

  /// 根据标题获取code
  static dynamic orderCodeTabWithTitle(String title) {
    if (title.isNullOrEmpty()) {
      return '';
    }
    switch (title) {
      case '待审批': //目前等于代付款
        return '9';
      case '待付款':
        return '10';
      case '待发货':
        return '50';
      case '待收货':
        return '60';
      case '已收货待结算':
        return '70';
      case '订单成功':
        return '80';
      case '取消':
        return '100';
      case '订单关闭':
        return '110';
      case '全部':
        return "";
    }
  }

  /// 根据code获取title
  static dynamic orderTabTitleWithCode(String code) {
    switch (code) {
      case '9': //目前等于代付款
        return '待审批';
      case '10':
        return '待付款';
      case '50':
        return '待发货';
      case '60':
        return '待收货';
      case '70':
        return '已收货待结算';
      case '80':
        return '订单成功';
      case '100':
        return '取消';
      case '110':
        return '订单关闭';
      case '':
        return '全部';
    }
  }

  /// 订单状态码对应文字
  static String orderStatus(int code) {
    switch (code) {
      case 9:
        return "待内部审批";
      case 10:
        return "待付款";
      case 20:
        return "待客服处理";
      case 30:
        return "待配货";
      case 40:
        return "待出库";
      case 50:
        return "待发货";
      case 60:
        return "待收货";
      case 70:
        return "已收货待结算";
      case 80:
        return "订单成功";
      case 90:
        return "订单成功";
      case 100:
        return "已取消";
      case 110:
        return "订单关闭";
      default:
        return "";
    }
  }

  /// 订单状态码对应状态图片
  static String orderStatusImage(int code) {
    switch (code) {
      case 9:
        return R.orderWaitAudit;
      case 10:
        return R.orderWaitPay;
      case 20:
        return R.orderWaitAudit;
      case 30:
        return R.orderWaitOutbound;
      case 40:
        return R.orderWaitOutbound;
      case 50:
        return R.orderWaitSend;
      case 60:
        return R.orderWaitReceiving;
      case 70:
        return R.orderWaitPay;
      case 80:
        return R.orderSuccess;
      case 90:
        return R.orderSuccess;
      case 100:
        return R.orderClose;
      case 110:
        return R.orderClose;
      default:
        return R.orderWaitPay;
    }
  }

  /// 支付方式
  static String paymentForTitle(String text) {
    switch (text) {
      case '1001':
        return '在线支付';
      case '1002':
        return '支付宝支付';
      case '1003':
        return '微信支付';
      case '1101':
        return '货到付款';
      case '1102':
        return '货到付款-现金';
      case '1103':
        return '货到付款-pos机';
      case '1201':
        return '账期支付 ';
      case '1301':
        return '银行转账';
      case '1401':
        return '银行汇票';
      case '1601':
        return '优惠券支付';
      case '1701':
        return '门店付款';
      default:
        return '';
    }
  }

  /// 支付方式对应的code
  static String paymentForCode(String text) {
    switch (text) {
      case '货到付款':
        return '1101';
      case '货到付款':
        return '1102';
      case '货到付款':
        return '1103';
      case '账期支付':
        return '1201';
      case '银行汇票':
        return '1401';
      case '银行转账':
        return '1301';
      case '在线支付':
        return '1001';
      case '门店付款':
        return '1701';
      case '优惠券支付':
        return '1601';
      default:
        return '';
    }
  }

  /// 配送方式
  /// [containRestricted] 是否包含危化品
  /// [finalSentTypeCode] 最终配送方式Code
  static String getSendType(bool containRestricted, int finalSentTypeCode) {
    switch (finalSentTypeCode) {
      case 10:
        return "快递";
      case 20:
        return "快运";
      case 21:
        return "快运-站点自提";
      case 30:
        return "专车包车";
      case 40:
        if (containRestricted) {
          return "物流配送";
        }
        return "鑫方盛物流";
      case 50:
        return "上门自提";
      default:
        return "";
    }
  }

  /// 取消操作人
  static String operatorForCode(int roleCode) {
    switch (roleCode) {
      case 10:
        return '用户';
      case 20:
        return '平台管理员';
      case 30:
        return '系统管理员';
      default:
        return '';
    }
  }

  /// 审批状态 10：已通过 20：已驳回 其他：未审批
  /// [status] 审批状态码
  static String verifyStatusForCode(int status) {
    switch (status) {
      case 10:
        return '已通过';
      case 20:
        return '已驳回';
      default:
        return '未审批';
    }
  }

  /// 取消原因
  static String cancelReasonForCode(int cancelCode) {
    switch (cancelCode) {
      case 10:
        return '订购错误/计划有变';
      case 11:
        return '价格高';
      case 12:
        return '无法满足到货时效';
      case 13:
        return '支付问题';
      case 14:
        return '重复下单';
      case 15:
        return '暂时不需要了';
      case 16:
        return '订单信息有误';
      case 17:
        return '无货';
      case 18:
        return '其他';
      case 19:
        return '商品质量问题';
      case 20:
        return '价格错误';
      case 90:
        return '系统自动取消';
      case 100:
        return '公司产品原因';
      case 101:
        return '客户原因';
      case 102:
        return '已驳回';
      default:
        return '';
    }
  }

  /// 页面显示的订单状态，需要根据订单状态转换成文字
  /// [orderStatus] 服务器返回的订单状态
  /// [cancle_apply_show] 是否取消
  /// [paid_type] 支付方式
  pageShowOrderStatusString(
      int order_status, bool cancle_apply_show, int paid_type) {
    // 订单为 待客服处理，待出库，待发货，cancle_apply_show 为false是后面拼(已申请取消)
    if ((order_status == 20 || order_status == 40 || order_status == 50) &&
        !cancle_apply_show) {
      var status = XFSOrderUtils.orderStatus(order_status);
      return '$status(已申请取消)';
    }
    if (order_status == 20 &&
        (paid_type == 1101 || paid_type == 1102 || paid_type == 1103)) {
      return '待审核';
    }
    return XFSOrderUtils.orderStatus(order_status);
  }
}

/// 订单状态相关操作按钮
class XFSOrderStatusWithButton {
  /// 是否有取消按钮
  /// [order_status] 订单状态
  /// [cancle_apply_show] 是否显示取消
  /// [hasBuyAuth] 下单权限
  static bool hasCancelButton(
      int order_status, bool cancle_apply_show, bool hasBuyAuth) {
    /// 是否有下单权限
    if (!hasBuyAuth) {
      return false;
    }

    /// 是否有取消按钮订单状态
    if (!isCancelButtonOrderStatus(order_status)) {
      return false;
    }

    /// 如果订单状态是待内部审批直接显示，其他状态直接返回【cancle_apply_show】改字段服务器返回，
    if (order_status == 9) {
      return true;
    }
    return cancle_apply_show;
  }

  /// 是否是取消按钮的订单状态
  /// [order_status] 订单状态
  /// 订单状态：待内部审批，待付款，待客服处理，待出库，待发货显示取消按钮
  /// 对应状态码：9，10，20，40，50
  static bool isCancelButtonOrderStatus(int order_status) {
    if (order_status == 9 ||
        order_status == 10 ||
        order_status == 20 ||
        order_status == 40 ||
        order_status == 50) {
      return true;
    }
    return false;
  }

  /// 是否有审核按钮
  /// [order_status] 订单状态
  /// [audit_button_show] 是否显示审核按钮，服务器返回
  /// [hasApproveAuth] 审核权限
  static bool hasApproveButton(
      int order_status, bool audit_button_show, bool hasApproveAuth) {
    if (!hasApproveAuth) {
      return false;
    }

    /// 有审核权限，订单状态为待内部审批，【audit_button_show】服务器返回
    if (audit_button_show && order_status == 9) {
      return true;
    }
    return false;
  }

  /// 是否显示支付按钮
  /// [order_status] 订单状态
  /// [paid_button_show] 是否显示按钮
  /// [hasSettleAuth] 是否有结算权限
  static bool hasPayButton(
      int order_status, bool paid_button_show, bool hasSettleAuth) {
    if (!hasSettleAuth) {
      return false;
    }

    if (paid_button_show && order_status == 10) {
      return true;
    }
    return false;
  }

  /// 是否显示去确认按钮\
  /// [order_status] 订单状态
  /// [paid_button_show]
  /// [paid_type] 支付方式 [XFSOrderUtils.paymentForTitle(text)]
  /// [hasSettleAuth] 结算权限
  static bool hasGoConfirmButton(int order_status, bool paid_button_show,
      int paid_type, bool hasSettleAuth) {
    /// 有结算权限，并且显示支付按钮，并且满足支付条件
    if (!hasSettleAuth) {
      return false;
    }
    if (paid_button_show &&
        order_status == 20 &&
        (paid_type == 1101 || paid_type == 1102 || paid_type == 1103)) {
      return true;
    }
    return false;
  }

  /// 是否显示取货二维码和取货验证码
  /// 在线支付/银行转账（不区分平台）且门店自提的订单，
  /// 下推之后发送短信并生成二维码和取货码，取货码和二维码只有在待出库的状态下展示
  /// 待出库（已申请取消）的，不展示
  /// [order_status] 订单状态
  /// [cancle_apply_show]
  /// [paid_type] 支付方式 [XFSOrderUtils.paymentForTitle(text)]
  /// [sent_type] 配送方式 50.自提
  /// [hasBuyAuth] 当前订单的下单权限
  static bool hasQRCodeButton(int order_status, bool cancle_apply_show,
      int paid_type, int sent_type, bool hasBuyAuth) {
    /// 下单权限
    if (!hasBuyAuth) {
      return false;
    }

    /// 是否二维码的订单状态
    if (order_status != 40) {
      return false;
    }

    /// 不区分签约和未签约
    if ((paid_type == 1001 || paid_type == 1002 || paid_type == 1003 || paid_type == 1301) && sent_type == 50) {
      return cancle_apply_show;
    }

    return false;
  }

  /// 是否显示再次购买
  /// [order_status] 订单状态
  /// [buy_again_button] 系统返回是否可购买
  /// [canBuyAgain] 是否可以购买[XFSOrderListModel]下面的方法，判断商品是否有小数和是否危险品等
  /// [hasBuyAuth] 是否有下单权限
  static bool hasBuyAgainButton(int order_status, bool buy_again_button,
      bool canBuyAgain, bool hasBuyAuth) {
    if (!hasBuyAuth) {
      return false;
    }
    // 未签约用户：是否显示再次购买【buy_again_button】服务器返回，【canBuyAgain】判断商品是否有小数
    if (!XFSCommonUtils.contract() && canBuyAgain && buy_again_button) {
      return true;
    }
    // 签约用户
    if (XFSCommonUtils.contract() && buy_again_button) {
      return true;
    }
    return false;
  }

  /// 是否显示删除订单
  /// [order_status] 订单状态
  static bool hasDeleteButton(int order_status) {
    // 订单状态：已取消
    if (order_status == 100) {
      return true;
    }
    return false;
  }

  /// 是否显示退货、维修按钮
  /// [order_status] 订单状态
  /// [hasBuyAuth] 下单权限
  static bool hasReturnButton(
      int order_status, String customer_id, bool hasBuyAuth) {
    /// 是否显示按钮的订单状态
    if (!isReturnOrderStatus(order_status)) {
      return false;
    }

    /// 是否有下单权限
    if (!hasBuyAuth) {
      return false;
    }

    /// 订单是已收货待结算并且有下单权限
    if (order_status == 70) {
      return true;
    }

    /// 订单状态是已成功
    /// 如果是签约用户，判读是否有下单权限，登录账户和订单账户是否同一个
    /// 如果是未签约用于，则只判断是否有下单权限
    if (order_status == 80 &&
            (XFSCommonUtils.contract() &&
                xfsUserInfo.loginAccount == customer_id) ||
        (!XFSCommonUtils.contract())) {
      return true;
    }
    return false;
  }

  /// 是否有退货和维修按钮的订单状态
  /// [order_status] 70=已收货待结算,80=订单成功
  static bool isReturnOrderStatus(int order_status) {
    if (order_status == 70 || order_status == 80) {
      return true;
    }
    return false;
  }

  /// 确认收货
  /// [order_status] 订单状态
  /// [final_sent_type] 支付方式
  /// [hasBuyAuth] 下单权限
  static bool hasConfurmOrderButton(
      int order_status, int final_sent_type, bool hasBuyAuth) {
    // 有下单权限，是待收货，并且满足支付条件
    if (hasBuyAuth &&
        order_status == 60 &&
        (final_sent_type == 10 ||
            final_sent_type == 20 ||
            final_sent_type == 30 ||
            final_sent_type == 21)) {
      return true;
    }
    return false;
  }
}
