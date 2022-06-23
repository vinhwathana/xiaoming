import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;

import '../models/employee_list_result.dart';

class UserService {
  Future<http.Response?> getUserProfile() async {
    final authController = Get.find<AuthenticationController>();
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }

    try {
      final uri =
          Uri.parse("${api_url.userProfile}/${authController.getEmployeeId()}");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
          'Cookie': 'culture=Ar',
        },
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<User?> getUserProfile2() async {
    final authController = Get.find<AuthenticationController>();
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }

    try {
      final uri =
          Uri.parse("${api_url.userProfile}/${authController.getEmployeeId()}");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
          'Cookie': 'culture=Ar',
        },
      );
      if (response.statusCode == 200) {
        final EmployeeListResult result =
            EmployeeListResult.fromJson(response.body);
        final user = result.data!;
        return user;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
