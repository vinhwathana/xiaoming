import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/custom_alert_dialog.dart';
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
                  imageProvider: ExtendedMemoryImageProvider(
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
              : Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: MemoryImage(
                                base64Decode(user?.imageBase64 ?? ""),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomPaint(
                      painter: HolePainter(),
                      child: Container(
                        height: 90,
                        width: 90,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
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

class HolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(RRect.fromLTRBR(-10, -10, 100, 100, Radius.circular(10))),
        Path()
          ..addOval(Rect.fromCircle(center: Offset(45, 45), radius: 45))
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
    authService.signOut(token: token).then((value) async {
      setState(() {
        isVisible = false;
      });
      if (value) {
        authController.clearToken();
        await Get.delete<UserController>();
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
        ...List.generate(homePageItems.length - 1, (index) {
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
        ExpansionTile(
          title: Text(
            homePageItems[homePageItems.length - 1].title,
            style: TextStyle(color: CompanyColors.blue),
          ),
          textColor: CompanyColors.blue,
          iconColor: Colors.red,
          leading: Icon(
            homePageItems[homePageItems.length - 1].icon,
            color: CompanyColors.yellow,
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            ListTile(
              leading: Icon(
                homePageItems[homePageItems.length - 1].icon,
                color: Colors.transparent,
              ),
              title: Text(
                "ការស្នើសុំច្បាប់",
                style: TextStyle(color: CompanyColors.blue),
              ),
            ),
            ListTile(
              leading: Icon(
                homePageItems[homePageItems.length - 1].icon,
                color: Colors.transparent,
              ),
              title: Text(
                "បញ្ជីស្នើសុំច្បាប់",
                style: TextStyle(color: CompanyColors.blue),
              ),
            ),
          ],
        ),
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
            showCustomDialog(
              context,
              title: "តើអ្នកពិតជាចង់ចាកចេញមែនទេ?",
              onConfirm: () {
                onSignOut();
              },
            );
          },
        )
      ],
    );
  }
}
