import 'package:json_annotation/json_annotation.dart';
part 'issue_statics.g.dart';

@JsonSerializable(explicitToJson: true)
class IssueStatics {
  int? bugTotal;
  int? taskTotal;
  int? storyTotal;

  IssueStatics(this.bugTotal, this.taskTotal, this.storyTotal);

  factory IssueStatics.fromJson(Map<String, dynamic> json) => _$IssueStaticsFromJson(json);

  Map<String, dynamic> toJson() => _$IssueStaticsToJson(this);
}