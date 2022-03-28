import 'package:get/get.dart';
import 'package:xiaoming/controllers/internet_check_controller.dart';
import 'package:xiaoming/services/location_service.dart';
import 'authentication_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController(),
        fenix: true);
    Get.put<InternetCheckController>(InternetCheckController(),
        permanent: true);
    Get.lazyPut<CheckLocationService>(() => CheckLocationService(),
        fenix: true);
  }
}
