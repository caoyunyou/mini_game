import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_game/router/app_pages.dart';
import 'package:mini_game/views/home/controllers/home_controller.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).appBarTheme.systemOverlayStyle!, //沿用对应主题的样式效果
        child: Column(
          children: [
            // 顶部信息展示区域：人物头像+备注
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/home_bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 10,
                  left: MediaQuery.of(context).size.width / 10,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 8,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ),
                // 名字
                Positioned(
                  top:
                      MediaQuery.of(context).size.height / 10 +
                      MediaQuery.of(context).size.width / 10,
                  left:
                      MediaQuery.of(context).size.width / 10 +
                      MediaQuery.of(context).size.width / 4 +
                      20,
                  child: Text(
                    '曹云友',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                // 座右铭
                Positioned(
                  top:
                      MediaQuery.of(context).size.height / 10 +
                      MediaQuery.of(context).size.width / 4 +
                      10,
                  left: MediaQuery.of(context).size.width / 10 + 10,
                  child: Text(
                    '骐骥一跃，不能十步；驽马十驾，功在不舍。',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                // 头像
              ],
            ),

            // 下部对应的配置区域
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // 深色模式
                  ListTile(
                    title: Text(S.of(context).darkMode),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.dark_mode_rounded),
                    onTap: () {
                      Get.toNamed(AppRoutes.darkMode);
                    },
                  ),
                  // const Divider(thickness: 0.5,height: 0.5), // 分割线
                  const Divider(),
                  // 主题设置
                  ListTile(
                    title: Text(S.of(context).themeSettings),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.color_lens_outlined),
                    onTap: () {
                      Get.toNamed(AppRoutes.themeSettings);
                    },
                  ),
                  const Divider(),
                  // 语言设置
                  ListTile(
                    title: Text(S.of(context).languageSettings),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.language),
                    onTap: () {
                      Get.toNamed(AppRoutes.languageSetting);
                    },
                  ),
                  SizedBox(height: 10), // 10个长度距离
                  ListTile(
                    title: Text(S.of(context).aboutApp),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.question_mark),
                    onTap: () {
                      Get.toNamed(AppRoutes.aboutApp);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
