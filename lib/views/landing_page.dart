import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:xiaoming/components/custom_alert_dialog.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/internet_check_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/employee_list_result.dart';
import 'package:xiaoming/services/authentication_service.dart';
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
  late final StreamSubscription subscription;
  bool isDialogOpen = false;

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

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetCheckController>(builder: (controller) {
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
              if (snapshot.hasData && snapshot.data != null) {
                final token = snapshot.data;
                final authController = Get.put(AuthenticationController());
                authController.accessToken = token;
                return FutureBuilder<http.Response?>(
                  future: getUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final response = snapshot.data;
                      if (response == null || response.statusCode == 401) {
                        return LoginPage();
                      }
                      final EmployeeListResult result =
                          EmployeeListResult.fromJson(response.body);

                      final userController = Get.put(UserController());
                      userController.users = result.data!.obs;
                      print(userController.users!.value);
                      return HomePage();
                    } else {
                      return LoginPage();
                    }
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
      }),
    );
  }
}
