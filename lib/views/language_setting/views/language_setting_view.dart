import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/l10n/generated/l10n.dart';
import 'package:mini_game/l10n/local_provider.dart';
import 'package:mini_game/views/language_setting/controllers/language_setting_controller.dart';
import 'package:provider/provider.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  const LanguageSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageCode languageCode = context.watch<LocalProvider>().languageCode;
    return Scaffold(
      appBar: AppBar(title: Text('语言设置')),
      body: ListView(
        children: [
          // 切换为中文
          ListTile(
            leading: Text(S.of(context).chinese),
            trailing:
                languageCode == LanguageCode.zh
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
            onTap: () {
              context.read<LocalProvider>().changeLanguage(LanguageCode.zh);
            },
          ),
          ListTile(
            // 切换为英文
            leading: Text(S.of(context).english),
            trailing:
                languageCode == LanguageCode.en
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
            onTap: () {
              context.read<LocalProvider>().changeLanguage(LanguageCode.en);
            },
          ),
        ],
      ),
    );
  }
}
