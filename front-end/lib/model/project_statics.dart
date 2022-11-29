import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/project_issue.dart';

part 'project_statics.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectStatics {

  List<ProjectIssue>? projectIssues;

  ProjectStatics(this.projectIssues);

  factory ProjectStatics.fromJson(Map<String, dynamic> json) =>
      _$ProjectStaticsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectStaticsToJson(this);
}
