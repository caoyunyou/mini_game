import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess-config';
const String kMuyuSpKey = 'muyu-config';

//单例模式，懒汉式
class SpStorage {
  SpStorage._(); //私有化构造器

  static SpStorage? _spStorage;

  static SpStorage get instance {
    _spStorage = _spStorage ?? SpStorage._();
    return _spStorage!;
  }

  SharedPreferences? _sp;

  // 生成对应的SP
  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  // 猜数字游戏存盘
  Future<bool> saveGuess({required bool guessing, required int value}) async {
    await initSpWhenNull();
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp!.setString(kGuessSpKey, content);
  }

  // 读取猜字游戏存盘信息
  Future<Map<String, dynamic>> readGuessConfig() async {
    return readConfigByKey(kGuessSpKey);
  }

  // 猜数字游戏存盘
  Future<bool> saveMuyu({
    required int counter,
    required int activeImageIndex,
    required int activeAudioIndex,
  }) async {
    await initSpWhenNull();
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex,
    });
    return _sp!.setString(kMuyuSpKey, content);
  }

  Future<Map<String, dynamic>> readMuyuConfig() async {
    return readConfigByKey(kMuyuSpKey);
  }

  // 公共方法，通过Key获取json形式的配置信息
  Future<Map<String, dynamic>> readConfigByKey(String key) async {
    await initSpWhenNull();
    String content = _sp!.getString(key) ?? "{}"; //没有的话给默认值
    return json.decode(content);
  }
}
