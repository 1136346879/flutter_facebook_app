class API {
 // static const BASE_URL = 'https://www.wanandroid.com';
//  static const BASE_URL = 'http://127.0.0.1:20155/';
//   static const BASE_URL = 'https://t.fsyuncai.com/api/mobile/';
  static const BASE_URL = 'https://mock.yonyoucloud.com/mock/';

  static const TREE_URL = 'tree/json';

  /// 订单列表
  static const ORDER_LIST = 'order/orderstore/queryStoreOrders';
  /// 删除订单
  static const ORDER_DELETE = 'order/orderstore/removeToRecycle';
  /// 取消订单
  static const ORDER_CANCEL = 'order/cancle/cancleOrder';
  /// 加入购物车
  static const CART_ADD_SHOPPING_CART = 'cart/addShoppingCart';
  /// 再次购买
  static const CART_BUY_AGAIN = 'cart/addShoppingCartReturnSku';
  /// 确认收货
  static const ORDER_CONFIRM_RECEIPT = 'order/confirmreceipt/ConfirmReceipt';
  /// 审批通过
  static const ORDER_CHECK_PASS = 'order/customercheck/checkPass';
  /// 审批驳回
  static const ORDER_CHECK_NO_PASS = 'order/customercheck/checkNotPass';

  /// 地址列表
  static const ADDRESS_LIST = 'membership/adminQueryAddressPerson.jhtml';
  //订单详情查看订单 ---审批流
  static  const  APPROVAL_FLOW = "order/customercheck/getApprovalFlow";

  /// 订单详情
  static const ORDER_DETAILS = 'order/orderstore/queryStoreOrderDetails';
  /// 物流信息
  static const ORDER_LOGISTICS_INFO = 'order/logistics/getOrderLogisticsInfo';
  /// 汇款信息
  static const ORDER_BANK_INFO = 'payment/getBankInfo';

  /// 订单跟踪
  static const ORDER_TRACKING = 'order/orderCirculationRecord/findByOrderId';

  ///https://mock.yonyoucloud.com/mock/16021/currentUser
  static const CURRENT_USER = '16021/currentUser';
}
