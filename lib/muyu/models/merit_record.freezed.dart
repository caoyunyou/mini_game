// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merit_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeritRecord {

 String get id; int get timestamp;//时间戳
 int get value;//功德值
 String get muyuImage;//muyu图片
 String get audio;//功德记录对应的音乐
 String get muyuName;// 功德记录对应的木鱼
 MeritQuality get meritType;
/// Create a copy of MeritRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeritRecordCopyWith<MeritRecord> get copyWith => _$MeritRecordCopyWithImpl<MeritRecord>(this as MeritRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeritRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.value, value) || other.value == value)&&(identical(other.muyuImage, muyuImage) || other.muyuImage == muyuImage)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.muyuName, muyuName) || other.muyuName == muyuName)&&(identical(other.meritType, meritType) || other.meritType == meritType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,value,muyuImage,audio,muyuName,meritType);

@override
String toString() {
  return 'MeritRecord(id: $id, timestamp: $timestamp, value: $value, muyuImage: $muyuImage, audio: $audio, muyuName: $muyuName, meritType: $meritType)';
}


}

/// @nodoc
abstract mixin class $MeritRecordCopyWith<$Res>  {
  factory $MeritRecordCopyWith(MeritRecord value, $Res Function(MeritRecord) _then) = _$MeritRecordCopyWithImpl;
@useResult
$Res call({
 String id, int timestamp, int value, String muyuImage, String audio, String muyuName, MeritQuality meritType
});




}
/// @nodoc
class _$MeritRecordCopyWithImpl<$Res>
    implements $MeritRecordCopyWith<$Res> {
  _$MeritRecordCopyWithImpl(this._self, this._then);

  final MeritRecord _self;
  final $Res Function(MeritRecord) _then;

/// Create a copy of MeritRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? value = null,Object? muyuImage = null,Object? audio = null,Object? muyuName = null,Object? meritType = null,}) {
  return _then(MeritRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,muyuImage: null == muyuImage ? _self.muyuImage : muyuImage // ignore: cast_nullable_to_non_nullable
as String,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,muyuName: null == muyuName ? _self.muyuName : muyuName // ignore: cast_nullable_to_non_nullable
as String,meritType: null == meritType ? _self.meritType : meritType // ignore: cast_nullable_to_non_nullable
as MeritQuality,
  ));
}

}


// dart format on
