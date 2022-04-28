
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:http/http.dart' as http;

class AutocompleteService {
  final authController = Get.find<AuthenticationController>();

  Future<List<ListValue>?> getCountries() async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    // from?dateFrom=2022-02-9&dateTo=2022-02-11
    try {
      const url = api_url.countryUrl;

      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final listOfValues = listValueFromMap(response.body);
        return listOfValues;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return null;
  }

  Future<List<ListValue>?> getSpecializes() async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    // from?dateFrom=2022-02-9&dateTo=2022-02-11
    try {
      const url = api_url.specializeUrl;

      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
          "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final listOfValues = listValueFromMap(response.body);
        return listOfValues;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return null;
  }
}
