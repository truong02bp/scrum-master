// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_statics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueStatics _$IssueStaticsFromJson(Map<String, dynamic> json) {
  return IssueStatics(
    json['bugTotal'] as int?,
    json['taskTotal'] as int?,
    json['storyTotal'] as int?,
  );
}

Map<String, dynamic> _$IssueStaticsToJson(IssueStatics instance) =>
    <String, dynamic>{
      'bugTotal': instance.bugTotal,
      'taskTotal': instance.taskTotal,
      'storyTotal': instance.storyTotal,
    };
