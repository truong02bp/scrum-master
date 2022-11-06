import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable(explicitToJson: true)
class Organization {
  int id;
  String code;
  String name;
  String logo;

  Organization(this.id, this.code, this.name, this.logo);

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}