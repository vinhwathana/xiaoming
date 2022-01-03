import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/attendance.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/utils/constant.dart';

Future<AttCheckInRequest?> checkIn(AttCheckInRequest data) async {
  final authController = Get.find<AuthenticationController>();
  if (authController.accessToken == null) {
    showToast("Access Token null");
    return null;
  }
  try {
    final uri = Uri.parse(api_url.attCheckIn);
    final payload = jsonEncode(data);
    final response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: authController.accessToken!
        },
        body: payload);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      var attendanceStatus = AttCheckInRequest.fromJson(responseJson);
      return attendanceStatus;
    }
    return null;
  } catch (e) {
    return null;
  }
}
