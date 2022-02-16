import 'dart:convert';

import 'attendance.dart';

AttendanceResponse attendanceResponseFromMap(String str) =>
    AttendanceResponse.fromMap(json.decode(str));

String attendanceResponseToMap(AttendanceResponse data) =>
    json.encode(data.toMap());

class AttendanceResponse {
  AttendanceResponse({
    required this.totalFilteredRecord,
    required this.data,
  });

  int totalFilteredRecord;
  List<Attendance> data;

  factory AttendanceResponse.fromMap(Map<String, dynamic> json) =>
      AttendanceResponse(
        totalFilteredRecord: json["totalFilteredRecord"],
        data: List<Attendance>.from(
            json["data"].map((x) => Attendance.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalFilteredRecord": totalFilteredRecord,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}


