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
            () => CountPanel(
              count: controller.counter.value,
              onTapSwitchAudio: () => controller.onTapSwitchAudio(context),
              onTapSwitchImage: () => controller.onTapSwitchImage(context),
            ),
          ),
          Positioned(
            bottom: mediaWidth * 0.1,
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
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => Positioned(
              //木鱼锤
              //绝对定位
              right: 10,
              bottom: mediaWidth * 0.1 + 180,
              child: MuyuHammer(record: controller.cruRecord.value?.id ?? ''),
            ),
          ),
          Obx(() => Stack(children: [...controller.animatedTexts])),
        ],
      ),
    );
  }
}
