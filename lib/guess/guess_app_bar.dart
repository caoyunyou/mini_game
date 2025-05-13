import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;
  const GuessAppBar({Key? key,required this.onCheck,required this.controller}) : super(key: key);

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
        keyboardType: TextInputType.number, //输入类型：数字
        decoration: InputDecoration(
          //装饰
          filled: true,
          //是否填充
          fillColor: Color(0xffF3F6F9),
          //填充颜色
          constraints: BoxConstraints(maxHeight: 35),
          //约束信息
          border: UnderlineInputBorder(
            //边框信息
            borderSide: BorderSide.none, //无边框
            borderRadius: BorderRadius.all(Radius.circular(6)), //圆角
          ),
          hintText: "输入 0~99 数字",
          //填入提示
          hintStyle: TextStyle(fontSize: 14), //提示文本字体格式
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
