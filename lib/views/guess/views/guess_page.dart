import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/guess/controllers/guess_controller.dart';
import 'package:mini_game/views/guess/widgets/result_nitice.dart';

import 'guess_app_bar.dart';

class GuessView extends GetView<GuessController> {
  const GuessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: controller.onCheck,
        controller: controller.guessCtl,
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.isBig.value != null)
              Column(
                children: [
                  if (controller.isBig.value!)
                    ResultNotice(
                      color: Colors.redAccent,
                      info: '大了',
                      controller: controller.animationController,
                    ),
                  Spacer(),
                  if (!controller.isBig.value!)
                    ResultNotice(
                      color: Colors.blueAccent,
                      info: '小了',
                      controller: controller.animationController,
                    ),
                ],
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!controller.guessing.value) const Text('点击生成随机数'),
                  Text(
                    controller.guessing.value
                        ? '**'
                        : '${controller.value.value}',
                    style: const TextStyle(
                      fontSize: 68,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed:
              controller.guessing.value ? null : controller.generateRandomValue,
          backgroundColor:
              controller.guessing.value ? Colors.grey : Colors.blue,
          tooltip: 'Increment',
          child: const Icon(Icons.generating_tokens_outlined),
        ),
      ),
    );
  }
}
