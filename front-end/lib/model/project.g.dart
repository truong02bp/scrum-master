// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    json['id'] as int?,
    json['name'] as String?,
    json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    (json['members'] as List<dynamic>?)
        ?.map((e) => ProjectMember.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    json['projectLeader'] == null
        ? null
        : User.fromJson(json['projectLeader'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organization': instance.organization?.toJson(),
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'owner': instance.owner?.toJson(),
      'projectLeader': instance.projectLeader?.toJson(),
    };
