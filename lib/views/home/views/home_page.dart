import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_game/router/app_pages.dart';
import 'package:mini_game/views/home/controllers/home_controller.dart';

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
                  ListTile(
                    title: Text('深色模式'),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.dark_mode_rounded),
                    onTap: () {
                      Get.toNamed(AppRoutes.darkMode);
                    },
                  ),
                  // const Divider(thickness: 0.5,height: 0.5), // 分割线
                  const Divider(),
                  ListTile(
                    title: Text('主题设置'),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.color_lens_outlined),
                    onTap: () {
                      Get.toNamed(AppRoutes.themeSettings);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('语言设置'),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.language),
                    onTap: () {
                      Get.toNamed(AppRoutes.languageSetting);
                    },
                  ),
                  SizedBox(height: 10), // 10个长度距离
                  ListTile(
                    title: Text('关于应用'),
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

    //   ScrollConfiguration(
    //     behavior: NoScrollBehavior(),
    //     child: ListView(
    //       padding: EdgeInsets.zero,//
    //       children: [
    //         // 留一点空间
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           children: [
    //
    //           ],
    //         )
    //       ],
    //     )
    //
    //     // 跳转示例
    //     // child: Center(child: ElevatedButton(onPressed: ()=>Get.toNamed('/muyu'), child: Text('点一下')),)
    // );
  }

  bool themeSwitch(bool val) {
    return false;
  }

  Widget _buildListTitle(String title, IconData icon) {
    // Theme.of(context)
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      // 左边标志
      trailing: Icon(Icons.chevron_right),
      //右边组件
      selectedColor: Colors.blue,
      // selected: true,
      tileColor: Colors.white12,
      // splashColor: Colors.white10, // 点击时的水波纹颜色,有些终端本身就支持
      hoverColor: Colors.white24,
      //悬停颜色，在砖面应用才会显示
      onTap: () {
        print('主题设置 => 点击');
      },
    );
  }
}
