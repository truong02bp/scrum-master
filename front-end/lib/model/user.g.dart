// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['email'] as String,
    json['address'] as String?,
    json['name'] as String?,
    json['phone'] as String?,
    json['avatarUrl'] as String?,
    Role.fromJson(json['role'] as Map<String, dynamic>),
    Organization.fromJson(json['organization'] as Map<String, dynamic>),
    json['isActive'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'avatarUrl': instance.avatarUrl,
      'address': instance.address,
      'role': instance.role.toJson(),
      'organization': instance.organization.toJson(),
      'isActive': instance.isActive,
    };
