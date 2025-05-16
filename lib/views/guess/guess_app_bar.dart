import 'package:flutter/material.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;

  const GuessAppBar({Key? key, required this.onCheck, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu, color: Colors.black), //左边
      actions: [
        //右边
        IconButton(
          splashRadius: 20,
          onPressed: onCheck,
          icon: Icon(Icons.run_circle_outlined, color: Colors.blue),
        ),
      ],
      title: TextField(
        controller: controller,
        //中间
        keyboardType: TextInputType.number,
        //输入类型：数字
        style: TextStyle(textBaseline: TextBaseline.alphabetic, height: 1.5),
        maxLines: 1,
        decoration: InputDecoration(
          //装饰
          filled: true,
          hoverColor: Colors.transparent,
          //是否填充
          fillColor: Color(0xffF3F6F9),
          //填充颜色
          prefixIconConstraints: BoxConstraints(minWidth: 30),
          constraints: BoxConstraints(maxHeight: 35),
          //边框信息
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo,width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          // 提示文本
          hintText: "输入 0~99 数字",
          //文本左侧显示
          hintTextDirection: TextDirection.ltr,
          // 提示文本最大显示行数
          hintMaxLines: 1,
          //填入提示
          // hintStyle: TextStyle(fontSize: 14),
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
          //提示文本字体格式
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
