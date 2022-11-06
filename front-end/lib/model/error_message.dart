import 'package:json_annotation/json_annotation.dart';
part 'error_message.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorMessage {
  int code;
  String message = "";

  ErrorMessage(this.code, this.message);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => _$ErrorMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
}