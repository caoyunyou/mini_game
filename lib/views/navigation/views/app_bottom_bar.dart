import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/controllers/theme_controller.dart';
import 'package:mini_game/views/navigation/model/app_tab.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

class MenuData {
  //标签
  final String label;

  //图标
  final IconData icon;

  const MenuData({required this.label, required this.icon});
}

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onItemTap;

  AppBottomBar({super.key, required this.currentIndex, this.onItemTap});

  final ThemeController themeController = Get.put(ThemeController());

  // 暂时没有区分颜色
  Color get selectedColor {
    return themeController.currentThemeMode.value == ThemeMode.dark
        ? Colors.blueAccent
        : Colors.blueAccent;
  }

  Color get unSelectedColor {
    return themeController.currentThemeMode.value == ThemeMode.dark
        ? Colors.white
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    S lang = S.of(context);
    return BottomNavigationBar(
      // 背景颜色
      backgroundColor: Theme.of(context).primaryColor,
      // 点击处理
      onTap: onItemTap,
      // 当前下标
      currentIndex: currentIndex,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: selectedColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedItemColor: unSelectedColor,
      showSelectedLabels: true,
      //选中
      showUnselectedLabels: true,
      //未选中
      items:
          AppTab.mobileTabs
              .map(
                (tab) => BottomNavigationBarItem(
                  label: tab.label(lang),
                  icon: Icon(tab.icon),
                ),
              ).toList(),
    );
  }
}
