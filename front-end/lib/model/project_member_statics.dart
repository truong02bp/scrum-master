import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/member_statics.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/project_issue.dart';

part 'project_member_statics.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectMemberStatics {
  Project project;
  List<MemberStatics> members;

  ProjectMemberStatics(this.project, this.members);

  factory ProjectMemberStatics.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberStaticsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectMemberStaticsToJson(this);
}
