// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:xiaoming/components/custom_alert_dialog.dart';
// import 'package:xiaoming/components/loading_widget.dart';
// import 'package:xiaoming/controllers/authentication_controller.dart';
// import 'package:xiaoming/controllers/internet_check_controller.dart';
// import 'package:xiaoming/controllers/user_controller.dart';
// import 'package:xiaoming/services/authentication_service.dart';
// import 'package:xiaoming/services/users_service.dart';
// import 'package:xiaoming/utils/constant.dart';
// import 'package:xiaoming/views/home_page.dart';
// import 'package:xiaoming/views/login_page.dart';
//
// class PrevLandingPage extends StatefulWidget {
//   const PrevLandingPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PrevLandingPage> createState() => _PrevLandingPageState();
// }
//
// class _PrevLandingPageState extends State<PrevLandingPage> {
//   final loginService = AuthenticationService();
//   final storage = const FlutterSecureStorage();
//   final userService = UserService();
//   late final StreamSubscription subscription;
//   bool isDialogOpen = false;
//   final userController = Get.put(UserController(), permanent: true);
//   final authController = Get.put(AuthenticationController(), permanent: true);
//
//   @override
//   void initState() {
//     super.initState();
//     subscription =
//         Get.find<InternetCheckController>().connectionStatus.listen((result) {
//       if (result == ConnectivityResult.none) {
//         isDialogOpen = true;
//         showSingleChoiceAlertDialog(
//           context,
//           onClickOk: () {
//             Get.back();
//             isDialogOpen = false;
//           },
//         );
//       } else {
//         if (isDialogOpen) {
//           Get.back();
//           isDialogOpen = false;
//         }
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     subscription.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<InternetCheckController>(
//         builder: (controller) {
//           if (controller.connectionStatus.value == ConnectivityResult.none) {
//             return Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: const Text("Retry"),
//               ),
//             );
//           } else {
//             return FutureBuilder<String?>(
//               future: storage.read(key: tokenKeyName),
//               builder: (context, snapshot) {
//                 if (kDebugMode) {
//                   print("Check user token is expire or not");
//                 }
//                 if (snapshot.hasData ||
//                     snapshot.connectionState == ConnectionState.done) {
//                   final token = snapshot.data;
//
//                   if (token == null) {
//                     authController.clearToken();
//                     if (kDebugMode) {
//                       print("Saved Token null");
//                     }
//                   } else {
//                     if (kDebugMode) {
//                       print("Have Token in Controller");
//                     }
//                     authController.updateToken(token);
//                   }
//                   if (kDebugMode) {
//                     print("Get token to check with server if it is expired");
//                   }
//                   return GetBuilder<AuthenticationController>(
//                     builder: (controller) {
//                       return FutureBuilder<http.Response?>(
//                         future: userService.preGetUserProfile(),
//                         builder: (context, snapshot) {
//                           if (kDebugMode) {
//                             print("Getting user profile...");
//                           }
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             if (kDebugMode) {
//                               print("Checking token and user data...");
//                             }
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                           if (snapshot.hasData) {
//                             final response = snapshot.data;
//                             if (response == null ||
//                                 response.statusCode != 200) {
//                               if (kDebugMode) {
//                                 print("Landing Page: invalid Token");
//                                 // showToast("Please login again");
//                               }
//                               return const LoginPage();
//                             }
//
//                             userController.setData(response);
//                             if (kDebugMode) {
//                               print("User Data store in controller");
//                             }
//                             return const HomePage();
//                           } else if (snapshot.hasError) {
//                             return const Center(
//                               child: Text("Error"),
//                             );
//                           } else {
//                             if (kDebugMode) {
//                               print("Token invalid / expire");
//                             }
//                             return const LoginPage();
//                           }
//                         },
//                       );
//                     },
//                   );
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const LoadingWidget();
//                 }
//                 return const Center(
//                   child: Text("Welcome"),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }