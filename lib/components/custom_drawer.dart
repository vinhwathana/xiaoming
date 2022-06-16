import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/attendance/attendance_page.dart';
import 'package:xiaoming/views/statistic/pages/list_statistic_page.dart';
import 'package:xiaoming/views/utils/image_preview_page.dart';
import 'package:xiaoming/views/change_password_page.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/personal_info/user_info_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget userProfile() {
    return GetBuilder<UserController>(
      builder: (controller) {
        if (controller.user != null &&
            controller.user!.value.officialInfo != null) {
          final user = controller.user!.value.officialInfo;
          if (user!.imageBase64 == null) {
            return Container();
          }
          return InkWell(
            onTap: () {
              Get.to(
                () => ImagePreviewPage(
                  imageBase64: user.imageBase64!,
                  imageProvider: MemoryImage(
                    base64Decode(user.imageBase64!),
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              foregroundImage: MemoryImage(base64Decode(user.imageBase64!)),
            ),
          );
        }
        return InkWell(
          onTap: () {
            Get.to(
              () => const ImagePreviewPage(
                imageBase64: dummyNetworkImage,
                imageProvider: NetworkImage(
                  dummyNetworkImage,
                ),
              ),
            );
          },
          child: const CircleAvatar(
            radius: 45,
            foregroundImage: NetworkImage(
              dummyNetworkImage,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  userProfile(),
                  const SizedBox(height: 8),
                  GetBuilder<UserController>(
                    builder: (controller) {
                      final user = controller.user?.value;
                      return Text(
                        user?.officialInfo?.getFullNameKh() ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  const _DrawerItem(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "ជំនាន់ ១.០",
                style: TextStyle(
                  fontSize: 18,
                  color: CompanyColors.yellow.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatefulWidget {
  const _DrawerItem({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool isVisible = false;

  void onSignOut() {
    setState(() {
      isVisible = true;
    });
    final authService = AuthenticationService();
    final authController = Get.find<AuthenticationController>();
    final token = authController.accessToken!;
    authService.signOut(token: token).then((value) {
      setState(() {
        isVisible = false;
      });
      if (value) {
        authController.clearToken();
        // Get.offAll(
        //   () => const LandingPage(),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('ទំព័រដើម'),
          onTap: () {
            Get.back();
            Get.to(() => const HomePage());
          },
        ),
        ...List.generate(homePageItems.length, (index) {
          return ListTile(
            leading: Icon(homePageItems[index].icon),
            title: Text(homePageItems[index].title),
            onTap: () {
              Get.back(closeOverlays: true);
              Get.to(() => homePageItems[index].destination);
            },
          );
        }),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.password),
          title: const Text('ផ្លាស់ប្តូរពាក្យសម្ងាត់'),
          onTap: () {
            Get.back();
            Get.to(() => const ChangePasswordPage());
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('ចាកចេញ'),
          trailing: Visibility(
            visible: isVisible,
            child: const CircularProgressIndicator(),
          ),
          onTap: () {
            onSignOut();
          },
        )
      ],
    );
  }
}
