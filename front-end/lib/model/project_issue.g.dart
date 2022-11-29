// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectIssue _$ProjectIssueFromJson(Map<String, dynamic> json) {
  return ProjectIssue(
    json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>),
    json['totalIssue'] as int?,
  );
}

Map<String, dynamic> _$ProjectIssueToJson(ProjectIssue instance) =>
    <String, dynamic>{
      'project': instance.project?.toJson(),
      'totalIssue': instance.totalIssue,
    };
