// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merit_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeritRecord _$MeritRecordFromJson(Map<String, dynamic> json) => MeritRecord(
  id: json['id'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  value: (json['value'] as num).toInt(),
  muyuImage: json['muyuImage'] as String,
  audio: json['audio'] as String,
  muyuName: json['muyuName'] as String,
  meritType: $enumDecode(_$MeritQualityEnumMap, json['meritType']),
);

Map<String, dynamic> _$MeritRecordToJson(MeritRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'value': instance.value,
      'muyuImage': instance.muyuImage,
      'audio': instance.audio,
      'muyuName': instance.muyuName,
      'meritType': _$MeritQualityEnumMap[instance.meritType]!,
    };

const _$MeritQualityEnumMap = {
  MeritQuality.normal: 'normal',
  MeritQuality.good: 'good',
  MeritQuality.excellent: 'excellent',
  MeritQuality.crit: 'crit',
  MeritQuality.perfectCrit: 'perfectCrit',
};
