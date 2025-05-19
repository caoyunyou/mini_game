import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//单例模式，懒汉式
class SpStorage {
  SpStorage._(); //私有化构造器

  static late SharedPreferences _sp;

  static const String _kGuessSpKey = 'guess-config';
  static const String _kMuyuSpKey = 'muyu-config';

  //是否浅色模式
  static const String _kThemeMode = 'theme_mode';

  // 生成对应的SP
  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  // 猜数字游戏存盘
  static Future<bool> saveGuess({
    required bool guessing,
    required int value,
  }) async {
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp.setString(_kGuessSpKey, content);
  }

  // 读取猜字游戏存盘信息
  static Future<Map<String, dynamic>> readGuessConfig() async {
    return _readConfigByKey(_kGuessSpKey);
  }

  // 猜数字游戏存盘
  static Future<bool> saveMuyu({
    required int counter,
    required int activeImageIndex,
    required int activeAudioIndex,
  }) async {
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex,
    });
    return _sp.setString(_kMuyuSpKey, content);
  }

  static Future<Map<String, dynamic>> readMuyuConfig() async {
    return _readConfigByKey(_kMuyuSpKey);
  }

  // 公共方法，通过Key获取json形式的配置信息
  static Future<Map<String, dynamic>> _readConfigByKey(String key) async {
    String content = _sp.getString(key) ?? "{}"; //没有的话给默认值
    return json.decode(content);
  }

  // 获取主题样式
  static ThemeMode getThemeMode()  {
    String themeModeStr = _sp.getString(_kThemeMode) ?? "system";
    return ThemeMode.values.firstWhere((mode) => mode.name == themeModeStr);
  }

  // 设置主题样式
  static void setThemeMode(ThemeMode mode) {
    _sp.setString(_kThemeMode, mode.name);
  }
}
