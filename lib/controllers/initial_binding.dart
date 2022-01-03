import 'package:get/get.dart';
import 'package:xiaoming/services/location_service.dart';
import 'authentication_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => CheckLocationService(), fenix: true);
  }
}
