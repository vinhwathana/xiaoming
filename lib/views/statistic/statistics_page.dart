import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/utils/api_route.dart';
import 'package:xiaoming/views/statistic/skill_by_degree_statistic_page.dart';
import 'package:xiaoming/views/statistic/certificate_statistic_page.dart';
import 'package:xiaoming/views/statistic/staff_statistic_page.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final filterDialogController = Get.put(FilterDialogController());
  String dept = "00";
  String org = "00";
  String degree = "P";

  final tabs = <Tab>[
    Tab(text: "កម្រិតសញ្ញាបត្រ និងជំនាញ"),
    Tab(text: "ជំនាញ"),
    Tab(text: "កម្រិតសញ្ញាបត្រ"),
    Tab(text: "ភេទ"),
    Tab(text: "ឥស្សរិយយស្ស"),
    Tab(text: "កាំបៀវត្ស"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ស្ថិតិ'),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  FilterDialog(
                    showDegreeField: false,
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
              },
              icon: Icon(Icons.filter_list),
            ),
          ],
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              SkillByDegreeStatisticPage(
                org: org,
                dept: dept,
              ),
              SkillByDegreeStatisticPage(
                org: org,
                dept: dept,
              ),
              CertificateStatisticPage(
                org: org,
                dept: dept,
              ),
              StaffStatisticPage(
                org: org,
                dept: dept,
              ),
              SkillByDegreeStatisticPage(
                org: org,
                dept: dept,
              ),
              SkillByDegreeStatisticPage(
                org: org,
                dept: dept,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderData {
  GenderData(this.male);

  final int male;
}
