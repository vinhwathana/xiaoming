import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/models/employee_list_result.dart';
import 'package:xiaoming/models/user.dart';

class UserController extends GetxController {
  Rx<User>? user;
  http.Response? response;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  List<String> getListOfKey(/*String responseBody*/) {
    if (response == null) {
      if (kDebugMode) {
        print("response == null");
      }
    }
    final decoded = jsonDecode(response!.body) as Map;
    final List<String> tempList = [];
    decoded["data"]["officialInfo"].keys.forEach((element) {
      final value = decoded["data"]["officialInfo"][element];
      if (value.runtimeType == String) {
        final valueAsString = value as String;
        if (valueAsString.isNotEmpty) {
          tempList.add(element.toString());
        }
        return;
      }
      if (value != null) {
        tempList.add(element.toString());
      }
    });
    return tempList;
  }

  void setData(http.Response response) {
    final EmployeeListResult result =
        EmployeeListResult.fromJson(response.body);
    user = result.data!.obs;
    this.response = response;
    update();
  }
}
