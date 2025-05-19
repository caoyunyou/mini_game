import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 3.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    super.onInit();
  }

  // 切换底部按钮
  void changeTab(int index) {
    if (index == currentIndex.value) return;
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
