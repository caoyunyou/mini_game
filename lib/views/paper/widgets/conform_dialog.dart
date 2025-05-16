import 'package:flutter/material.dart';

// 确认弹窗组件封装处理
class ConformDialog extends StatelessWidget {
  final String title;
  final String msg;
  final String conformText;
  final VoidCallback onConform;

  const ConformDialog({
    super.key,
    required this.title,
    required this.msg,
    this.conformText = '删除',
    required this.onConform,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(),
            _buildMessage(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() => Row(
    mainAxisAlignment: MainAxisAlignment.center, //居中对齐
    children: [
      const Icon(Icons.warning_amber_rounded, color: Colors.orange),
      const SizedBox(width: 10), //用一个占位
      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );

  Widget _buildMessage() => Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 15),
    child: Text(
      msg,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );

  // 底部按钮
  Widget _buildButtons(BuildContext context) => Row(
    children: [
      const Spacer(), //这个就是直接把空余空间全部挤压了
      OutlinedButton(
        onPressed: Navigator.of(context).pop,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: const Size(70, 35),
          elevation: 0,
          shape: const StadiumBorder(),
          padding: EdgeInsets.zero
        ),
        child: Text('取消', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      SizedBox(width: 10),
      ElevatedButton(
        onPressed: onConform,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,//前景色决定了字体颜色
          minimumSize: const Size(70, 35),
          elevation: 0,
          shape: const StadiumBorder(),
        ),
        child: Text(conformText, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ],
  );
}
