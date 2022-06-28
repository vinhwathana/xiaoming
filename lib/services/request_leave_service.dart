import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/request_leave/create_request_leave_request.dart';
import 'package:xiaoming/models/request_leave/personal_request_leave_list.dart';
import 'package:xiaoming/services/utils.dart';
import 'package:xiaoming/utils/constant.dart';

import '../utils/api_route.dart';
import 'package:http/http.dart' as http;

class RequestLeaveService {
  final authController = Get.find<AuthenticationController>();

  Future<void> createRequestLeave(CreateRequestLeaveRequest request) async {
    const url = createRequestLeaveUrl;
    final response = await callingApiMethod(
      url: url,
      method: Method.POST,
      body: request.toJson(),
    );

    if (response is Map<String, dynamic>) {
      showToast("Something went right");
    }

    processError(response);
  }

  Future<PersonalRequestLeaveList?> getPersonalRequestLeave({
    int start = 0,
    int length = 10,
    String search = "",
  }) async {
    final ministryCode = authController.getUserMinistryCode();
    final employeeId = authController.getEmployeeId();
    final url = "$personalRequestLeaveUrl?"
        "start=$start&"
        "length=$length&"
        "search=$search&"
        "EmployeeID=$employeeId&"
        "Ministry=$ministryCode";

    final response = await callingApiMethod(
      url: url,
      method: Method.GET,
      returnResponse: true,
    );

    if (response is http.Response) {
      if (response.statusCode == 200) {
        try {
          final personalRequestLeaveList =
              personalRequestLeaveListFromJson(response.body);
          return personalRequestLeaveList;
        } catch (e) {
          print(e);
        }
      }
    }

    processError(response);
    return null;
  }
}
