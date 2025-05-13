import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_game/guess/result_nitice.dart';
import 'package:mini_game/storage/sp_storage.dart';

import 'guess_app_bar.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _initConfig();
  }

  Future<void> _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readGuessConfig();
    _guessing = config['guessing'] ?? false;
    _value = config['value'] ?? 0;
    setState(() {});
  }

  int _value = 0;
  final Random _random = Random();
  bool _guessing = false;
  bool? _isBig;

  // 生成随机数
  void _generateRandomValue() {
    setState(() {
      _guessing = true; //点击按钮标识游戏开启
      _value = _random.nextInt(100);
      SpStorage.instance.saveGuess(guessing: _guessing, value: _value);
    });
  }

  @override
  void dispose() {
    _guessCtl.dispose();
    controller.dispose();
    super.dispose();
  }

  TextEditingController _guessCtl = TextEditingController();

  //点击时间
  void _onCheck() {
    print("=====Check目标值$_value=====${_guessCtl.text}======");
    int? guessValue = int.tryParse(_guessCtl.text); //类型转换
    if (!_guessing || guessValue == null) return;
    controller.forward(from: 0); //动画执行
    //猜对了
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      return;
    }
    // 猜错了
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: GuessAppBar(onCheck: _onCheck, controller: _guessCtl),
      body: Stack(
        children: [
          if (_isBig != null)
            Column(
              children: [
                if (_isBig!)
                  ResultNotice(
                    color: Colors.redAccent,
                    info: '大了',
                    controller: controller,
                  ),
                Spacer(),
                if (!_isBig!)
                  ResultNotice(
                    color: Colors.blueAccent,
                    info: '小了',
                    controller: controller,
                  ),
              ],
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing) const Text('点击生成随机数'),
                Text(
                  _guessing ? '**' : '$_value',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}
