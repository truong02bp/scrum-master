// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_statics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberStatics _$MemberStaticsFromJson(Map<String, dynamic> json) {
  return MemberStatics(
    User.fromJson(json['user'] as Map<String, dynamic>),
    json['totalIssue'] as int,
  );
}

Map<String, dynamic> _$MemberStaticsToJson(MemberStatics instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'totalIssue': instance.totalIssue,
    };
