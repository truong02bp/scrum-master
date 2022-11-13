import 'package:scrum_master_front_end/model/organization.dart';
import 'package:scrum_master_front_end/model/project_member.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  int? id;
  String? name;
  String? key;
  Organization? organization;
  List<ProjectMember>? members;
  User? owner;
  User? projectLeader;

  Project(this.id, this.name, this.organization, this.members, this.owner,
      this.key, this.projectLeader);

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
