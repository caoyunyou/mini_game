import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/themes/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 主题控制器
class ThemeController extends GetxController {
  var currentThemeMode = ThemeMode.system.obs;

  final String _themeKey = 'user_theme_mode';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(SystemThemeObserver());
    _loadUserTheme();
  }

  // 加载主题
  void _loadUserTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeKey);

    if (savedMode == 'light') {
      currentThemeMode.value = ThemeMode.light;
    } else if (savedMode == 'dark') {
      currentThemeMode.value = ThemeMode.dark;
    } else {
      // 默认跟随系统
      currentThemeMode.value = ThemeMode.system;
    }
  }

  // 设置主题
  void setTheme(ThemeMode mode) {
    currentThemeMode.value = mode;
    _saveUserTheme(mode);
  }

  void _saveUserTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_themeKey, mode.toString().split('.').last);
  }

  ThemeData get currentTheme {
    switch (currentThemeMode.value) {
      case ThemeMode.light:
        return AppThemes.lightTheme;
      case ThemeMode.dark:
        return AppThemes.darkTheme;
      default:
        return MediaQuery.platformBrightnessOf(Get.context!) == Brightness.dark
            ? AppThemes.darkTheme
            : AppThemes.lightTheme;
    }
  }
}

// 系统主题观察器
class SystemThemeObserver extends WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {
    final ThemeController themeController = Get.find<ThemeController>();
    if (themeController.currentThemeMode.value == ThemeMode.system) {
      themeController.currentThemeMode.value =
          MediaQuery.platformBrightnessOf(Get.context!) == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
    }
  }
}
