import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CheckLocationService extends GetxController {
  final Rx<geo_locator.ServiceStatus> serviceStatus =
      geo_locator.ServiceStatus.disabled.obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationService();
    Geolocator.getServiceStatusStream().listen((event) {
      serviceStatus.value = event;
      update();
    });
  }

  bool determineServiceStatus(bool isEnable) {
    if (isEnable) {
      serviceStatus.value = geo_locator.ServiceStatus.enabled;
    } else {
      serviceStatus.value = geo_locator.ServiceStatus.disabled;
    }
    return isEnable;
  }

  Future<void> checkLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceStatus.value = geo_locator.ServiceStatus.disabled;
      return Future.error('Location services are disabled.');
    } else {
      serviceStatus.value = geo_locator.ServiceStatus.enabled;
    }
    update();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  Future<Position> determinePosition() async {
    await checkLocationService()
        .onError((error, stackTrace) => SystemNavigator.pop());
    return await Geolocator.getCurrentPosition();
  }
}
