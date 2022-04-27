import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/attendance/attendance_page.dart';
import 'package:xiaoming/views/utils/image_preview_page.dart';
import 'package:xiaoming/views/change_password_page.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/landing_page.dart';
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
        if (controller.users != null &&
            controller.users!.value.officialInfo != null) {
          final user = controller.users!.value.officialInfo;
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
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          userProfile(),
          const SizedBox(
            height: 7,
          ),
          GetBuilder<UserController>(
            builder: (controller) {
              final user = controller.users?.value;
              if (user != null &&
                  user.officialInfo != null &&
                  (user.officialInfo!.firstNameKh != null ||
                      user.officialInfo!.lastNameKh != null)) {
                return Text(
                  '${user.officialInfo!.firstNameKh} ${user.officialInfo!.lastNameKh}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              }
              return const Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
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
        Get.offAll(
          () => const LandingPage(),
          transition: Transition.rightToLeft,
        );
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
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
          onTap: () {
            Get.back();
            Get.to(() => const UserInfoPage());
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('វត្តមាន'),
          onTap: () {
            Get.back();
            Get.to(() => const AttendancePage());
          },
        ),
        ListTile(
          leading: const Icon(Icons.pie_chart),
          title: const Text('ស្ថិតិ'),
          onTap: () {
            Get.back();
            // Get.to(() => const StatisticsPage());
          },
        ),
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
