import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/default_user_image.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/views/change_password_page.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/landing_page.dart';
import 'package:xiaoming/views/utils/image_preview_page.dart';

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
        final user = controller.user?.value.officialInfo;
        return InkWell(
          onTap: () {
            if (user?.imageBase64 != null) {
              Get.to(
                () => ImagePreviewPage(
                  imageProvider: MemoryImage(
                    base64Decode(user?.imageBase64 ?? ""),
                  ),
                ),
              );
            }
          },
          child: (user?.imageBase64 == null)
              ? DefaultUserImage(
                  fullName: user?.getFullNameKh() ?? "",
                  height: 90,
                  width: 90,
                )
              : CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  foregroundImage:
                      MemoryImage(base64Decode(user?.imageBase64 ?? "")),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: CompanyColors.blue,
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
        Get.offAll(() => const LandingPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.home,
            color: CompanyColors.yellow,
          ),
          title: Text(
            'ទំព័រដើម',
            style: TextStyle(color: CompanyColors.blue),
          ),
          onTap: () {
            Get.back();
            Get.to(() => const HomePage());
          },
        ),
        ...List.generate(homePageItems.length, (index) {
          return ListTile(
            leading: Icon(
              homePageItems[index].icon,
              color: CompanyColors.yellow,
            ),
            title: Text(
              homePageItems[index].title,
              style: TextStyle(color: CompanyColors.blue),
            ),
            onTap: () {
              Get.back(closeOverlays: true);
              Get.to(() => homePageItems[index].destination);
            },
          );
        }),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.password,
            color: CompanyColors.yellow,
          ),
          title: Text(
            'ផ្លាស់ប្តូរពាក្យសម្ងាត់',
            style: TextStyle(color: CompanyColors.blue),
          ),
          onTap: () {
            Get.back();
            Get.to(() => const ChangePasswordPage());
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: CompanyColors.yellow,
          ),
          title: Text(
            'ចាកចេញ',
            style: TextStyle(color: CompanyColors.blue),
          ),
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
