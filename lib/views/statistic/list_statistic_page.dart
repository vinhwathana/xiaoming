import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/views/cells_rows/card_tile.dart';
import 'package:xiaoming/views/statistic/certificate_statistic_page.dart';
import 'package:xiaoming/views/statistic/krob_khan_statistic_page.dart';
import 'package:xiaoming/views/statistic/merit_statistic_page.dart';
import 'package:xiaoming/views/statistic/skill_by_degree_statistic_page.dart';
import 'package:xiaoming/views/statistic/skill_statistic_page.dart';
import 'package:xiaoming/views/statistic/staff_statistic_page.dart';

class ListStatisticPage extends StatefulWidget {
  const ListStatisticPage({Key? key}) : super(key: key);

  @override
  State<ListStatisticPage> createState() => _ListStatisticPageState();
}

class _ListStatisticPageState extends State<ListStatisticPage>
    with SingleTickerProviderStateMixin {
  final filterDialogController = Get.put(FilterDialogController());
  String dept = "00";
  String org = "00";
  String degree = "P";
  late final tabController = TabController(
    length: tabs.length,
    vsync: this,
  );

  final statNames = [
    "កម្រិតសញ្ញាបត្រ",
    "ជំនាញ",
    "កម្រិតសញ្ញាបត្រ និងជំនាញ",
    "ភេទ",
    "ឥស្សរិយយស្ស",
    "ក្របខណ្ឌ",
  ];

  final tabs = <Tab>[
    const Tab(text: "កម្រិតសញ្ញាបត្រ"),
    const Tab(text: "ជំនាញ"),
    const Tab(text: "កម្រិតសញ្ញាបត្រ និងជំនាញ"),
    const Tab(text: "ភេទ"),
    const Tab(text: "ឥស្សរិយយស្ស"),
    const Tab(text: "ក្របខណ្ឌ"),
  ];

  final Widget trailingIcon = Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ស្ថិតិ'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardTile(
                title: Text(statNames[0]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                    () => CertificateStatisticPage(
                      chartTitle: statNames[0],
                    ),
                  );
                },
              ),
              CardTile(
                title: Text(statNames[1]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                    () => SkillStatisticPage(chartTitle: statNames[1]),
                  );
                },
              ),
              CardTile(
                title: Text(statNames[2]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                    () => SkillByDegreeStatisticPage(
                      chartTitle: statNames[2],
                    ),
                  );
                },
              ),
              CardTile(
                title: Text(statNames[3]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                        () => StaffStatisticPage(
                      chartTitle: statNames[3],
                    ),
                  );
                },
              ),
              CardTile(
                title: Text(statNames[4]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                        () => MeritStatisticPage(
                      chartTitle: statNames[4],
                    ),
                  );
                },
              ),
              CardTile(
                title: Text(statNames[5]),
                trailing: trailingIcon,
                onTap: () {
                  Get.to(
                        () => KrobKhanStatisticPage(
                      chartTitle: statNames[5],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFilterDialog() {
    Get.dialog(
      FilterDialog(
        showDegreeField: tabController.index == 2,
        onConfirm: (org, dept, degree) {
          setState(() {
            this.org = org;
            this.dept = dept;
            this.degree = degree;
          });
        },
      ),
      useSafeArea: true,
      transitionCurve: Curves.ease,
    );
  }
}
