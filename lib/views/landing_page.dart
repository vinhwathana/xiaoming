import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/components/custom_alert_dialog.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/internet_check_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/employee_list_result.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/services/localization_service.dart';
import 'package:xiaoming/services/users_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final loginService = AuthenticationService();
  final storage = FlutterSecureStorage();
  final userService = UserService();
  late final StreamSubscription subscription;
  bool isDialogOpen = false;
  final userController = Get.put(UserController(), permanent: true);
  final authController = Get.put(AuthenticationController(), permanent: true);

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
            return FutureBuilder<String?>(
              future: storage.read(key: "$tokenKeyName"),
              builder: (context, snapshot) {
                print("Check user token is expire or not");
                if (snapshot.hasData) {
                  final token = snapshot.data;

                  if (token == null) {
                    authController.clearToken();
                    print("Saved Token null");
                  } else {
                    print("Have Token in Controller");
                    authController.updateToken(token);
                  }
                  print("Get token to check with server if it is expired");
                  return GetBuilder<AuthenticationController>(
                    builder: (controller) {
                      return FutureBuilder<http.Response?>(
                        future: userService.getUserProfile(),
                        builder: (context, snapshot) {
                          print("Getting user profile...");
                          if (snapshot.hasData) {
                            final response = snapshot.data;
                            if (response == null ||
                                response.statusCode != 200) {
                              print(response?.statusCode ?? null);
                              print("Landing Page: invalid Token");
                              // controller.clearToken();
                              return LoginPage();
                            }

                            userController.setData(response);
                            print("User Data store in controller");
                            return HomePage();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print("Checking token and user data...");
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            print("Token invalid / expire");
                            return LoginPage();
                          }
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: Text("Welcome"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
