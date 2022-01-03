import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:xiaoming/models/users.dart';

class AuthenticationController extends GetxController {
  String? accessToken;
  UserProfile? userProfile;

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  void checkToken() async {
    final storage = FlutterSecureStorage();
    final String? token = await storage.read(key: "token");
    if (token != null) {
      updateToken(token);
    } else {
      clearToken();
    }
  }

  void updateToken(String token) async {
    accessToken = token;
    update();
  }

  void clearToken() async {
    accessToken = "";
    update();
  }

  void updateUserProfile(UserProfile profile) {
    userProfile = profile;
    update();
  }
}
