import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/components/custom_alert_dialog.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/internet_check_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/services/users_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/login_page.dart';

class LandingPage2 extends StatefulWidget {
  const LandingPage2({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage2> createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2> {
  // final loginService = AuthenticationService();
  // final storage = const FlutterSecureStorage();
  final userService = UserService();
  late final StreamSubscription subscription;
  bool isDialogOpen = false;
  // final userController = Get.put(UserController(), permanent: true);
  final authController = Get.put(AuthenticationController(), permanent: true);
  //
  @override
  void initState() {
    super.initState();
    subscription =
        Get.find<InternetCheckController>().connectionStatus.listen((result) {
      if (result == ConnectivityResult.none) {
        isDialogOpen = true;
        showSingleChoiceAlertDialog(
          context,
          onClickOk: () {
            Get.back();
            isDialogOpen = false;
          },
        );
      } else {
        if (isDialogOpen) {
          Get.back();
          isDialogOpen = false;
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetCheckController>(
        builder: (controller) {
          if (controller.connectionStatus.value == ConnectivityResult.none) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Retry"),
              ),
            );
          } else {
            return CustomFutureBuilder<User?>(
              future: userService.getUserProfile2(),
              onDataRetrieved: (context, widget, connectionState){
                return HomePage();
              },
            );
          }
        },
      ),
    );
  }
}
