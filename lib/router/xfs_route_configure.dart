import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook/address/xfs_address_list_page.dart';
import 'package:flutter_facebook/goods/goods_detail_page.dart';
import 'package:flutter_facebook/goods/goods_page.dart';
import 'package:flutter_facebook/models/xfs_user_model.dart';
import 'package:flutter_facebook/net/xfs_common_channel_utils.dart';
import 'package:flutter_facebook/order/tab_page.dart';
import 'package:flutter_facebook/order/xfs_order_details_page.dart';
import 'package:flutter_facebook/order/xfs_order_export_page.dart';
import 'package:flutter_facebook/order/xfs_order_page.dart';
import 'package:flutter_facebook/order/xfs_order_search_page.dart';
import 'package:flutter_facebook/order/xfs_order_search_result_page.dart';
import 'package:flutter_facebook/order/xfs_order_tab_page.dart';
import 'package:flutter_facebook/pages/az_city_list_page.dart';
import 'package:flutter_facebook/pages/camera_main_page.dart';
import 'package:flutter_facebook/pages/city_list_page.dart';
import 'package:flutter_facebook/screens/home_category_detail.dart';
import 'package:flutter_facebook/screens/nav_screen.dart';
import 'package:flutter_facebook/subject/subject_page.dart';
import 'package:flutter_facebook/testpage/SelectProvider.dart';
import 'package:flutter_facebook/testpage/consumer_provider.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_search_address_page.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_stores_choice_page.dart';
import 'package:xfs_flutter_utils/utils/xfs_log_util.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_custom_router.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_navigator_manage.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_navigator_observer.dart';
import 'package:xfs_flutter_utils/xfs_route/xfs_route.dart';

import '../root_page.dart';
/// on 2020-08-28
/// page xfs_route_configure
///
///

typedef XFSRouteResultBuilder = XFSRouteResult Function(Object);

class XFSAppRouteConfigure {

  static String rootPage = "rootPage";

  ///订单列表页面
  static String orderPage = "XFSOrderPage";
  static String orderTabPage = "XFSOrderTabPage";
  static String tabPage = "TabPage";
  static String orderSearchPage = "orderSearchPage";
  static String consumerProvide = "ConsumerProvide";
  static String selectProvider = "SelectProvider";
  static String orderSearchResultPage = "orderSearchResultPage";
  static String cityLiStPage = "CityLiStPage";
  static String azCityListPage = "AzCityListPage";

  static String xfsOrderExportPage = "xfsOrderExportPage";//订单导出页面

  /// 订单详情页面
  static String orderDetailsPage = "XFSOrderDetailsPage";
  static String orderDetailsInvoicePage = "XFSOrderDetailsInvoicePage";
  static String orderDetailsRemittancePage = "XFSOrderDetailsRemittancePage";

  /// 订单跟踪
  static String orderTrackingPage = "orderTrackingPage";

  ///地址列表页面
  static String xfsAddressListPage = "XFSAddressListPage";
  static String subectListPage = "SubectListPage";
  ///自提地址搜索
  static String xfsSelfRaiseSearchAddress = "XFSSelfRaiseSearchAddress";
  static String xfsOrderApprovalProgressListPage = "xfsOrderApprovalProgressListPage";
  ///门店列表
  static String xFSStoreChoicePage = "xFSStoreChoicePage";
  ///主页
  static String xfsNavScreenPage = "xfsNavScreenPage";
  static String homePageDetail = "HOmePageDetail";
  static String goodsPage = "GoodsPage";
  static String goodsDetailPage = "GoodsDetailPage";
  static String cameraMainPage = "CameraMainPage";

