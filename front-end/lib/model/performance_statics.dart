import 'package:json_annotation/json_annotation.dart';

part 'performance_statics.g.dart';

@JsonSerializable(explicitToJson: true)
class PerformanceStatics {
  int? earlyIssueTotal;
  int? lateIssueTotal;
  int? notCompletedIssueTotal;


  PerformanceStatics(
      this.earlyIssueTotal, this.lateIssueTotal, this.notCompletedIssueTotal);

  factory PerformanceStatics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceStaticsFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceStaticsToJson(this);
}
