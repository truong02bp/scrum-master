
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sprint.g.dart';

@JsonSerializable(explicitToJson: true)
class Sprint {
  int? id;
  String? name;
  Project? project;
  List<Issue>? issues;
  DateTime? startDate;
  DateTime? endDate;
  String? status;


  Sprint(this.id, this.name, this.project, this.issues, this.startDate,
      this.endDate, this.status);

  factory Sprint.fromJson(Map<String, dynamic> json) => _$SprintFromJson(json);

  Map<String, dynamic> toJson() => _$SprintToJson(this);
}