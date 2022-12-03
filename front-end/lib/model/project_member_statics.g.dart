// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member_statics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMemberStatics _$ProjectMemberStaticsFromJson(Map<String, dynamic> json) {
  return ProjectMemberStatics(
    Project.fromJson(json['project'] as Map<String, dynamic>),
    (json['members'] as List<dynamic>)
        .map((e) => MemberStatics.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProjectMemberStaticsToJson(
        ProjectMemberStatics instance) =>
    <String, dynamic>{
      'project': instance.project.toJson(),
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
