import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/card/id_card_info.dart';
import 'package:xiaoming/services/utils.dart';
import 'package:xiaoming/utils/api_route.dart';

class CardService {
  final authController = Get.find<AuthenticationController>();
  Future<IdCardInfo?> getCardInfo() async {
    final employeeId = authController.getEmployeeId() ?? "";
    final String url = "$getCardInfoUrl/$employeeId";

    final response = await callingApiMethod(
      url: url,
      method: Method.GET,
    );

    if(response is Map<String, dynamic>){
      final cardInfo = IdCardInfo.fromJson(response);
      return cardInfo;
    }
    processError(response,isAutomaticLogout: true);
    return null;
  }
}
