import 'package:flutter/foundation.dart';

enum LanguageCode { zh, en }

class LocalProvider with ChangeNotifier, DiagnosticableTreeMixin {
  LanguageCode languageCode = LanguageCode.zh;

  // 语言切换
  void changeLanguage(LanguageCode languageCode) {
    print('修改前: => ${this.languageCode}');
    this.languageCode = languageCode;
    print('修改后: => ${this.languageCode}');
    notifyListeners();
  }
}
