
import 'package:event_bus/event_bus.dart';

/// Created by liuwei
/// on 2020-09-23
/// page xfs_event_bus

EventBus eventBus = EventBus();

/// 刷新订单列表
class XFSRefreshOrderListEvent{
  XFSRefreshOrderListEvent();
}

/// 跳转订单列表
class XFSPushOrderListAndRemoveUntil{
  XFSPushOrderListAndRemoveUntil();
}

/// 退出flutter的时候调用
class XFSCloseFlutter{
  XFSCloseFlutter();
}