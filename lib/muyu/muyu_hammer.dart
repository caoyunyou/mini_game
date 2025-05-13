import 'package:flutter/material.dart';

class MuyuHammer extends StatefulWidget {
  final String record;

  const MuyuHammer({super.key, required this.record});

  @override
  State<StatefulWidget> createState() => _MuyuHammerState();
}

class _MuyuHammerState extends State<MuyuHammer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> turns;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);
    // opacity = Tween(begin: 1.0, end: 0.0).animate(controller);

    turns = Tween<double>(
      begin: 0,
      end: 0.03,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    controller.forward();
  }

  @override
  void didUpdateWidget(covariant MuyuHammer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.record != widget.record) {
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.centerRight,
      turns: turns,
      child: Image.asset(
        'assets/images/muyu_hammer_1.png',
        height: 36, //图片高度
        width: 180,
      ),
    );
  }
}
