import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/models/employee_list_result.dart';
import 'package:xiaoming/models/users.dart';

class UserController extends GetxController {
  Rx<Users>? users;
  http.Response? response;

  List<String> getListOfKey(/*String responseBody*/) {
    if (response == null) {
      print("response == null");
    }
    final decoded = jsonDecode(response!.body) as Map;
    List<String> tempList = [];
    decoded["data"]["officialInfo"].keys.forEach((element) {
      tempList.add(element.toString());
    });
    return tempList;
  }

  void setData(http.Response response) {
    final EmployeeListResult result =
        EmployeeListResult.fromJson(response.body);
    users = result.data!.obs;
    this.response = response;
    update();
  }
}
