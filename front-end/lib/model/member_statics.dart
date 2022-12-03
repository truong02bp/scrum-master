import 'package:scrum_master_front_end/model/organization.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_statics.g.dart';

@JsonSerializable(explicitToJson: true)
class MemberStatics {
  User user;
  int totalIssue;

  MemberStatics(this.user, this.totalIssue);

  factory MemberStatics.fromJson(Map<String, dynamic> json) =>
      _$MemberStaticsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberStaticsToJson(this);
}
