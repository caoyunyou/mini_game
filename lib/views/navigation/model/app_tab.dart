import 'package:flutter/material.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

enum AppTab {
  home('/home', Icons.self_improvement),
  muyu('/muyu', Icons.note_alt_outlined),
  guess('/guess', Icons.question_mark),
  paper('/paper', Icons.palette_outlined);

  final IconData icon;
  final String path;

  static List<AppTab> get mobileTabs => [guess, muyu, home];

  const AppTab(this.path, this.icon);

  // 获取标题
  String label(S langs) {
    return switch (this) {
      AppTab.home => langs.homePageTitle,
      AppTab.muyu => langs.muyuPageTitle,
      AppTab.guess => langs.guessPageTitle,
      AppTab.paper => langs.paperPageTitle,
    };
  }
}
