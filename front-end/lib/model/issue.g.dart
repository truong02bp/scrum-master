// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    json['id'] as int?,
    json['code'] as String?,
    json['title'] as String?,
    json['description'] as String?,
    json['estimate'] as int?,
    json['label'] as String?,
    json['type'] as String?,
    json['reporter'] == null
        ? null
        : User.fromJson(json['reporter'] as Map<String, dynamic>),
    json['assignee'] == null
        ? null
        : User.fromJson(json['assignee'] as Map<String, dynamic>),
    json['sprint'] == null
        ? null
        : Sprint.fromJson(json['sprint'] as Map<String, dynamic>),
    json['priority'] as int?,
    (json['subTasks'] as List<dynamic>?)
        ?.map((e) => Issue.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'estimate': instance.estimate,
      'label': instance.label,
      'type': instance.type,
      'reporter': instance.reporter?.toJson(),
      'assignee': instance.assignee?.toJson(),
      'sprint': instance.sprint?.toJson(),
      'priority': instance.priority,
      'subTasks': instance.subTasks?.map((e) => e.toJson()).toList(),
    };
