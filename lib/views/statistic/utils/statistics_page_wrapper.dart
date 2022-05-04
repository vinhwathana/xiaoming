import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class StatisticsPageWrapper extends StatefulWidget {
  const StatisticsPageWrapper({
    Key? key,
    required this.builder,
    required this.title,
    this.showDegree = false,
  }) : super(key: key);
  final String title;
  final bool showDegree;
  final Widget Function(
      TabController controller, String org, String dept, String degree) builder;

  @override
  _StatisticsPageWrapperState createState() => _StatisticsPageWrapperState();
}

class _StatisticsPageWrapperState extends State<StatisticsPageWrapper>
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
    const Tab(text: "តារាងស្ថិតិ"),
    const Tab(text: "តារាងព័ត៌មាន"),
    const Tab(text: "តារាងព័ត៌មានលម្អិត"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  bottom: (GetPlatform.isIOS) ? false : true,
                  left: false,
                  right: false,
                  sliver: SliverAppBar(
                    title: Text(widget.title),
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    stretch: true,
                    actions: [
                      IconButton(
                        onPressed: () => setState(() {}),
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: () {
                          openFilterDialog();
                        },
                        icon: const Icon(Icons.filter_list),
                      ),
                    ],
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: tabController,
                      tabs: tabs,
                      isScrollable: true,
                      indicatorColor: CompanyColors.yellow,
                      indicatorWeight: 3,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: widget.builder(tabController, org, dept, degree),
          ),
        ),
      ),
    );
  }

  void openFilterDialog() {
    Get.dialog(
      FilterDialog(
        showDegreeField: widget.showDegree,
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
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'KhmerOSBattambong',
                // height: 1.5,
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
