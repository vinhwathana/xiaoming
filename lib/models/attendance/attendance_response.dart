import 'dart:convert';

import 'attendance.dart';

AttendanceResponse attendanceResponseFromMap(String str) =>
    AttendanceResponse.fromMap(json.decode(str));

String attendanceResponseToMap(AttendanceResponse data) =>
    json.encode(data.toMap());

class AttendanceResponse {
  AttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Attendance> data;

  factory AttendanceResponse.fromMap(Map<String, dynamic> json) =>
      AttendanceResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Attendance>.from(json["data"].map((x) => Attendance.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}