  //统一路由配置
  static Map<String, XFSRouteResultBuilder> routeMap = {
    rootPage: (arguments) => XFSRouteResult(
      widget: XFSRootPage(),
    ),
    homePageDetail: (arguments) => XFSRouteResult(
      widget: HOmePageDetail(arguments:arguments),
    ),
    cityLiStPage: (arguments) => XFSRouteResult(
      widget: CityLiStPage(),
    ),
    xfsSelfRaiseSearchAddress: (arguments) => XFSRouteResult(
      widget: XFSSelfRaiseSearchAddressPage(arguments: arguments),
    ),
    xFSStoreChoicePage: (arguments) => XFSRouteResult(
      widget: XFSStoreChoicePage(arguments: arguments),
    ),
    azCityListPage: (arguments) => XFSRouteResult(
      widget: AzCityListPage(),
    ),
    goodsPage: (arguments) => XFSRouteResult(
      widget: GoodsPage(arguments:arguments),
    ),
    goodsDetailPage: (arguments) => XFSRouteResult(
      widget: GoodsDetailPage(arguments:arguments),
    ),
    cameraMainPage: (arguments) => XFSRouteResult(
      widget: CameraMainPage(arguments:arguments),
    ),

    orderPage: (arguments) => XFSRouteResult(
          widget: XFSOrderPage(arguments: arguments,),
        ),
    orderTabPage: (arguments) => XFSRouteResult(
          widget: XFSOrderTabPage(arguments: arguments,),),

       tabPage: (arguments) => XFSRouteResult(
          widget: TabPage(arguments: arguments,),),
    orderSearchPage: (arguments) => XFSRouteResult(
          widget: XFSOrderSearchPage(),
        ),
    orderSearchResultPage: (arguments) => XFSRouteResult(
      widget: XFSOrderSearchResultPage(arguments: arguments,),
    ),
    xfsOrderExportPage: (arguments) => XFSRouteResult(
      widget: XFSOrderExportPage(arguments: arguments,),
    ),
    subectListPage: (arguments) => XFSRouteResult(
      widget: SubectListPage(arguments: arguments,),
    ),
    //
    orderDetailsPage: (arguments) => XFSRouteResult(
          widget: XFSOrderDetailsPage(arguments: arguments),
        ),
    xfsNavScreenPage: (arguments) => XFSRouteResult(
      widget: NavScreen(),
    ),
    consumerProvide: (arguments) => XFSRouteResult(
      widget: ConsumerProvide(),
    ),
    selectProvider: (arguments) => XFSRouteResult(
      widget: SelectProvider(),
    ),
    xfsAddressListPage: (arguments) => XFSRouteResult(
          widget: XFSAddressListPage(),
        ),
    // xfsOrderApprovalProgressListPage: (arguments) => XFSRouteResult(
    //       widget: XFSOrderApprovalProcessListPage(orderId: arguments),
    //     ),
    //
    // orderDetailsInvoicePage: (arguments) => XFSRouteResult(
    //       widget: XFSOrderDetailsInvoicePage(orderDetailsModel: arguments,),
    //     ),
    //
    // orderDetailsRemittancePage: (arguments) => XFSRouteResult(
    //       widget: XFSOrderDetailsRemittancePage(argument: arguments),
    //     ),
    //
    // orderTrackingPage: (arguments) => XFSRouteResult(
    //   widget: XFSOrderTrackingPage(arguments: arguments,),
    // ),
    // xfsSelfRaiseSearchAddress: (arguments) => XFSRouteResult(
    //   widget: XFSSelfRaiseSearchAddressPage(arguments: arguments),
    // ),

  };

  //统一路由处理：参数、回调
  static Route routeConfigureHandler(RouteSettings routeSettings) {

    XFSRouteResult routeResult = routeMap[routeSettings.name](routeSettings.arguments);

    XFSRouteSettings newRouteSettings = XFSRouteSettings(
      arguments: routeSettings.arguments,
      name: routeSettings.name,
      title: routeResult.title,
      routeName: routeResult.routeName,
      showStatusBar: routeResult.showStatusBar,
    );

    Widget page = routeResult.widget ?? NoRoute();

    return XFSCustomPageRoute(
        settings: newRouteSettings,
        page: page,
        title: newRouteSettings.title,
        transition: routeResult.pageRouteType,
        opaque: false,
        transitionDuration: routeResult.pageRouteType == XFSPageRouteType.downToUp ? Duration(milliseconds: 300) : Duration(milliseconds: 400),
        popGesture: (routeResult.pageRouteType == XFSPageRouteType.cupertino || routeResult.pageRouteType == XFSPageRouteType.rightToLeft) ? true : false,
        fullscreenDialog: routeResult.pageRouteType == XFSPageRouteType.downToUp
    );

  }

  // 导航路由监听
  static final navigatorObserver = XFSNavigatorObserver(
    routeChange: (oldRouteName, newRouteName, opType){
      XFSLogUtil.info("旧：${oldRouteName}------新：${newRouteName}--- 跳转方式：${opType.toString()}", stackTrace: StackTrace.current, funcName: "navigatorObservers");

      // 监听页面变化，告诉原生flutter当前处于哪个页面,如果是rootPage则显示当前进入flutter的入口
      if (Platform.isIOS){
        XFSCommonChannelUtils.currentRouteName(newRouteName == 'rootPage' ? xfsUserInfo.route : newRouteName);
      }

      switch (opType) {
        case XFSNaviOPType.push:
          XFSNavigatorManage.addRoute(newRouteName);
          break;
        case XFSNaviOPType.pop:
          XFSNavigatorManage.removeRoute(oldRouteName);
          break;
      }

      XFSLogUtil.info("当前路由栈：${xfsNaviPagelist.toString()}");
    }
  );
}