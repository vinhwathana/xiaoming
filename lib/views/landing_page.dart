import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/custom_alert_dialog.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/internet_check_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/services/users_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final userService = UserService();
  late final StreamSubscription subscription;
  bool isDialogOpen = false;

  final authController = Get.put(AuthenticationController(), permanent: true);
  final userController = Get.put(UserController());

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

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetCheckController>(
        builder: (controller) {
          if (kDebugMode) {
            print("controller.connectionStatus.value : ${controller.connectionStatus.value}");
          }
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
            return CustomFutureBuilder<String?>(
              future: storage.read(key: tokenKeyName),
              onDataRetrieved: (context, result, connectionState) {
                if (result == null) {
                  authController.clearToken();
                  return const LoginPage();
                }
                final token = result;
                authController.updateToken(token);

                return CustomFutureBuilder<User?>(
                  future: userService.getUserProfile(),
                  onDataRetrieved: (context, result, connectionState) {

                    if (result == null) {
                      return const LoginPage();
                    }
                    userController.setUser(result);
                    return const HomePage();
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
