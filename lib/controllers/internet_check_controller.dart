

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InternetCheckController extends GetxController{
  final connectionStatus = ConnectivityResult.none.obs;
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivity.onConnectivityChanged.listen((result) {
      connectionStatus.value = result;
      update();
    });
  }

  void initConnectivity() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      connectionStatus.value = connectivityResult;
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
  }
}