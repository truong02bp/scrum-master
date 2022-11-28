import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/user.dart';

part 'activity_log.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityLog {
  int? id;
  User? user;
  Project? project;
  Issue? issue;
  String? description;
  DateTime? createdDate;

  ActivityLog(this.id, this.user, this.project, this.issue, this.description,
      this.createdDate);

  factory ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogToJson(this);
}