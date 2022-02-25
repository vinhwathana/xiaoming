import 'dart:convert';

import 'time_rule.dart';

AttendanceRuleResponse attendanceRuleResponseFromMap(String str) =>
    AttendanceRuleResponse.fromMap(json.decode(str));

String attendanceRuleResponseToMap(AttendanceRuleResponse data) =>
    json.encode(data.toMap());

class AttendanceRuleResponse {
  AttendanceRuleResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  final TimeRule data;

  factory AttendanceRuleResponse.fromMap(Map<String, dynamic> json) =>
      AttendanceRuleResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: TimeRule.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toMap(),
      };
}
