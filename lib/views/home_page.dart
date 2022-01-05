//Homepage dashboard for gridview
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/mptc_grid_icons.dart';
import 'package:xiaoming/components/mptc_left_drawer.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/big_image.dart';

import 'personal_info_page.dart';
import 'mptc_statistics.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ប្រព័ន្ធព័ត៌មានមន្ត្រីរាជការ'),
        actions: [
          GetBuilder<UserController>(
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
                      foregroundImage:
                          MemoryImage(base64Decode(user.imageBase64!)),
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
          ),
          // IconButton(
          //   onPressed: () {
          //     final controller = Get.find<AuthenticationController>();
          //     print(controller.accessToken);
          //   },
          //   icon: Icon(Icons.analytics),
          // ),
        ],
      ),
      drawer: const MPTCLeftDrawerWidget(),
      body: const SafeArea(
        child: HomePageItemView(),
      ),
    );
  }
}

class HomePageItemView extends StatefulWidget {
  const HomePageItemView({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageItemViewState createState() => _HomePageItemViewState();
}

class _HomePageItemViewState extends State<HomePageItemView> {
  final List<Widget> _listPages = [];

  @override
  void initState() {
    super.initState();
    _listPages
      ..add(PersonalInfoPage())
      ..add(Statistics())
      ..add(Statistics())
      ..add(Statistics());
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> _iconList = GridIcons().getIconList();
    final List<String> _iconText = GridIcons().getIconText();

    return GridView.builder(
      itemCount: 4,
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
                Get.to(() => _listPages[index]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    _iconList[index],
                    size: 70.0,
                    color: Colors.white,
                  ),
                  Divider(),
                  Text(
                    _iconText[index],
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
