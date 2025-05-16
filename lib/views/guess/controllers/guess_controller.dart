import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_game/storage/sp_storage.dart';

class GuessController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _initConfig();
  }

  Future<void> _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readGuessConfig();
    guessing = config['guessing'] ?? false;
    value = config['value'] ?? 0;
  }

  Rx<int> value = 0.obs;
  final Random _random = Random();
  Rx<bool> guessing = Rx(false);
  Rx<bool?> isBig = Rx(null);

  // 生成随机数
  void generateRandomValue() {
    guessing.value = true; //点击按钮标识游戏开启
    value.value = _random.nextInt(100);
    SpStorage.instance.saveGuess(guessing: guessing.value, value: value.value);
  }

  @override
  void dispose() {
    guessCtl.dispose();
    animationController.dispose();
    super.dispose();
  }

  final TextEditingController guessCtl = TextEditingController();

  //点击时间
  void onCheck() {
    int? guessValue = int.tryParse(guessCtl.text); //类型转换
    if (!guessing.value || guessValue == null) return;
    animationController.forward(from: 0); //动画执行
    //猜对了
    if (guessValue == value.value) {
      isBig.value = null;
      guessing.value = false;
      return;
    }
    // 猜错了
    isBig.value = guessValue > value.value;
  }
}
