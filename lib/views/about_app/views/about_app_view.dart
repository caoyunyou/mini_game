import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/about_app/controllers/about_app_controller.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于应用')),
      body: Center(child: Text("尽情期待....")),
    );
  }
}
