import 'dart:convert';

import 'package:xiaoming/models/attendance/time_rule.dart';

AttendanceLogResponse attendanceLogResponseFromMap(String str) =>
    AttendanceLogResponse.fromMap(json.decode(str));

String attendanceLogResponseToMap(AttendanceLogResponse data) =>
    json.encode(data.toMap());

class AttendanceLogResponse {
  AttendanceLogResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  AttendanceLog data;

  factory AttendanceLogResponse.fromMap(Map<String, dynamic> json) =>
      AttendanceLogResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: AttendanceLog.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toMap(),
      };
}

class AttendanceLog {
  AttendanceLog({
    required this.timeRule,
    required this.date,
    required this.summary,
    required this.logs,
  });

  TimeRule timeRule;
  String date;
  Summary summary;
  List<Log> logs;

  factory AttendanceLog.fromMap(Map<String, dynamic> json) => AttendanceLog(
        timeRule: TimeRule.fromMap(json["timeRule"]),
        date: json["date"],
        summary: Summary.fromMap(json["summary"]),
        logs: List<Log>.from(json["logs"].map((x) => Log.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "timeRule": timeRule.toMap(),
        "date": date,
        "summary": summary.toMap(),
        "logs": List<dynamic>.from(logs.map((x) => x.toMap())),
      };
}

class Log {
  Log({
    required this.id,
    required this.devName,
    required this.devSerialNo,
    required this.empId,
    required this.empName,
    required this.authDateTime,
    required this.authDate,
    required this.authTime,
  });

  int? id;
  String? devName;
  String? devSerialNo;
  int? empId;
  String? empName;
  String? authDateTime;
  String? authDate;
  String? authTime;

  factory Log.fromMap(Map<String, dynamic> json) => Log(
        id: json["id"],
        devName: json["devName"],
        devSerialNo: json["devSerialNo"],
        empId: json["empId"],
        empName: json["empName"],
        authDateTime: json["authDateTime"],
        authDate: json["authDate"],
        authTime: json["authTime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "devName": devName,
        "devSerialNo": devSerialNo,
        "empId": empId,
        "empName": empName,
        "authDateTime": authDateTime,
        "authDate": authDate,
        "authTime": authTime,
      };
}

class Summary {
  Summary({
    required this.timeRuleId,
    required this.authDate,
    required this.morningCheckIn,
    required this.morningCheckOut,
    required this.afternoonCheckIn,
    required this.afternoonCheckOut,
    required this.periodInHour,
    required this.attendanceStatus,
  });

  int timeRuleId;
  String? authDate;
  String? morningCheckIn;
  String? morningCheckOut;
  String? afternoonCheckIn;
  String? afternoonCheckOut;
  double? periodInHour;
  String? attendanceStatus;

  factory Summary.fromMap(Map<String, dynamic> json) => Summary(
        timeRuleId: json["timeRuleId"],
        authDate: json["authDate"],
        morningCheckIn: json["morningCheckIn"],
        morningCheckOut: json["morningCheckOut"],
        afternoonCheckIn: json["afternoonCheckIn"],
        afternoonCheckOut: json["afternoonCheckOut"],
        periodInHour: json["periodInHour"].toDouble(),
        attendanceStatus: json["attendanceStatus"],
      );

  Map<String, dynamic> toMap() => {
        "timeRuleId": timeRuleId,
        "authDate": authDate,
        "morningCheckIn": morningCheckIn,
        "morningCheckOut": morningCheckOut,
        "afternoonCheckIn": afternoonCheckIn,
        "afternoonCheckOut": afternoonCheckOut,
        "periodInHour": periodInHour,
        "attendanceStatus": attendanceStatus,
      };
}

// class TimeRule {
//   TimeRule({
//     required this.id,
//     required this.ministryCode,
//     required this.effectiveDate,
//     required this.timeCheckIn1From,
//     required this.timeCheckIn1To,
//     required this.timeCheckOut1From,
//     required this.timeCheckOut1To,
//     required this.timeCheckIn2From,
//     required this.timeCheckIn2To,
//     required this.timeCheckOut2From,
//     required this.timeCheckOut2To,
//     required this.createdBy,
//     required this.createdAt,
//     required this.updatedBy,
//     required this.updatedAt,
//     required this.deletedAt,
//     required this.deletedBy,
//   });
//
//   int id;
//   String ministryCode;
//   String effectiveDate;
//   String timeCheckIn1From;
//   String timeCheckIn1To;
//   String timeCheckOut1From;
//   String timeCheckOut1To;
//   String timeCheckIn2From;
//   String timeCheckIn2To;
//   String timeCheckOut2From;
//   String timeCheckOut2To;
//   String createdBy;
//   String createdAt;
//   String updatedBy;
//   String updatedAt;
//   String deletedAt;
//   String deletedBy;
//
//   factory TimeRule.fromMap(Map<String, dynamic> json) => TimeRule(
//         id: json["id"],
//         ministryCode: json["ministryCode"],
//         effectiveDate: json["effectiveDate"],
//         timeCheckIn1From: json["timeCheckIn1From"],
//         timeCheckIn1To: json["timeCheckIn1To"],
//         timeCheckOut1From: json["timeCheckOut1From"],
//         timeCheckOut1To: json["timeCheckOut1To"],
//         timeCheckIn2From: json["timeCheckIn2From"],
//         timeCheckIn2To: json["timeCheckIn2To"],
//         timeCheckOut2From: json["timeCheckOut2From"],
//         timeCheckOut2To: json["timeCheckOut2To"],
//         createdBy: json["createdBy"],
//         createdAt: json["createdAt"],
//         updatedBy: json["updatedBy"],
//         updatedAt: json["updatedAt"],
//         deletedAt: json["deletedAt"],
//         deletedBy: json["deletedBy"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "ministryCode": ministryCode,
//         "effectiveDate": effectiveDate,
//         "timeCheckIn1From": timeCheckIn1From,
//         "timeCheckIn1To": timeCheckIn1To,
//         "timeCheckOut1From": timeCheckOut1From,
//         "timeCheckOut1To": timeCheckOut1To,
//         "timeCheckIn2From": timeCheckIn2From,
//         "timeCheckIn2To": timeCheckIn2To,
//         "timeCheckOut2From": timeCheckOut2From,
//         "timeCheckOut2To": timeCheckOut2To,
//         "createdBy": createdBy,
//         "createdAt": createdAt,
//         "updatedBy": updatedBy,
//         "updatedAt": updatedAt,
//         "deletedAt": deletedAt,
//         "deletedBy": deletedBy,
//       };
// }
