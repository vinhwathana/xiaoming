import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/users.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/utils/constant.dart';

Future<UserProfile?> getUserProfile() async {
  final authController = Get.find<AuthenticationController>();
  if(authController.accessToken == null){
    showToast("Access Token null");
    return null;
  }
  try {
    var uri = Uri.parse(api_url.userProfile);
    var response = await http.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: authController.accessToken!
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      var userProfile = UserProfile.fromJson(responseJson);
      return userProfile;
    }
    return null;
  } catch (e) {
    return null;
  }
}
