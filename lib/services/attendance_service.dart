import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/models/attendance/attendance_response.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/controllers/authentication_controller.dart';

class AttendanceService {
  Future<AttendanceResponse?> getPersonalAttendance(
      String from, String to) async {
    final authController = Get.find<AuthenticationController>();
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    // from?dateFrom=2022-02-9&dateTo=2022-02-11
    try {
      final url = "${api_url.personalAttendance}"
          "?dateFrom=$from"
          "&dateTo=$to";

      print(url);

      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final AttendanceResponse attendanceResponse =
            attendanceResponseFromMap(response.body);
        return attendanceResponse;
      }

    } catch (e) {
      return null;
    }
  }
}
