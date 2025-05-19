import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/dark_mode/controllers/dark_mode_controller.dart';

class DarkModeView extends GetView<DarkModeController> {
  const DarkModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主题设置')),
      body: Obx(
        () => ListView(
          children: [
            ListTile(
              title: Text('跟随系统'),
              // leading: Radio(
              //   value: ThemeMode.system,
              //   groupValue: controller.currentThemeMode.value,
              //   onChanged: (value) {
              //     // 跟随系统
              //     controller.setTheme(value as ThemeMode);
              //   },
              // ),
              trailing: Switch(
                value: controller.isFollowSystem.value,
                onChanged: (bool value) {
                  if (value) {
                    controller.setTheme(ThemeMode.system);
                  } else {
                    controller.setTheme(ThemeMode.light);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 16, bottom: 6),
              child: Text("手动设置"),
            ),
            ListTile(
              title: Text('浅色模式'),
              onTap: () {
                controller.setTheme(ThemeMode.light);
              },
              trailing:
                  controller.currentThemeMode.value == ThemeMode.light
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
            ),
            ListTile(
              title: Text('深色模式'),
              onTap: () {
                controller.setTheme(ThemeMode.dark);
              },
              trailing:
                  controller.currentThemeMode.value == ThemeMode.dark
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
