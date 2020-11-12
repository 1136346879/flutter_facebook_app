import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_facebook/provide/theme_provider.dart';
import 'package:flutter_facebook/router/xfs_route_configure.dart';
import 'package:flutter_facebook/screens/screens.dart';
import 'package:xfs_flutter_utils/net/xfs_http.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/defines.dart';
import 'net/api.dart';
import 'net/error_interceptor.dart';
import 'net/xfs_app_network_manage.dart';

/**
 * app 主入口
 */
void main() {
  runZoned<Future<void>>(() async{
    WidgetsFlutterBinding.ensureInitialized();
    Http.init(baseUrl: API.BASE_URL);
    dio.interceptors.add(ErrorInterceptor());
    XFSAppNetworkStatusManager.instance.startMonitor();
    XFSNavigatorManage.init('rootPage');
    // runApp(MyApp());
    runApp(_routerTo());
  },onError:(error,stackTrace)async{
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  XFSLogUtil.info('catch error= $error');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: NavScreen(),
    );
  }
}

Widget _routerTo() => MaterialApp(

  debugShowCheckedModeBanner: false,
  // initialRoute: XFSAppRouteConfigure.rootPage,
  initialRoute: XFSAppRouteConfigure.xfsNavScreenPage,
  theme:ThemeProvider().getTheme(),
  darkTheme: ThemeProvider().getTheme(),
  onGenerateRoute: (settings) => XFSAppRouteConfigure.routeConfigureHandler(settings),
  localizationsDelegates: [
    XFSLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  navigatorObservers: [
    xfsRouteObserver,
    XFSAppRouteConfigure.navigatorObserver,
  ],
  navigatorKey: xfsNavigatorState,
  supportedLocales: [
    const Locale('zh', 'CH'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CH'),
);

