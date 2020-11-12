
import 'package:flutter/material.dart';

/// 全局key，可以获取context [xfsNavigatorState.currentContext]
GlobalKey<NavigatorState> xfsNavigatorState = GlobalKey<NavigatorState>();
// 全局的路由监听者，可在需要的widget中添加，应该放到一个全局定义的文件中
RouteObserver<PageRoute> xfsRouteObserver = RouteObserver<PageRoute>();

/// 当前运行模式是否 Release
const bool inRelease = const bool.fromEnvironment("dart.vm.product");
