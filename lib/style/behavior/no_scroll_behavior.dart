import 'package:flutter/material.dart';


// 不滚动
class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) => child;
}