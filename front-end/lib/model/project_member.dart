

import 'package:scrum_master_front_end/model/organization.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_member.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectMember {
  int? id;
  User? user;
  String? role;


  ProjectMember(this.id, this.user, this.role);

  factory ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectMemberToJson(this);
}