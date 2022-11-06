// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sprint _$SprintFromJson(Map<String, dynamic> json) {
  return Sprint(
    json['id'] as int?,
    json['name'] as String?,
    json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>),
    (json['issues'] as List<dynamic>?)
        ?.map((e) => Issue.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['endState'] == null
        ? null
        : DateTime.parse(json['endState'] as String),
    json['status'] as String,
  );
}

Map<String, dynamic> _$SprintToJson(Sprint instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'project': instance.project?.toJson(),
      'issues': instance.issues?.map((e) => e.toJson()).toList(),
      'startDate': instance.startDate?.toIso8601String(),
      'endState': instance.endState?.toIso8601String(),
      'status': instance.status,
    };
