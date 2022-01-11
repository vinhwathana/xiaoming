import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xiaoming/models/authentication.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/utils/constant.dart';

class AuthenticationService {
  Future<String?> login(Authentication authentication) async {
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final String token = responseJson['_token'];
        return token;
      } else if (response.statusCode == 401) {
        showToast("Unauthorized");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signOut({required String token}) async {
    try {
      final uri = Uri.parse(api_url.authLogout);
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recoveryUserPassword(String email) async {
    try {
      final uri = Uri.parse(api_url.recoverUserPassword);
      final response = await http.post(uri,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $changePasswordToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode({
            "email": "$email",
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }else if(response.statusCode == 400){
        showToast("អ៊ីមែលមិនត្រឹមត្រូវ");
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<http.Response> changePasswordWithOTP(
      String email, String password, String otp) async {
    final uri = Uri.parse(api_url.changeUserPassword);
    final response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $changePasswordToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "email": "$email",
        "password": "$password",
        "otpCode": "$otp",
      }),
    );
    return response;
    // "email": "sannchesda8981@gmail.com",
    // "password": "376893",
    // "otpCode": "376893"
  }
}
