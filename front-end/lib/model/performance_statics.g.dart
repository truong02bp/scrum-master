// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_statics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceStatics _$PerformanceStaticsFromJson(Map<String, dynamic> json) {
  return PerformanceStatics(
    json['earlyIssueTotal'] as int?,
    json['lateIssueTotal'] as int?,
    json['notCompletedIssueTotal'] as int?,
  );
}

Map<String, dynamic> _$PerformanceStaticsToJson(PerformanceStatics instance) =>
    <String, dynamic>{
      'earlyIssueTotal': instance.earlyIssueTotal,
      'lateIssueTotal': instance.lateIssueTotal,
      'notCompletedIssueTotal': instance.notCompletedIssueTotal,
    };
