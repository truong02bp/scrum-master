// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_statics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectStatics _$ProjectStaticsFromJson(Map<String, dynamic> json) {
  return ProjectStatics(
    (json['projectIssues'] as List<dynamic>?)
        ?.map((e) => ProjectIssue.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProjectStaticsToJson(ProjectStatics instance) =>
    <String, dynamic>{
      'projectIssues': instance.projectIssues?.map((e) => e.toJson()).toList(),
    };
