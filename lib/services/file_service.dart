import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;

class FileService {
  final authController = Get.find<AuthenticationController>();

  Future<http.Response?> getFile(String fileId) async {
    try {
      final uri = Uri.parse("${api_url.getFile}/$fileId");
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer ${authController.accessToken}',
      };
      final response = await http.get(
        uri,
        headers: headers,
      );

      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
