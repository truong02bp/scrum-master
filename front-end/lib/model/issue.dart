
import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/model/user.dart';

part 'issue.g.dart';

@JsonSerializable(explicitToJson: true)
class Issue {
  int? id;
  String? code;
  String? title;
  String? description;
  int? estimate;
  String? label;
  String? type;
  User? reporter;
  User? assignee;
  Sprint? sprint;
  int? priority;
  Project? project;
  List<Issue>? subTasks;
  String? status;


  Issue(
      this.id,
      this.code,
      this.title,
      this.description,
      this.estimate,
      this.label,
      this.type,
      this.reporter,
      this.assignee,
      this.sprint,
      this.priority,
      this.project,
      this.status,
      this.subTasks);

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}