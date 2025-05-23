// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `我的`
  String get homePageTitle {
    return Intl.message('我的', name: 'homePageTitle', desc: '', args: []);
  }

  /// `敲木鱼游戏`
  String get muyuPageTitle {
    return Intl.message('敲木鱼游戏', name: 'muyuPageTitle', desc: '', args: []);
  }

  /// `猜数字`
  String get guessPageTitle {
    return Intl.message('猜数字', name: 'guessPageTitle', desc: '', args: []);
  }

  /// `画图`
  String get paperPageTitle {
    return Intl.message('画图', name: 'paperPageTitle', desc: '', args: []);
  }

  /// `主页`
  String get mainPageTitle {
    return Intl.message('主页', name: 'mainPageTitle', desc: '', args: []);
  }

  /// `语言设置`
  String get languageSettingPageTitle {
    return Intl.message(
      '语言设置',
      name: 'languageSettingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get chinese {
    return Intl.message('中文', name: 'chinese', desc: '', args: []);
  }

  /// `英文`
  String get english {
    return Intl.message('英文', name: 'english', desc: '', args: []);
  }

  /// `小游戏`
  String get mainTitle {
    return Intl.message('小游戏', name: 'mainTitle', desc: '', args: []);
  }

  /// `大了`
  String get isBig {
    return Intl.message('大了', name: 'isBig', desc: '', args: []);
  }

  /// `小了`
  String get isSmall {
    return Intl.message('小了', name: 'isSmall', desc: '', args: []);
  }

  /// `点击右下角按钮生成随机数`
  String get clickGenerateNum {
    return Intl.message(
      '点击右下角按钮生成随机数',
      name: 'clickGenerateNum',
      desc: '',
      args: [],
    );
  }

  /// `生成随机数`
  String get generateNum {
    return Intl.message('生成随机数', name: 'generateNum', desc: '', args: []);
  }

  /// `电子木鱼`
  String get muyuPageAppbar {
    return Intl.message('电子木鱼', name: 'muyuPageAppbar', desc: '', args: []);
  }

  /// `功德记录`
  String get meritRecord {
    return Intl.message('功德记录', name: 'meritRecord', desc: '', args: []);
  }

  /// `清空提示`
  String get cleanTipTitle {
    return Intl.message('清空提示', name: 'cleanTipTitle', desc: '', args: []);
  }

  /// `当前操作会清空画图内容，请确实是否继续!`
  String get paperPageCleanTip {
    return Intl.message(
      '当前操作会清空画图内容，请确实是否继续!',
      name: 'paperPageCleanTip',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get conform {
    return Intl.message('确认', name: 'conform', desc: '', args: []);
  }

  /// `深色模式`
  String get darkMode {
    return Intl.message('深色模式', name: 'darkMode', desc: '', args: []);
  }

  /// `主题设置`
  String get themeSettings {
    return Intl.message('主题设置', name: 'themeSettings', desc: '', args: []);
  }

  /// `语言设置`
  String get languageSettings {
    return Intl.message('语言设置', name: 'languageSettings', desc: '', args: []);
  }

  /// `关于应用`
  String get aboutApp {
    return Intl.message('关于应用', name: 'aboutApp', desc: '', args: []);
  }

  /// `跟随系统`
  String get followSystem {
    return Intl.message('跟随系统', name: 'followSystem', desc: '', args: []);
  }

  /// `深色模式设置`
  String get darkModePageTitle {
    return Intl.message(
      '深色模式设置',
      name: 'darkModePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `手动设置`
  String get manualSetting {
    return Intl.message('手动设置', name: 'manualSetting', desc: '', args: []);
  }

  /// `浅色模式`
  String get lightMode {
    return Intl.message('浅色模式', name: 'lightMode', desc: '', args: []);
  }

  /// `输入 0~99 之间的数字`
  String get guessPageTooltip {
    return Intl.message(
      '输入 0~99 之间的数字',
      name: 'guessPageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `功德`
  String get merit {
    return Intl.message('功德', name: 'merit', desc: '', args: []);
  }

  /// `音乐选择`
  String get musicSelect {
    return Intl.message('音乐选择', name: 'musicSelect', desc: '', args: []);
  }

  /// `木鱼选择`
  String get muyuSelect {
    return Intl.message('木鱼选择', name: 'muyuSelect', desc: '', args: []);
  }

  /// `取消`
  String get cancel {
    return Intl.message('取消', name: 'cancel', desc: '', args: []);
  }

  /// `画板`
  String get paperPageAppbar {
    return Intl.message('画板', name: 'paperPageAppbar', desc: '', args: []);
  }

  /// `删除`
  String get delete {
    return Intl.message('删除', name: 'delete', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
