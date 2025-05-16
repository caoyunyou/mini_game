import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/views/paper/model/model.dart';

class PaperController extends GetxController {
  // 状态变量
  final List<Line> lines = <Line>[].obs;
  final List<Line> historyLines = <Line>[].obs;
  final activeColorIndex = 0.obs;
  final activeStrokeWidthIndex = 0.obs;

  // 支持的颜色和线宽
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

  final List<double> supportStrokeWidths = [1, 2, 4, 6, 8, 10];

  // 操作方法
  void onPanStart(Offset point) {
    lines.add(
      Line(
        points: [point],
        strokeWidth: supportStrokeWidths[activeStrokeWidthIndex.value],
        color: supportColors[activeColorIndex.value],
      ),
    );
  }

  void onPanUpdate(Offset point) {
    if (lines.isNotEmpty) {
      Line currentLine = lines.last;
      Offset lastPoint = currentLine.points.last;
      double distance = (lastPoint - point).distance;
      if (distance > 5) {
        currentLine.points.add(point);
        lines[lines.length - 1] = currentLine; // 触发 UI 更新
      }
    }
  }

  void onClear(BuildContext context) {
    lines.clear();
    historyLines.clear();
    Navigator.of(context).pop();
  }

  void onSelectColor(int index) {
    if (index != activeColorIndex.value) {
      activeColorIndex.value = index;
    }
  }

  void onSelectStrokeWidth(int index) {
    if (index != activeStrokeWidthIndex.value) {
      activeStrokeWidthIndex.value = index;
    }
  }

  void back() {
    if (lines.isNotEmpty) {
      historyLines.add(lines.removeLast());
    }
  }

  void revocation() {
    if (historyLines.isNotEmpty) {
      lines.add(historyLines.removeLast());
    }
  }
}
