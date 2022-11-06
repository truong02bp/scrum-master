// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMember _$ProjectMemberFromJson(Map<String, dynamic> json) {
  return ProjectMember(
    json['id'] as int?,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['role'] as String?,
  );
}

Map<String, dynamic> _$ProjectMemberToJson(ProjectMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'role': instance.role,
    };
