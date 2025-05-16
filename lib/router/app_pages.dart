import 'package:get/get.dart';
import 'package:mini_game/views/guess/bindings/guess_binding.dart';
import 'package:mini_game/views/guess/views/guess_page.dart';
import 'package:mini_game/views/muyu/bindings/muyu_binding.dart';
import 'package:mini_game/views/muyu/views/muyu_view.dart';
import 'package:mini_game/views/navigation/bindings/app_nav_binding.dart';
import 'package:mini_game/views/navigation/views/app_navigation.dart';
import 'package:mini_game/views/paper/bindings/paper_binding.dart';
import 'package:mini_game/views/paper/views/paper_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Home;

  static final routes = [
    GetPage(
      name: AppRoutes.Home,
      page: () => AppNavigation(), //起始页面暂定为木鱼页面
      binding: AppNavBinding(),

      // page: () => MainPage(), //起始页面暂定为木鱼页面
      // binding: MainBinding(),
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
