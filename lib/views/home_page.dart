//Homepage dashboard for gridview
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/custom_drawer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/attendance_page.dart';
import 'package:xiaoming/views/big_image_page.dart';

import 'personal_info_page.dart';
import 'statistics_page.dart';

class HomePage extends StatelessWidget {
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
            child: Hero(
              tag: user.imageBase64!,
              child: CircleAvatar(
                foregroundImage: MemoryImage(base64Decode(user.imageBase64!)),
              ),
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
          child: Hero(
            tag: dummyNetworkImage,
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                dummyNetworkImage,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ប្រព័ន្ធព័ត៌មានមន្ត្រីរាជការ'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const SafeArea(
        child: HomePageGridView(),
      ),
    );
  }
}

class HomePageGridView extends StatelessWidget {
  const HomePageGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_HomePageItem> homePageItems = [
      _HomePageItem(
        title: "ព័ត៌មានផ្ទាល់ខ្លួន",
        icon: Icons.person,
        destination: PersonalInfoPage(),
      ),
      _HomePageItem(
        title: "វត្តមានផ្ទាល់ខ្លួន",
        icon: Icons.access_time,
        destination: AttendancePage(),
      ),
      // _HomePageItem(
      //   title: "ស្កេនវត្តមាន",
      //   icon: Icons.qr_code_scanner,
      //   destination: PersonalInfoPage(),
      // ),
      _HomePageItem(
        title: "ស្ថិតិ",
        icon: Icons.pie_chart,
        destination: StatisticsPage(),
      ),
    ];

    return GridView.builder(
      itemCount: homePageItems.length,
      padding: EdgeInsets.all(20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor),
          margin: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.to(() => homePageItems[index].destination);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    homePageItems[index].icon,
                    size: 70.0,
                    color: Colors.white,
                  ),
                  Divider(),
                  Text(
                    homePageItems[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomePageItem {
  final String title;
  final IconData icon;
  final Widget destination;

  const _HomePageItem({
    required this.title,
    required this.icon,
    required this.destination,
  });
}
