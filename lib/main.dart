import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mini_game/controllers/theme_controller.dart';
import 'package:mini_game/l10n/generated/l10n.dart';
import 'package:mini_game/router/app_pages.dart';
import 'package:mini_game/storage/db_storage/db_storage.dart';
import 'package:mini_game/themes/app_themes.dart';

import 'l10n/local_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  // 确保初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DbStorage.instance.open(); //打开数据库
  runApp(const MyApp());

  //页面初始化完成后才移除
  // Timer(Duration(seconds: 2), () {
  //   FlutterNativeSplash.remove();
  // });
}

class MyApp extends StatelessWidget with LocalProvider {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      // APP标题
      title: '小游戏',
      //不显示测试DEBUG标志
      debugShowCheckedModeBanner: false,
      //启用日志
      enableLog: true,
      //国际化支持
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: localizationsDelegates,
      // 主题模式
      themeMode: themeController.currentThemeMode.value,
      // 浅色模式
      theme: AppThemes.lightTheme,
      // 神色模式
      darkTheme: AppThemes.darkTheme,
      // home: const AppNavigation(),
      initialRoute: AppPages.INITIAL,
      // 路由信息
      getPages: AppPages.routes,
      // unknownRoute: AppPages.unknownRoute,
      builder: EasyLoading.init(),
    );

  }

  @override
  List<Locale> get supportedLocales => S.delegate.supportedLocales;

  @override
  Iterable<LocalizationsDelegate>? get localizationsDelegates => const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
