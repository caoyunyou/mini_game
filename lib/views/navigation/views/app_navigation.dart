import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/controllers/theme_controller.dart';
import 'package:mini_game/views/guess/guess_page.dart';
import 'package:mini_game/views/muyu/views/muyu_view.dart';
import 'package:mini_game/views/navigation/controllers/bottom_nav_controller.dart';
import 'package:mini_game/views/navigation/views/app_bottom_bar.dart';
import 'package:mini_game/views/paper/views/paper_view.dart';

class AppNavigation extends GetView<BottomNavController> {
  AppNavigation({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: AppBottomBar(
          currentIndex: controller.currentIndex.value,
          onItemTap: (index) => controller.changeTab(index),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: const [GuessPage(), MuyuView(), PaperView()],
        ),
      ),
    );
  }
}
