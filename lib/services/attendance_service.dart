import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/models/attendance/attendance.dart';
import 'package:xiaoming/models/attendance/personal_attendance_by_date_response.dart';
import 'package:xiaoming/models/attendance/personal_attendance_range_response.dart';
import 'package:xiaoming/models/attendance/attendance_rule.dart';
import 'package:xiaoming/models/attendance/attendance_rule_response.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/controllers/authentication_controller.dart';

class AttendanceService {
  final authController = Get.find<AuthenticationController>();

  Future<List<Attendance>?> getPersonalAttendanceRange(
      String from, String to) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    // from?dateFrom=2022-02-9&dateTo=2022-02-11
    try {
      final url = "${api_url.personalAttendance}"
          "?dateFrom=$from"
          "&dateTo=$to";

      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final PersonalAttendanceRangeResponse attendanceResponse =
            attendanceResponseRangeFromMap(response.body);
        return attendanceResponse.data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Attendance?> getPersonalAttendanceByDate(
    String date,
  ) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    //   /attendances/personal-attd-by-date/2022-01-20
    try {
      final url = "${api_url.personalAttendanceByDate}/$date";



      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final attendanceResponse =
            attendanceByDateResponseFromMap(response.body);
        return attendanceResponse.data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AttendanceRule?> getAttendanceRuleById(String timeRuleId) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    // /attendances-time-rules/1
    try {
      final url = "${api_url.attendanceRuleById}/$timeRuleId";
      print("url: $url");
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final attendanceRule = attendanceRuleResponseFromMap(response.body);
        return attendanceRule.data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
