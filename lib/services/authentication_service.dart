import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/authentication.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/utils/constant.dart';

class AuthenticationService {
  final storage = FlutterSecureStorage();

  Future<bool> login(Authentication authentication) async {
    try {
      final uri = Uri.parse(api_url.authLogin);
      final payload = jsonEncode(authentication.toJson());
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: payload,
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final String token = responseJson['_token'];
        final AuthenticationController controller =
            Get.find<AuthenticationController>();
        print(token);
        controller.updateToken(token);
        await storeToken(token);
        return true;
      } else if (response.statusCode == 401) {
        showToast("Unauthorized");
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> storeToken(String token) async {
    return await storage.write(key: "token", value: token);
  }
}
