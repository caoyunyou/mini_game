import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_game/storage/sp_storage.dart';

// app主题
class AppTheme {
  static final lightTheme = ThemeData(
    // fontFamily: fontFamily,
    // primaryColor: Colors.white70,
    primaryColor: const Color(0xff4699FB),
    scaffoldBackgroundColor: const Color(0xffF3F4F6),
    useMaterial3: true,
    // Android 使用 Material3
    chipTheme: const ChipThemeData(
      padding: EdgeInsets.symmetric(horizontal: 10),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      textColor: Color(0xff333333),
    ),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withValues(alpha: 0.3),
    ),
    // 分割线
    dividerTheme: DividerThemeData(
      color: const Color(0xffDEE0E2),
      space: 1 / window.devicePixelRatio,
      thickness: 1 / window.devicePixelRatio,
    ),
    // pageTransitionsTheme: const PageTransitionsTheme(builders: {}),
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        return states.contains(WidgetState.focused) ? null : Colors.transparent;
      }),
    ),
    // 底部导航栏
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff4699FB),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        // fontFamily: fontFamily,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff010201),
    // pageTransitionsTheme: const PageTransitionsTheme(builders: {}),
    tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
    // fontFamily: [fontFamily],
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xff4699FB),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xff181818),
      textColor: Color(0xffD6D6D6),
    ),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withOpacity(0.3),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: const Color(0xff181818),
      iconTheme: const IconThemeData(color: Color(0xffCCCCCC)),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xffCCCCCC),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff4699FB),
    ),
    dividerTheme: DividerThemeData(
      color: const Color(0xff2F2F2F),
      space: 1 / window.devicePixelRatio,
      thickness: 1 / window.devicePixelRatio,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff181818),
      selectedItemColor: Color(0xff4699FB),
    ),
  );

  // 切换主题
  static changeTheme(ThemeMode mode) {
    SpStorage.setThemeMode(mode);
    // 使用GetX进行对应的注意更改
    Get.changeThemeMode(mode);
  }
}
