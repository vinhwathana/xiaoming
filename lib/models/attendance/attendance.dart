import 'dart:convert';

Attendance attendanceFromMap(String str) =>
    Attendance.fromMap(json.decode(str));

String attendanceToMap(Attendance data) => json.encode(data.toMap());

class Attendance {
  Attendance({
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
  DateTime authDate;
  String morningCheckIn;
  String morningCheckOut;
  String afternoonCheckIn;
  String afternoonCheckOut;
  double periodInHour;
  String attendanceStatus;

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        timeRuleId: json["timeRuleId"],
        authDate: DateTime.parse(json["authDate"]),
        morningCheckIn: json["morningCheckIn"],
        morningCheckOut: json["morningCheckOut"],
        afternoonCheckIn: json["afternoonCheckIn"],
        afternoonCheckOut: json["afternoonCheckOut"],
        periodInHour: json["periodInHour"].toDouble(),
        attendanceStatus: json["attendanceStatus"],
      );

  Map<String, dynamic> toMap() => {
        "timeRuleId": timeRuleId,
        "authDate":
            "${authDate.year.toString().padLeft(4, '0')}-${authDate.month.toString().padLeft(2, '0')}-${authDate.day.toString().padLeft(2, '0')}",
        "morningCheckIn": morningCheckIn,
        "morningCheckOut": morningCheckOut,
        "afternoonCheckIn": afternoonCheckIn,
        "afternoonCheckOut": afternoonCheckOut,
        "periodInHour": periodInHour,
        "attendanceStatus": attendanceStatus,
      };
}
