import 'package:flutter/material.dart';

// 计数器
class CountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTapSwitchAudio;
  final VoidCallback onTapSwitchImage;

  const CountPanel({
    super.key,
    required this.count,
    required this.onTapSwitchAudio,
    required this.onTapSwitchImage,
  });

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    //按钮样式定义
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(36, 36),
      padding: EdgeInsets.zero, //边距
      backgroundColor: Colors.green,
      elevation: 0, //阴影深度
    );

    return Stack(
      children: [
        Positioned(
          top: mediaHeight * 0.04,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "功德数: $count",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Positioned(
          //绝对定位
          right: mediaWidth * 0.04,
          top: mediaHeight * 0.02,
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            children: [
              Tooltip(
                message: '音乐选择',
                child: ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchAudio,
                  child: Icon(Icons.music_note_outlined),
                ),
              ),
              Tooltip(
                message: '木鱼选择',
                child: ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchImage,
                  child: Icon(Icons.image),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
