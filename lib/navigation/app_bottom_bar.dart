import 'package:flutter/material.dart';

class MenuData {
  //标签
  final String label;

  //图标
  final IconData icon;

  const MenuData({required this.label, required this.icon});
}

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged<int>? onItemTap;

  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.menus,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: onItemTap,
      currentIndex: currentIndex,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      //选中
      showUnselectedLabels: true,
      //未选中
      items: menus.map(_buildItemByMenuMeta).toList(),
    );
  }

  BottomNavigationBarItem _buildItemByMenuMeta(MenuData menu) {
    return BottomNavigationBarItem(label: menu.label, icon: Icon(menu.icon));
  }
}
