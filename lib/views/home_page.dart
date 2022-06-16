import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/custom_drawer.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/personal_info/new_user_info_page.dart';
import 'package:xiaoming/views/statistic/pages/list_statistic_page.dart';

import 'attendance/attendance_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Widget userProfile() {
  //   return GetBuilder<UserController>(
  //     builder: (controller) {
  //       if (controller.users != null &&
  //           controller.users!.value.officialInfo != null) {
  //         final user = controller.users!.value.officialInfo;
  //         if (user!.imageBase64 == null) {
  //           return Container();
  //         }
  //         return InkWell(
  //           onTap: () {
  //             Get.to(
  //               () => ImagePreviewPage(
  //                 imageBase64: user.imageBase64!,
  //                 imageProvider: MemoryImage(
  //                   base64Decode(user.imageBase64!),
  //                 ),
  //               ),
  //             );
  //           },
  //           child: CircleAvatar(
  //             foregroundImage: MemoryImage(base64Decode(user.imageBase64!)),
  //           ),
  //         );
  //       }
  //       return InkWell(
  //         onTap: () {
  //           Get.to(
  //             () => const ImagePreviewPage(
  //               imageBase64: dummyNetworkImage,
  //               imageProvider: NetworkImage(
  //                 dummyNetworkImage,
  //               ),
  //             ),
  //           );
  //         },
  //         child: const CircleAvatar(
  //           foregroundImage: NetworkImage(
  //             dummyNetworkImage,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: RefreshIndicator(
        onRefresh: () async {
          final authCon = Get.find<AuthenticationController>();
          authCon.update();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ប្រព័ន្ធព័ត៌មានមន្ត្រីរាជការ'),
            actions: const [
              // IconButton(
              //   onPressed: () async {},
              //   icon: const Icon(Icons.settings),
              // ),
            ],
          ),
          drawer: const CustomDrawer(),
          body: SafeArea(
            child: HomePageGridView(),
          ),
        ),
      ),
    );
  }
}

class HomePageGridView extends StatelessWidget {
  HomePageGridView({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: homePageItems.length,
      padding: const EdgeInsets.all(20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => homePageItems[index].destination);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Icon(
                    homePageItems[index].icon,
                    size: 75,
                    color: CompanyColors.blue,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        homePageItems[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 18,
                        minFontSize: 14,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          color: CompanyColors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final List<_HomePageItem> homePageItems = [
  const _HomePageItem(
    title: "ព័ត៌មានផ្ទាល់ខ្លួន",
    icon: Icons.account_circle,
    destination: NewUserInfoPage(),
  ),
  const _HomePageItem(
    title: "វត្តមានផ្ទាល់ខ្លួន",
    icon: Icons.calendar_today,
    destination: AttendancePage(),
  ),
  const _HomePageItem(
    title: "ស្ថិតិ",
    icon: Icons.pie_chart,
    destination: ListStatisticPage(),
    // destination: StatisticsPage(),
  ),
];

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
