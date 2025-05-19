import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/theme_setting/controllers/theme_setting_controller.dart';

class ThemeSettingView extends GetView<ThemeSettingController> {
  const ThemeSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主题设置')),
      body: Center(child: Text('尽情期待')),
    );
  }
}
