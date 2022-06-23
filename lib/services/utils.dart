import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/default_response.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/landing_page.dart';

Future<dynamic> callingApiMethod({
  required String url,
  Object? body,
  required Method method,
  bool returnResponse = false,
}) async {
  // final storage = FlutterSecureStorage();
  final authController = Get.find<AuthenticationController>();
  final String? accessToken = authController.accessToken;
  final uri = Uri.parse(url);

  final headers = {
    HttpHeaders.acceptHeader: 'application/json',
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: "Bearer $accessToken",
  };

  http.Response? response;
  try {
    switch (method) {
      case Method.POST:
        {
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
        }
        break;
      case Method.GET:
        {
          {
            response = await http.get(
              uri,
              headers: headers,
            );
          }
        }
        break;
      case Method.UPDATE:
        {
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
        }
        break;
      case Method.DELETE:
        {
          response = await http.delete(
            uri,
            headers: headers,
          );
        }
        break;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  if (returnResponse) {
    return response;
  }

  if (response == null) {
    if (kDebugMode) {
      print("response is null");
    }
    return null;
  }
  return processResponse(response);
}

dynamic processResponse(http.Response response) {
  if (response.statusCode == 200) {
    final defaultResponse = defaultResponseFromJson(response.body);

    if (defaultResponse.statusCode == 200) {
      return defaultResponse.data;
    } else {
      return defaultResponse;
    }
  } else if (response.statusCode == 401) {
    Get.offAll(() => LandingPage());
  }
  return response.body;
}

void processError(dynamic response) {
  if (response is String) {
    if (response.isNotEmpty) {
      showToast(response);
    }
    log(response);
  } else if (response is DefaultResponse) {
    final errorMessage = """${response.message ?? ""}\n
    ${response.errors.toString()}""";
    if (errorMessage.isNotEmpty) {
      showToast(errorMessage);
    }
  } else {
    showToast("errorOccurred".tr);
    log(response.toString());
  }
}

enum Method {
  POST,
  GET,
  UPDATE,
  DELETE,
}
