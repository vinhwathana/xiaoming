import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/holiday/holiday_response.dart';
import 'package:xiaoming/services/utils.dart';
import 'package:xiaoming/utils/api_route.dart';
import 'package:http/http.dart' as http;

class HolidayService {
  final authController = Get.find<AuthenticationController>();

  Future<HolidayResponse?> getHoliday({
    String start = "0",
    String length = "1",
    String search = "",
    String all = "1",
  }) async {
    final ministryCode = authController.getUserMinistryCode();
    final String url = "$getHolidayUrl?"
        "start=$start&"
        "length=$length&"
        "search=$search&"
        "ministryCode=$ministryCode&"
        "All=1";

    final response = await callingApiMethod(
      url: url,
      method: Method.GET,
      returnResponse: true,
    );

    if (response is http.Response) {
      if (response.statusCode == 200) {
        final holidayResponse = holidayResponseFromJson(response.body);

        return holidayResponse;
      }
    }

    processError(response);
    return null;
  }
}
