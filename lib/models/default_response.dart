import 'dart:convert';

import 'package:xiaoming/utils/constant.dart';

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) =>
    json.encode(data.toJson());

class DefaultResponse {
  DefaultResponse({
    this.statusCode,
    this.message,
    this.errors,
    this.data,
  });

  int? statusCode;
  String? message;
  dynamic errors;
  dynamic data;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) {
    return DefaultResponse(
      statusCode: checkDynamicId(json["statusCode"]),
      message: json["message"],
      errors: json["errors"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errors": errors,
        "body": data,
      };

  @override
  String toString() {
    return 'DefaultResponse{statusCode: $statusCode, message: $message, errors: $errors, body: $data}';
  }
}
