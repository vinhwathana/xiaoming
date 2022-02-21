import 'dart:convert';

import 'attendance.dart';

PersonalAttendanceByDateResponse attendanceByDateResponseFromMap(String str) =>
    PersonalAttendanceByDateResponse.fromMap(json.decode(str));

String attendanceByDateResponseToMap(PersonalAttendanceByDateResponse data) =>
    json.encode(data.toMap());

class PersonalAttendanceByDateResponse {
  PersonalAttendanceByDateResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  Attendance data;

  factory PersonalAttendanceByDateResponse.fromMap(Map<String, dynamic> json) =>
      PersonalAttendanceByDateResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Attendance.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toMap(),
      };
}
