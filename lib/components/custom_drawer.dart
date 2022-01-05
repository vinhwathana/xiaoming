import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/drawer_item.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/big_image.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget userProfile(){
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
              foregroundImage:
              MemoryImage(base64Decode(user.imageBase64!)),
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
          const DrawerItem(),
        ],
      ),
    );
  }
}
