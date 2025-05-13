import 'package:flutter/material.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const PaperAppBar({super.key, required this.onClear, this.onBack, this.onRevocation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      title: Text('画板绘制'),
      leadingWidth: 100,//长度设置，要不然显示不出来。。。。
      actions: [
        Tooltip(
          message: '删除',
          child: IconButton(
            splashRadius: 20,
            onPressed: onClear,
            icon: const Icon(Icons.delete, size: 20),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//  回退按钮
class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons({super.key, this.onBack, this.onRevocation});

  @override
  Widget build(BuildContext context) {
    const BoxConstraints cts = BoxConstraints(minWidth: 32, minHeight: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black; //颜色显示:回退
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black; //颜色显示:前进

    return Center(
      child: Wrap(
        children: [
          Transform.scale(// 翻转图像
            scaleX: -1,
            child: IconButton(
              splashRadius: 20,
              constraints: cts,
              onPressed: onBack,
              icon: Icon(Icons.next_plan_outlined, color: backColor),
            ),
          ),
          IconButton(
            splashRadius: 20,
            constraints: cts,
            onPressed: onRevocation,
            icon: Icon(Icons.next_plan_outlined, color: revocationColor),
          ),
        ],
      ),
    );
  }
}
