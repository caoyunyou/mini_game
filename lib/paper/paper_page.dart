import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mini_game/paper/color_select.dart';
import 'package:mini_game/paper/conform_dialog.dart';
import 'package:mini_game/paper/paper_app_bar.dart';
import 'package:mini_game/paper/stork_width_selector.dart';

import 'model.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<StatefulWidget> createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _showDialog,
        onBack: _lines.isEmpty ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: PaperPainter(lines: _lines),
              child: ConstrainedBox(constraints: const BoxConstraints.expand()),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ColorSelector(
                    supportColors: supportColors,
                    onSelect: _onSelectColor,
                    activeIndex: _activeColorIndex,
                  ),
                ),
                StorkWidthSelector(
                  supportStorkWidths: supportStorkWidths,
                  activeIndex: _activeStrokeWidthIndex,
                  color: Colors.black,
                  onSelect: _onSelectStorkWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 变量定义
  List<Line> _lines = [];

  //历史记录
  List<Line> _historyLines = [];

  int _activeColorIndex = 0; //颜色选中

  int _activeStrokeWidthIndex = 0; //线段宽度

  // 支持的颜色列表
  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  //支持的线段宽度
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  //  展示提示框
  void _showDialog() {
    String msg = "当前操作会清空画图内容，请确实是否继续!";
    showDialog(
      context: context,
      builder:
          (ctx) => ConformDialog(
            title: '清空提示',
            conformText: "确定",
            msg: msg,
            onConform: _clear,
          ),
    );
  }

  void _clear() {
    // 数据清除
    _lines.clear();
    _historyLines.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  void _onSelectStorkWidth(int index) {
    if (index != _activeStrokeWidthIndex) {
      setState(() {
        _activeStrokeWidthIndex = index;
      });
    }
  }

  // 色块选择
  void _onSelectColor(int index) {
    if (index != _activeColorIndex) {
      setState(() {
        _activeColorIndex = index;
      });
    }
  }

  // 手势开始
  void _onPanStart(DragStartDetails details) {
    _lines.add(
      Line(
        points: [details.localPosition],
        strokeWidth: supportStorkWidths[_activeStrokeWidthIndex],
        color: supportColors[_activeColorIndex],
      ),
    );
  }

  //手势变更
  void _onPanUpdate(DragUpdateDetails details) {
    Offset point = details.localPosition;
    double distance = (_lines.last.points.last - point).distance; //计算和上一次的距离差距
    if (distance > 5) {
      _lines.last.points.add(details.localPosition);
      setState(() {});
    }
  }

  void _back() {
    if(_lines.isNotEmpty){
      Line line = _lines.removeLast();
      _historyLines.add(line);
    }
    // 用于状态刷新
    setState(() {});
  }

  void _revocation() {
    if(_historyLines.isNotEmpty){
      Line line = _historyLines.removeLast();
      _lines.add(line);
    }
    setState(() {});
  }
}

class PaperPainter extends CustomPainter {
  final List<Line> lines;
  late Paint _paint;

  PaperPainter({required this.lines}) {
    _paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  // 画线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
