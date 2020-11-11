import 'package:flutter/material.dart';
import 'package:flutter_facebook/screens/screens.dart';
import 'package:xfs_flutter_utils/net/xfs_http.dart';

import 'net/api.dart';
import 'net/error_interceptor.dart';
import 'net/xfs_app_network_manage.dart';

/**
 * app 主入口
 */
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Http.init(baseUrl: API.BASE_URL);
  dio.interceptors.add(ErrorInterceptor());
  XFSAppNetworkStatusManager.instance.startMonitor();
  runApp(MyApp());
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
