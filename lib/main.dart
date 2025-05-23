import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mini_game/l10n/generated/l10n.dart';
import 'package:mini_game/router/app_pages.dart';
import 'package:mini_game/storage/db_storage/db_storage.dart';
import 'package:mini_game/storage/sp_storage.dart';
import 'package:mini_game/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'l10n/local_provider.dart';

void main() async {
  // 确保初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SpStorage.init(); // 持久化工具初始化
  await DbStorage.instance.open(); //打开数据库
  runApp(const MyApp());

  //页面初始化完成后才移除
  Timer(Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 第一步
        ChangeNotifierProvider(
          create: (_) {
            return LocalProvider();
          },
        ),
      ],
      builder: (BuildContext context, Widget? child) {
        // 第二步
        LanguageCode languageCode = context.watch<LocalProvider>().languageCode;
        return GetMaterialApp(
          // APP标题
          title: '小游戏',
          //不显示测试DEBUG标志
          debugShowCheckedModeBanner: false,
          //启用日志
          enableLog: true,
          //国际化支持
          supportedLocales: S.delegate.supportedLocales,
          // 语言:本来因该是动态绑定的，但是目前是静态绑定，无法完成对应languageCode切换实现语言切换。只能在localeResolutionCallback里面做了
          locale: Locale.fromSubtags(languageCode: languageCode.name),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // 语言解析:默认中文
          localeResolutionCallback: (
            Locale? locale,
            Iterable<Locale> supportedLocales,
          ) {
            // Locale currentLocale = Locale.fromSubtags(
            //   languageCode: locale?.languageCode ?? "zh",
            // );
            // 目前得到的 locale?.languageCode 一直都是zh，只能使用 languageCode.name 了
            Locale currentLocale = Locale.fromSubtags(
              languageCode: languageCode.name,
            );
            return supportedLocales.contains(currentLocale)
                ? currentLocale
                : const Locale.fromSubtags(languageCode: "zh");
          },
          // 主题模式
          themeMode: SpStorage.getThemeMode(),
          // 浅色模式
          theme: AppTheme.lightTheme,
          // 神色模式
          darkTheme: AppTheme.darkTheme,
          // home: const AppNavigation(),
          initialRoute: AppPages.INITIAL,
          // 路由信息
          getPages: AppPages.routes,
          // unknownRoute: AppPages.unknownRoute,
          builder: EasyLoading.init(),
        );
      },
    );
  }

  // 解析，默认中文
  Locale? languageResolve(Locale? locale, Iterable<Locale> supportedLocales) {
    Locale currentLocale = Locale.fromSubtags(
      languageCode: locale?.languageCode ?? "zh",
    );
    return supportedLocales.contains(currentLocale)
        ? currentLocale
        : const Locale.fromSubtags(languageCode: "zh");
  }
}
