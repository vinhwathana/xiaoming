import 'dart:convert';

import 'user.dart';

class EmployeeListResult {
  EmployeeListResult({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  User? data;

  factory EmployeeListResult.fromJson(String str) =>
      EmployeeListResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeListResult.fromMap(Map<String, dynamic> json) =>
      EmployeeListResult(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : User.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data!.toMap(),
      };
}
