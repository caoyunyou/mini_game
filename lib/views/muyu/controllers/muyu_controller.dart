import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/storage/db_storage/db_storage.dart';
import 'package:mini_game/storage/sp_storage.dart';
import 'package:mini_game/views/muyu/models/audio_option.dart';
import 'package:mini_game/views/muyu/models/image_option.dart';
import 'package:mini_game/views/muyu/models/merit_record.dart';
import 'package:mini_game/views/muyu/widgets/animate_text.dart';
import 'package:mini_game/views/muyu/widgets/record_history.dart';
import 'package:mini_game/views/muyu/widgets/select_audio.dart';
import 'package:mini_game/views/muyu/widgets/select_image.dart';
import 'package:snowflake_dart/snowflake_dart.dart';

class MuyuController extends GetxController with GetTickerProviderStateMixin {
  // 公共部分
  // 雪花ID生成器
  final Snowflake snowflake = Snowflake(nodeId: 1);

  late AnimationController imgController;

  late Animation<double> imgAnimation;

  // 当前木鱼功德累计值
  final Rx<MeritRecord?> cruRecord = Rx<MeritRecord?>(null);

  final RxList<Widget> animatedTexts = <Widget>[].obs;

  // 集中管理动态动画控制器
  final RxList<AnimationController> antTextControllers = RxList<AnimationController>([]);

  final Rx<int> counter = 0.obs;
  final Random _random = Random();

  // 当前选中的图片下标
  final Rx<int> _activeImageIndex = 0.obs;

  // 绑定数据：当前选中图像
  ImageOption get activeImage => imageOptions[_activeImageIndex.value];


  // 音乐池：用于播放音乐，为三方插件
  late AudioPool? _audioPool;

  /// 选定音乐下标
  final Rx<int> _activeAudioIndex = 0.obs;

  List<MeritRecord> _records = [];

  // 音乐列表
  final List<AudioOption> audioOptions = const [
    AudioOption(name: '音乐1', src: 'audio/muyu_1.mp3'),
    AudioOption(name: '音乐2', src: 'audio/muyu_2.mp3'),
    AudioOption(name: '音乐3', src: 'audio/muyu_3.mp3'),
  ];

  // 图片列表
  final List<ImageOption> imageOptions = const [
    ImageOption(name: '基础版', src: 'assets/images/muyu.png', min: 1, max: 5),
    ImageOption(name: '尊享版', src: 'assets/images/muyu2.png', min: 6, max: 10),
    ImageOption(name: '动画版', src: 'assets/images/muyu3.png', min: 11, max: 15),
  ];

  // 敲击的值
  int get knockValue {
    int min = imageOptions[_activeImageIndex.value].min;
    int max = imageOptions[_activeImageIndex.value].max;
    return min + _random.nextInt(max + 1 - min);
  }

