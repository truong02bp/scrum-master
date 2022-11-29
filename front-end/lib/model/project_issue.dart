import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/project.dart';
part 'project_issue.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectIssue {
  Project? project;
  int? totalIssue;


  ProjectIssue(this.project, this.totalIssue);

  factory ProjectIssue.fromJson(Map<String, dynamic> json) => _$ProjectIssueFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectIssueToJson(this);
}