import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/paper/controllers/paper_controller.dart';
import 'package:mini_game/views/paper/views/paper_app_bar.dart';
import 'package:mini_game/views/paper/widgets/color_select.dart';
import 'package:mini_game/views/paper/widgets/conform_dialog.dart';
import 'package:mini_game/views/paper/widgets/stork_width_selector.dart';

import '../model/model.dart';

class PaperView extends GetView<PaperController> {
  const PaperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PaperAppBar(
          onClear: () => _showDialog(context),
          onBack: controller.lines.isEmpty ? null : controller.back,
          onRevocation:
              controller.historyLines.isEmpty ? null : controller.revocation,
        ),
        body: Stack(
          children: [
            GestureDetector(
              onPanStart:
                  (details) => controller.onPanStart(details.localPosition),
              onPanUpdate:
                  (details) => controller.onPanUpdate(details.localPosition),
              child: CustomPaint(
                painter: PaperPainter(lines: controller.lines),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: ColorSelector(
                      supportColors: controller.supportColors,
                      onSelect: controller.onSelectColor,
                      activeIndex: controller.activeColorIndex.value,
                    ),
                  ),
                  StorkWidthSelector(
                    supportStorkWidths: controller.supportStrokeWidths,
                    activeIndex: controller.activeStrokeWidthIndex.value,
                    color: Colors.black,
                    onSelect: controller.onSelectStrokeWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  展示提示框
  void _showDialog(BuildContext context) {
    String msg = "当前操作会清空画图内容，请确实是否继续!";
    showDialog(
      context: context,
      builder:
          (ctx) => ConformDialog(
            title: '清空提示',
            conformText: "确定",
            msg: msg,
            onConform: ()=>controller.onClear(context),
          ),
    );
  }
}

// 画笔
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
