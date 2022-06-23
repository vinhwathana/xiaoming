import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/services/utils.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;

class UserService {
  Future<http.Response?> preGetUserProfile() async {
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

  Future<User?> getUserProfile() async {
    final authController = Get.find<AuthenticationController>();

    final url = "${api_url.userProfile}/${authController.getEmployeeId()}";
    final response = await callingApiMethod(url: url, method: Method.GET);
    if (response is Map<String, dynamic>) {
      final result = User.fromMap(response);
      return result;
    }
    processError(response);
    return null;
  }
}
