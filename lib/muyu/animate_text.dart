import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_game/muyu/models/merit_record.dart';

class AnimateText extends StatefulWidget {
  final MeritRecord record;
  final AnimationController controller;

  const AnimateText({
    super.key,
    required this.record,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _AnimateTextState();
}

class _AnimateTextState extends State<AnimateText>
    with SingleTickerProviderStateMixin {
  // late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> position;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    opacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.easeOut),
    );
    scale = Tween(begin: 1.0, end: 0.9).animate(widget.controller);

    // X坐标的随机偏移值: 形成随机漂浮
    Random random = Random();
    final randomStartX = random.nextDouble() - random.nextInt(2);
    final randomEndX = random.nextDouble() - random.nextInt(2);
    position = Tween<Offset>(
      begin: Offset(randomStartX, 20),
      end: Offset(randomEndX, 0),
    ).animate(widget.controller);

    widget.controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.record.id != widget.record.id) {
      widget.controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    // controller.isDismissed;
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
          opacity: opacity,
          child: Text(
            '功德 +${widget.record.value}',
            style: TextStyle(
              color: widget.record.meritType.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
