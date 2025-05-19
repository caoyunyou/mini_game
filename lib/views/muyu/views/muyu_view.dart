import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/muyu/controllers/muyu_controller.dart';
import 'package:mini_game/views/muyu/widgets/count_panel.dart';
import 'package:mini_game/views/muyu/widgets/muyu_hammer.dart';
import 'package:mini_game/views/muyu/widgets/muyu_image.dart';

class MuyuView extends GetView<MuyuController> {
  const MuyuView({super.key});

  @override
  Widget build(BuildContext context) {
    // 媒体宽度
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("电子木鱼"),
        actions: [
          Tooltip(
            message: '功德记录',
            child: IconButton(
              onPressed: () => controller.toHistory(context),
              icon: const Icon(Icons.history),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(
            // 计数模块
            () => CountPanel(
              count: controller.counter.value,
              onTapSwitchAudio: () => controller.onTapSwitchAudio(context),
              onTapSwitchImage: () => controller.onTapSwitchImage(context),
            ),
          ),
          // 木鱼图片模块
          Positioned(
            bottom: mediaWidth / 10,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: controller.imgController,
              builder: (context, child) {
                return Obx(
                  () => Transform.scale(
                    scale: controller.imgAnimation.value,
                    child: MuyuAssetsImage(
                      //木鱼图片
                      image: controller.activeImage.src, //选定图片
                      onTap: controller.onKnock,
                      height: mediaHeight / 5,
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            // 木鱼锤模块
            () => Positioned(
              //木鱼锤
              //绝对定位
              left: mediaWidth / 2,
              bottom: mediaHeight / 5 + mediaWidth / 10,
              child: MuyuHammer(
                record: controller.cruRecord.value?.id ?? '',
                width: mediaHeight / 5,
                height: mediaHeight / 15,
              ),
            ),
          ),
          // 功德动画
          Obx(() => Stack(children: [...controller.animatedTexts])),
        ],
      ),
    );
  }
}
