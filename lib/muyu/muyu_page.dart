import 'dart:math';

// import 'package:flame_audio/flame_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/muyu/animate_text.dart';
import 'package:mini_game/muyu/count_panel.dart';
import 'package:mini_game/muyu/models/image_option.dart';
import 'package:mini_game/muyu/models/merit_record.dart';
import 'package:mini_game/muyu/muyu_hammer.dart';
import 'package:mini_game/muyu/muyu_image.dart';
import 'package:mini_game/muyu/options/select_image.dart';
import 'package:mini_game/muyu/record_history.dart';
import 'package:mini_game/storage/db_storage/db_storage.dart';
import 'package:mini_game/storage/sp_storage.dart';
import 'package:snowflake_dart/snowflake_dart.dart';

import 'models/audio_option.dart';
import 'options/select_audio.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              onPressed: _toHistory,
              icon: const Icon(Icons.history),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CountPanel(
            count: _counter,
            onTapSwitchAudio: _onTapSwitchAudio,
            onTapSwitchImage: _onTapSwitchImage,
          ),
          Positioned(
            bottom: mediaWidth * 0.1,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _imgController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _imgAnimation.value,
                  child: MuyuAssetsImage(
                    //木鱼图片
                    image: activeImage.src, //选定图片
                    onTap: _onKnock,
                  ),
                );
              },
            ),
          ),
          Positioned(
            //木鱼锤
            //绝对定位
            right: 10,
            bottom: mediaWidth * 0.1 + 180,
            child: MuyuHammer(record: _cruRecord != null ? _cruRecord!.id : ''),
          ),
          ..._animatedTexts,
        ],
      ),
    );
  }

  // 状态初始化方法
  @override
  void initState() {
    super.initState();
    // 初始化动作，有序执行，防止音乐加载不到
    _initResource();
    _imgController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // 创建非线性的放大缩小动画
    _imgAnimation = TweenSequence([
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
    ]).animate(_imgController);

    // 监听动画，当开始时播放音频
    _imgController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _audioPool?.start();
      }
    });
  }

  @override
  void dispose() {
    _imgController.dispose();
    super.dispose();
  }

  // 公共部分
  // 雪花ID生成器
  final Snowflake snowflake = Snowflake(nodeId: 1);

  late AnimationController _imgController;

  late Animation<double> _imgAnimation;

  void _initResource() async {
    await _initConfig();
    await _initAudioPool();
  }

  /// =======↓↓↓↓图片相关↓↓↓↓=======

  // 当前木鱼功德累计值
  MeritRecord? _cruRecord;

  List<Widget> _animatedTexts = [];

  int _counter = 0;
  final Random _random = Random();

  // 当前选中的图片下标
  int _activeImageIndex = 0;

  // 图片列表
  final List<ImageOption> imageOptions = const [
    ImageOption(name: '基础版', src: 'assets/images/muyu.png', min: 1, max: 5),
    ImageOption(name: '尊享版', src: 'assets/images/muyu2.png', min: 6, max: 10),
    ImageOption(name: '动画版', src: 'assets/images/muyu3.png', min: 11, max: 15),
  ];

  // 图片选择框弹出
  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onSelectImage,
        );
      },
    );
  }

  // 绑定数据：当前选中图像
  ImageOption get activeImage => imageOptions[_activeImageIndex];

  // 敲击的值
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  // 图片选中回调
  void _onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == _activeImageIndex) return; //未进行变更则不做处理
    setState(() {
      _activeImageIndex = value;
      saveConfig();
    });
  }

  // 木鱼敲击动作
  void _onKnock() async {
    // 动画播放
    _imgController.forward(from: 0.0); //图片缩放

    // 绑定key:方便动画移除
    final animatedTextKey = ValueKey<int>(snowflake.generate());

    AnimationController antTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 生成ID
    final id = snowflake.generate().toString();
    final konckVal = knockValue; //使用临时变量承接，防止两次获取导致值不一致
    // 创建记录信息
    _cruRecord = MeritRecord(
      id: id,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      value: konckVal,
      muyuImage: activeImage.src,
      audio: audioOptions[_activeAudioIndex].name,
      muyuName: activeImage.name,
      meritType: MeritQuality.convert(
        konckVal,
        activeImage.min,
        activeImage.max,
      ),
    );
    // 创建容器
    final textWidget = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Center(
        child: AnimateText(
          key: animatedTextKey,
          record: _cruRecord!,
          controller: antTextController,
        ),
      ),
    );

    // 状态设置
    setState(() {
      _counter += _cruRecord!.value;
      saveConfig();
      DbStorage.instance.meritRecordDao.insert(_cruRecord!);
      _records.add(_cruRecord!);
      // 添加动画文本信息
      _animatedTexts.add(textWidget);
    });

    // 文本动画销毁状态监听处理:清除对应的文本列表
    antTextController
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animatedTexts.removeWhere((item) => item.key == animatedTextKey);
          });
        }
      });
  }

  /// =======↑↑↑↑图片相关↑↑↑↑=======

  /// =======↓↓↓↓音乐相关↓↓↓↓=======
  // 音乐池：用于播放音乐，为三方插件
  late AudioPool? _audioPool;

  /// 选定音乐下标
  int _activeAudioIndex = 0;

  // 音乐列表
  final List<AudioOption> audioOptions = const [
    AudioOption(name: '音乐1', src: 'audio/muyu_1.mp3'),
    AudioOption(name: '音乐2', src: 'audio/muyu_2.mp3'),
    AudioOption(name: '音乐3', src: 'audio/muyu_3.mp3'),
  ];

  // 音乐选择方法
  void _onSelectAudio(int value) async {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex) return; //未进行变更则不做处理

    setState(() {
      _activeAudioIndex = value;
      saveConfig();
    });

    _audioPool = await AudioPool.createFromAsset(
      path: audioOptions[_activeAudioIndex].src,
      maxPlayers: 1,
    );
  }

  // 音乐按钮点击
  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AudioOptionPanel(
          audioOptions: audioOptions,
          activeIndex: _activeAudioIndex,
          onSelect: _onSelectAudio,
        );
      },
    );
  }

  // 初始化音乐选定
  Future<void> _initAudioPool() async {
    _audioPool = await AudioPool.createFromAsset(
      path: audioOptions[_activeAudioIndex].src,
      maxPlayers: 1,
    );
  }

  // =======↑↑↑↑音乐相关↑↑↑↑=======

  // =======↓↓↓↓记录相关↓↓↓↓=======
  List<MeritRecord> _records = [];

  // 历史记录点击
  void _toHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordHistory(records: _records.reversed.toList()),
      ),
    );
  }

  /// =======↑↑↑↑记录相关↑↑↑↑=======

  /// =======↓↓↓↓持久化↓↓↓↓=======
  void saveConfig() {
    SpStorage.instance.saveMuyu(
      counter: _counter,
      activeImageIndex: _activeImageIndex,
      activeAudioIndex: _activeAudioIndex,
    );
  }

  // 初始化配置信息
  Future<void> _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuyuConfig();
    _counter = config['counter'] ?? 0;
    _activeImageIndex = config['activeImageIndex'] ?? 0;
    _activeAudioIndex = config['activeAudioIndex'] ?? 0;
    _records = await DbStorage.instance.meritRecordDao.queryByParams();

    setState(() {});
  }

  /// =======↑↑↑↑持久化↑↑↑↑=======
}
