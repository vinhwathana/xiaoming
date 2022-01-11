import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/big_image_page.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/landing_page.dart';
import 'package:xiaoming/views/login_page.dart';
import 'package:xiaoming/views/personal_info_page.dart';

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
                () => BigImagePage(
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
              () => BigImagePage(
                imageBase64: dummyNetworkImage,
                imageProvider: NetworkImage(
                  dummyNetworkImage,
                ),
              ),
            );
          },
          child: CircleAvatar(
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
          SizedBox(
            height: 20,
          ),
          userProfile(),
          SizedBox(
            height: 7,
          ),
          Text(
            'វិញ វឌ្ឍនា',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(),
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
        Get.offAll(() => LandingPage(), transition: Transition.rightToLeft);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('ទំព័រដើម'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalInfoPage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('វត្តមាន'),
        ),
        ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text('ឯកសារ'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('ចាកចេញ'),
          trailing: Visibility(
            visible: isVisible,
            child: CircularProgressIndicator(),
          ),
          onTap: () {
            onSignOut();
          },
        )
      ],
    );
  }
}
