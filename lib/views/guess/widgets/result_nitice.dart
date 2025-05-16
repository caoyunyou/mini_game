import 'package:flutter/material.dart';

//  组件抽取
class ResultNotice extends StatelessWidget {
  final Color color;
  final String info;
  final AnimationController controller;

  const ResultNotice({
    super.key,
    required this.color,
    required this.info,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_,child) {
            // 计算当前颜色
            final currentColor =  Color.lerp(Colors.transparent, color, controller.value);

            return Container(
              alignment: Alignment.center,
              color: currentColor,
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 54 * controller.value,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}