
import 'dart:convert';

import 'users.dart';

class EmployeeListResult {
  EmployeeListResult({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Users? data;

  factory EmployeeListResult.fromJson(String str) =>
      EmployeeListResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeListResult.fromMap(Map<String, dynamic> json) =>
      EmployeeListResult(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Users.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

