import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_master_front_end/model/organization.dart';
import 'package:scrum_master_front_end/model/role.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String email;
  String? name;
  String? phone;
  String? avatarUrl;
  Role role;
  Organization organization;
  bool isActive;

  User(this.id, this.email, this.name, this.phone, this.avatarUrl, this.role, this.organization, this.isActive);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}