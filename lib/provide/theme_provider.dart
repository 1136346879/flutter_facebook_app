import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/styles.dart';
import 'package:xfs_flutter_utils/define/xfs_config.dart';
import 'package:xfs_flutter_utils/utils/xfs_utils.dart';

class ThemeProvider {

  ThemeData getTheme() {

    bool isDarkMode = XFSUtils.isWindowDart();

    return ThemeData(
      errorColor: isDarkMode ? Config.dark_red : Config.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Config.dark_app_main : Config.app_main,
      accentColor: isDarkMode ? Config.dark_app_main : Config.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Config.dark_app_main : Config.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? Config.dark_bg_color : Config.colorF5F5F5,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Config.dark_material_bg : Colors.white,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: Config.app_main.withAlpha(70),
      textSelectionHandleColor: Config.app_main,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Config.color2E3034,
        textTheme: TextTheme(
          title: TextStyles.textTile,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Config.dark_line : Config.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),

//      pageTransitionsTheme: NoTransitionsOnWeb(),
    );
  }

}