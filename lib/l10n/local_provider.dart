import 'package:flutter/material.dart';

enum LanguageCode { zh, en }

class LocalProvider with ChangeNotifier  {
  LanguageCode languageCode = LanguageCode.zh;

  // 语言切换
  void changeLanguage(LanguageCode languageCode) {
    this.languageCode = languageCode;
    notifyListeners();
  }
}
