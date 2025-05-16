import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/controllers/theme_controller.dart';

class ThemeSettingsPage extends StatelessWidget {

  ThemeSettingsPage({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主题设置')),
      body: ListView(
        children: [
          ListTile(
            title: Text('跟随系统'),
            leading: Radio(
              value: ThemeMode.system,
              groupValue: themeController.currentThemeMode.value,
              onChanged: (value) {
                themeController.setTheme(value as ThemeMode);
              },
            ),
          ),
          ListTile(
            title: Text('浅色模式'),
            leading: Radio(
              value: ThemeMode.light,
              groupValue: themeController.currentThemeMode.value,
              onChanged: (value) {
                themeController.setTheme(value as ThemeMode);
              },
            ),
          ),
          ListTile(
            title: Text('深色模式'),
            leading: Radio(
              value: ThemeMode.dark,
              groupValue: themeController.currentThemeMode.value,
              onChanged: (value) {
                themeController.setTheme(value as ThemeMode);
              },
            ),
          ),
        ],
      ),
    );
  }
}
