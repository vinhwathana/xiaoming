import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';

class AuthenticationController extends GetxController {
  String? accessToken;
  final storage = FlutterSecureStorage();
  final authService = AuthenticationService();

  Future<void> updateToken(String token) async {
    accessToken = token;
    await storage.write(key: "$tokenKeyName", value: token);
    print("Token saved");
    update();
  }

  Future<void> clearToken() async {
    accessToken = "";
    await storage.delete(key: "$tokenKeyName");
    print("Token cleared");
    update();
  }

  String? getEmployeeId() {
    if (accessToken == null) {
      showToast("Access token null");
      return null;
    }
    final data = parseJwt(accessToken!);
    final employeeId = data["EmployeeId_New"];
    return employeeId;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
