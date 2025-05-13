import 'dart:convert';

import 'package:mini_game/utils/json_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'base_dao.freezed.dart';
// part 'base_dao.g.dart';

@freezed
abstract class BaseDao  {


   factory BaseDao.fromJson(Map<String, dynamic> json) {

     final String className = json['class'];
     final constructor = _registry[className];
     if (constructor == null) {
       throw Exception('Unknown type: $className');
     }

     return constructor(json);
  }

  Map<String, dynamic> toJson() {
    throw Exception("方法未实现");
  }

   // 注册表：类型标识 -> 构造函数
   static final Map<String, Function> _registry = {};
}
