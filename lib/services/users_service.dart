import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/views/landing_page.dart';

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
}
