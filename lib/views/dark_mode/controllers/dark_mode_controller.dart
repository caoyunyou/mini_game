import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/storage/sp_storage.dart';
import 'package:mini_game/themes/app_theme.dart';

// 主题控制器
class DarkModeController extends GetxController {
  Rx<ThemeMode?> currentThemeMode = Rx(null);

  Rx<bool> isFollowSystem = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(SystemThemeObserver());


    currentThemeMode.value = SpStorage.getThemeMode();
    // 判断是否跟随系统:
    isFollowSystem.value = ThemeMode.system == currentThemeMode.value;
    _loadUserTheme();
  }

  // 加载主题
  void _loadUserTheme() async {
    currentThemeMode.value = SpStorage.getThemeMode();
  }

  // 设置主题
  void setTheme(ThemeMode mode) {
    currentThemeMode.value = mode;
    isFollowSystem.value = ThemeMode.system == currentThemeMode.value;
    AppTheme.changeTheme(mode);
  }

  ThemeData get currentTheme {
    switch (currentThemeMode.value) {
      case ThemeMode.light:
        return AppTheme.lightTheme;
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      default:
        return MediaQuery.platformBrightnessOf(Get.context!) == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
    }
  }
}

// 系统主题观察器
class SystemThemeObserver extends WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {
    final DarkModeController themeController = Get.find<DarkModeController>();
    if (themeController.currentThemeMode.value == ThemeMode.system) {
      themeController.currentThemeMode.value =
          MediaQuery.platformBrightnessOf(Get.context!) == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
    }
  }
}
