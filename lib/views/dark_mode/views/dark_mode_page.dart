import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/dark_mode/controllers/dark_mode_controller.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

class DarkModeView extends GetView<DarkModeController> {
  const DarkModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).darkModePageTitle)),
      body: Obx(
        () => ListView(
          children: [
            ListTile(
              title: Text(S.of(context).followSystem),
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
            // 手动设置
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 16, bottom: 6),
              child: Text(S.of(context).manualSetting),
            ),
            // 浅色模式
            ListTile(
              title: Text(S.of(context).lightMode),
              onTap: () {
                controller.setTheme(ThemeMode.light);
              },
              trailing:
                  controller.currentThemeMode.value == ThemeMode.light
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
            ),
            // 深色模式
            ListTile(
              title: Text(S.of(context).darkMode),
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
