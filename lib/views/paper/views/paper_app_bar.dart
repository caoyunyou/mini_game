import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_game/storage/sp_storage.dart';
import 'package:mini_game/views/paper/controllers/paper_controller.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

class PaperAppBar extends GetView<PaperController>
    implements PreferredSizeWidget {
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const PaperAppBar({
    super.key,
    required this.onClear,
    this.onBack,
    this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _buildBackUpButtons(
        onBack: onBack,
        onRevocation: onRevocation,
        context: context,
      ),
      title: Text(S.of(context).paperPageAppbar),
      leadingWidth: 100, //长度设置，要不然显示不出来。。。。
      actions: [
        Tooltip(
          message: S.of(context).delete,
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

  // 构建回退和前进按钮
  Widget _buildBackUpButtons({
    VoidCallback? onBack,
    VoidCallback? onRevocation,
    required BuildContext context,
  }) {
    const BoxConstraints cts = BoxConstraints(minWidth: 32, minHeight: 32);

    ThemeMode currentThemeMode = SpStorage.getThemeMode();
    //条件1:是暗黑模式
    // 是否系统模式,如果是则用系统进行判别,如果不是则采用状态维护
    bool isDark =
        (currentThemeMode == ThemeMode.system)
            ? MediaQuery.of(context).platformBrightness == Brightness.dark
            : currentThemeMode == ThemeMode.dark;
    //条件2:可以回退
    bool canBack = onBack != null;

    Color backColor =
        canBack
            ? (isDark ? Colors.grey : Colors.black)
            : (isDark ? Colors.black : Colors.grey);
    // 条件:是否可以回滚
    bool canRevocation = onRevocation != null;
    // ? Colors.grey : Colors.black;//
    Color revocationColor =
        canRevocation
            ? (isDark ? Colors.grey : Colors.black)
            : (isDark ? Colors.black : Colors.grey);

    return Center(
      child: Wrap(
        children: [
          Transform.scale(
            // 翻转图像
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
