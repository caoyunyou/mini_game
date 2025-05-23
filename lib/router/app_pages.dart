import 'package:get/get.dart';
import 'package:mini_game/views/about_app/bindings/about_app_binding.dart';
import 'package:mini_game/views/about_app/views/about_app_view.dart';
import 'package:mini_game/views/dark_mode/bindings/dark_mode_binding.dart';
import 'package:mini_game/views/dark_mode/views/dark_mode_page.dart';
import 'package:mini_game/views/guess/bindings/guess_binding.dart';
import 'package:mini_game/views/guess/views/guess_view.dart';
import 'package:mini_game/views/home/bindings/home_binding.dart';
import 'package:mini_game/views/home/views/home_page.dart';
import 'package:mini_game/views/language_setting/bindings/language_setting_binding.dart';
import 'package:mini_game/views/language_setting/views/language_setting_view.dart';
import 'package:mini_game/views/muyu/bindings/muyu_binding.dart';
import 'package:mini_game/views/muyu/views/muyu_view.dart';
import 'package:mini_game/views/navigation/bindings/app_nav_binding.dart';
import 'package:mini_game/views/navigation/views/app_navigation.dart';
import 'package:mini_game/views/paper/bindings/paper_binding.dart';
import 'package:mini_game/views/paper/views/paper_view.dart';
import 'package:mini_game/views/theme_setting/bindings/theme_setting_binding.dart';
import 'package:mini_game/views/theme_setting/views/theme_setting_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Main;

  static final routes = [
    GetPage(
      name: AppRoutes.Main,
      page: () => AppNavigation(), //起始页面暂定为木鱼页面
      binding: AppNavBinding(),
    ),
    // 画图游戏
    GetPage(
      name: AppRoutes.Paper,
      page: () => PaperView(),
      binding: PaperBinding(),
    ),
    // 木鱼游戏
    GetPage(
      name: AppRoutes.Muyu,
      page: () => MuyuView(),
      binding: MuyuBinding(),
    ),
    // 猜数字
    GetPage(
      name: AppRoutes.Guess,
      page: () => GuessView(),
      binding: GuessBinding(),
    ),
    // 个人主页
    GetPage(
      name: AppRoutes.Home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // 深色模式
    GetPage(
      name: AppRoutes.darkMode,
      page: () => DarkModeView(),
      binding: DarkModeBinding(),
    ),
    // 主题设置
    GetPage(
      name: AppRoutes.themeSettings,
      page: () => ThemeSettingView(),
      binding: ThemeSettingBinding(),
    ),
    // 关于APP
    GetPage(
      name: AppRoutes.aboutApp,
      page: () => AboutAppView(),
      binding: AboutAppBinding(),
    ),
    // 语言设置
    GetPage(
      name: AppRoutes.languageSetting,
      page: () => LanguageSettingView(),
      binding: LanguageSettingBinding(),
    ),
  ];

  // 后面再写未找到的页面
  // static final unknownRoute = GetPage(
  //   name: AppRoutes.NotFound,
  //   page: () => NotfoundPage(),
  // );

  // static final proxyRoute = GetPage(
  //   name: AppRoutes.Proxy,
  //   page: () => ProxyPage(),
  // );
}
