import 'package:flutter/material.dart';
import 'package:mini_game/storage/db_storage/base_dao.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'merit_record.freezed.dart';
part 'merit_record.g.dart';

@freezed
@JsonSerializable()
class MeritRecord   with _$MeritRecord{
  final String id;
  final int timestamp; //时间戳
  final int value; //功德值
  final String muyuImage; //muyu图片
  final String audio; //功德记录对应的音乐
  final String muyuName; // 功德记录对应的木鱼
  final MeritQuality meritType; //功德类型：普通-良好-优秀-暴击-完美暴击

  const MeritRecord({
    required this.id,
    required this.timestamp,
    required this.value,
    required this.muyuImage,
    required this.audio,
    required this.muyuName,
    required this.meritType,
  });

  // 从json转换为实体
  factory MeritRecord.fromJson(Map<String, dynamic> json) => _$MeritRecordFromJson(json);


  // 转成map
  Map<String, dynamic> toJson() => _$MeritRecordToJson(this);

}

// 枚举定义
enum MeritQuality {
  normal("普通", Colors.grey), //普通
  good("良好", Colors.lightGreen), //良好
  excellent("优秀", Colors.blueAccent), //优秀
  crit("暴击", Colors.amber), //暴击
  perfectCrit("完美暴击", Colors.deepOrange); //完美暴击

  final String desc;
  final Color color;

  const MeritQuality(this.desc, this.color);

  // 将成绩转换为对应枚举
  static MeritQuality convert(int value, int min, int max) {
    if (max <= min) {
      return MeritQuality.normal; // 输入无效
    }
    if (value < min || value > max) {
      return MeritQuality.normal; // 值不在区间内
    }

    final total = max - min + 1; // 总长度（包含端点）
    final normalized = (value - min) / total; // 归一化比例（0~1）
    final index = (normalized * 5).floor(); // 映射到 0~4 区间

    // 根据索引返回对应的字符
    return MeritQuality.values[index];
  }

  static MeritQuality str2enum(String value) {
    return MeritQuality.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MeritQuality.normal,
    );
  }
}
