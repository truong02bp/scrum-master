// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) {
  return ActivityLog(
    json['id'] as int?,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>),
    json['issue'] == null
        ? null
        : Issue.fromJson(json['issue'] as Map<String, dynamic>),
    json['description'] as String?,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$ActivityLogToJson(ActivityLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'project': instance.project?.toJson(),
      'issue': instance.issue?.toJson(),
      'description': instance.description,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