  // 状态初始化方法
  @override
  void onInit() {
    super.onInit();
    // 初始化动作，有序执行，防止音乐加载不到
    _initResource();
    imgController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // 创建非线性的放大缩小动画
    imgAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.1,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(imgController);

    // 监听动画，当开始时播放音频
    imgController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        print('???');
        _audioPool?.start();
      }
    });
  }

  @override
  void onClose() {
    // 销毁所有未完成的动画控制器
    for (final controller in antTextControllers) {
      if (controller.isAnimating) {
        controller.stop();
      }
      controller.dispose();
    }
    imgController.dispose();
    antTextControllers.clear();
    super.onClose();
  }

  void _initResource() async {
    await _initConfig();
    await _initAudioPool();
  }

  /// =======↓↓↓↓图片相关↓↓↓↓=======

  // 图片选择框弹出
  void onTapSwitchImage(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex.value,
          onSelect: (index) => _onSelectImage(index, context),
        );
      },
    );
  }

  // 图片选中回调
  void _onSelectImage(int value, BuildContext context) {
    Navigator.of(context).pop();
    print('before -> $_activeImageIndex');
    if (value == _activeImageIndex.value) return; //未进行变更则不做处理
    _activeImageIndex.value = value;
    print('after -> $_activeImageIndex');
    saveConfig();
  }

  // 木鱼敲击动作
  void onKnock() async {
    print('敲击事件');
    // 动画播放
    imgController.forward(from: 0.0); //图片缩放

    // 绑定key:方便动画移除
    final animatedTextKey = ValueKey<int>(snowflake.generate());

    final antTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 将控制器添加到列表
    antTextControllers.add(antTextController);


    // 生成ID
    final id = snowflake.generate().toString();
    final konckVal = knockValue; //使用临时变量承接，防止两次获取导致值不一致

    final record = MeritRecord(
      id: id,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      value: konckVal,
      muyuImage: activeImage.src,
      audio: audioOptions[_activeAudioIndex.value].name,
      muyuName: activeImage.name,
      meritType: MeritQuality.convert(
        konckVal,
        activeImage.min,
        activeImage.max,
      ),
    );
    // 创建记录信息
    cruRecord.value = record;
    // 创建容器
    final textWidget = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Center(
        child: AnimateText(
          key: animatedTextKey,
          record: record,
          controller: antTextController,
        ),
      ),
    );

    // 状态设置
    counter.value += record.value;
    saveConfig();
    DbStorage.instance.meritRecordDao.insert(record);
    _records.add(record);
    // 添加动画文本信息
    animatedTexts.add(textWidget);

    // 文本动画销毁状态监听处理:清除对应的文本列表
    antTextController
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          antTextController.dispose();
          antTextControllers.remove(antTextController);
          animatedTexts.removeWhere((item) => item.key == animatedTextKey);
        }
      });
  }

  /// =======↑↑↑↑图片相关↑↑↑↑=======

  /// =======↓↓↓↓音乐相关↓↓↓↓=======

  // 音乐选择方法
  void _onSelectAudio(int value, BuildContext context) async {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex.value) return; //未进行变更则不做处理

    _activeAudioIndex.value = value;
    saveConfig();

    _audioPool = await AudioPool.createFromAsset(
      path: audioOptions[_activeAudioIndex.value].src,
      maxPlayers: 1,
    );
  }

  // 音乐按钮点击
  void onTapSwitchAudio(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AudioOptionPanel(
          audioOptions: audioOptions,
          activeIndex: _activeAudioIndex.value,
          onSelect: (index) => _onSelectAudio(index, context),
        );
      },
    );
  }

  // 初始化音乐选定
  Future<void> _initAudioPool() async {
    _audioPool = await AudioPool.createFromAsset(
      path: audioOptions[_activeAudioIndex.value].src,
      maxPlayers: 1,
    );
  }

  // =======↑↑↑↑音乐相关↑↑↑↑=======

  // =======↓↓↓↓记录相关↓↓↓↓=======

  // 历史记录点击
  void toHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordHistory(records: _records.reversed.toList()),
      ),
    );
  }

  /// =======↑↑↑↑记录相关↑↑↑↑=======

  /// =======↓↓↓↓持久化↓↓↓↓=======
  void saveConfig() {
    SpStorage.saveMuyu(
      counter: counter.value,
      activeImageIndex: _activeImageIndex.value,
      activeAudioIndex: _activeAudioIndex.value,
    );
  }

  // 初始化配置信息
  Future<void> _initConfig() async {
    Map<String, dynamic> config = await SpStorage.readMuyuConfig();
    counter.value = config['counter'] ?? 0;
    _activeImageIndex.value = config['activeImageIndex'] ?? 0;
    _activeAudioIndex.value = config['activeAudioIndex'] ?? 0;
    _records = await DbStorage.instance.meritRecordDao.queryByParams();
  }

  /// =======↑↑↑↑持久化↑↑↑↑=======
}
