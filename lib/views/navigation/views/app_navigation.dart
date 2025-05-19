import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/guess/views/guess_view.dart';
import 'package:mini_game/views/home/views/home_page.dart';
import 'package:mini_game/views/muyu/views/muyu_view.dart';
import 'package:mini_game/views/navigation/controllers/bottom_nav_controller.dart';
import 'package:mini_game/views/navigation/views/app_bottom_bar.dart';
import 'package:mini_game/views/paper/views/paper_view.dart';

class AppNavigation extends GetView<BottomNavController> {
  const AppNavigation({super.key});


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
          children: const [GuessView(), MuyuView(), PaperView(),HomeView()],
        ),
      ),
    );
  }
}
