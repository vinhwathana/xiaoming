import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/views/personal_info/krob_khan_page.dart';
import 'package:xiaoming/views/statistic/krob_khan_statistic_page.dart';
import 'package:xiaoming/views/statistic/merit_statistic_page.dart';
import 'package:xiaoming/views/statistic/skill_by_degree_statistic_page.dart';
import 'package:xiaoming/views/statistic/certificate_statistic_page.dart';
import 'package:xiaoming/views/statistic/skill_statistic_page.dart';
import 'package:xiaoming/views/statistic/staff_statistic_page.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  final filterDialogController = Get.put(FilterDialogController());
  String dept = "00";
  String org = "00";
  String degree = "P";
  late final tabController = TabController(
    length: tabs.length,
    vsync: this,
  );

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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ស្ថិតិ'),
      //   actions: [
      //     IconButton(
      //       onPressed: () => setState(() {}),
      //       icon: Icon(Icons.refresh),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Get.dialog(
      //           FilterDialog(
      //             showDegreeField: (tabController.index == 0),
      //             onConfirm: (org, dept, degree) {
      //               setState(() {
      //                 this.org = org;
      //                 this.dept = dept;
      //                 this.degree = degree;
      //               });
      //             },
      //           ),
      //           useSafeArea: true,
      //           transitionCurve: Curves.ease,
      //         );
      //       },
      //       icon: Icon(Icons.filter_list),
      //     ),
      //   ],
      //   bottom: TabBar(
      //     controller: tabController,
      //     tabs: tabs,
      //     isScrollable: true,
      //   ),
      // ),
      body: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: const Text('ស្ថិតិ'),
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    actions: [
                      IconButton(
                        onPressed: () => setState(() {}),
                        icon: Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            FilterDialog(
                              showDegreeField: (tabController.index == 0),
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
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: tabController,
                      tabs: tabs,
                      isScrollable: true,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: tabBarView(),
        ),
      ),
    );
  }

  Widget tabBarView() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        SkillByDegreeStatisticPage(
          chartTitle: tabs[0].text ?? "",
          org: org,
          dept: dept,
          degree: degree,
        ),
        SkillStatisticPage(
          chartTitle: tabs[1].text ?? "",
          org: org,
          dept: dept,
        ),
        CertificateStatisticPage(
          chartTitle: tabs[2].text ?? "",
          org: org,
          dept: dept,
        ),
        StaffStatisticPage(
          chartTitle: tabs[3].text ?? "",
          org: org,
          dept: dept,
        ),
        MeritStatisticPage(
          chartTitle: tabs[4].text ?? "",
          org: org,
          dept: dept,
        ),
        KrobKhanStatisticPage(
          chartTitle: tabs[5].text ?? "",
          org: org,
          dept: dept,
        ),
      ],
    );
  }

// @override
// bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: CompanyColors.blue,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TwoColumnDataGridSource extends DataGridSource {
  TwoColumnDataGridSource({
    required this.tableData,
    required String firstColumnName,
    required String secondColumnName,
  }) {
    _tableData = tableData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: firstColumnName,
            value: e.name,
          ),
          DataGridCell<int>(
            columnName: secondColumnName,
            value: e.amount.toInt(),
          ),
        ],
      );
    }).toList();
  }

  final List<ChartModel> tableData;
  List<DataGridRow> _tableData = [];

  @override
  List<DataGridRow> get rows => _tableData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'KhmerOSBattambong',
                height: 1.5,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class ChartModel {
  const ChartModel(
    this.name,
    this.amount,
    this.color,
  );

  final String name;
  final double amount;
  final Color color;
}
