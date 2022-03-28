import 'dart:convert';

import 'attendance.dart';

PersonalAttendanceRangeResponse attendanceResponseRangeFromMap(String str) =>
    PersonalAttendanceRangeResponse.fromMap(json.decode(str));

String attendanceRangeResponseToMap(PersonalAttendanceRangeResponse data) =>
    json.encode(data.toMap());

class PersonalAttendanceRangeResponse {
  PersonalAttendanceRangeResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Attendance> data;

  factory PersonalAttendanceRangeResponse.fromMap(Map<String, dynamic> json) =>
      PersonalAttendanceRangeResponse(
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
