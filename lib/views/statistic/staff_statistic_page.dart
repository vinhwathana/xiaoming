import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/views/statistic/statistics_page_wrapper.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class StaffStatisticPage extends StatefulWidget {
  const StaffStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);
  final String chartTitle;

  @override
  _StaffStatisticPageState createState() => _StaffStatisticPageState();
}

class _StaffStatisticPageState extends State<StaffStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();

  final List<String> headerTitles = [
    "កម្រិតសញ្ញាបត្រ",
    "រាប់តែចំនួនសរុប",
  ];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      textStyle: const TextStyle(
        fontFamily: 'KhmerOSBattambong',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StatisticsPageWrapper(
      title: widget.chartTitle,
      builder: (controller, org, dept, degree) {
        return TabBarView(
          controller: controller,
          children: [
            staffChart(org, dept),
            staffDataGrid(org, dept),
            staffPeopleDataGrid(org, dept),
          ],
        );
      },
    );
  }

  Widget staffChart(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getStaffCount(org, dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final staffData = snapshot.data;
        if (staffData == null || staffData.length == 0) {
          return const Center(child: Text("No Data Available"));
        }

        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: Get.width,
            height: Get.height / 2,
            child: SfCircularChart(
              title: ChartTitle(
                text: widget.chartTitle,
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'KhmerOSBattambong',
                ),
              ),
              legend: Legend(
                isVisible: true,
                iconHeight: 24,
                iconWidth: 24,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'KhmerOSBattambong',
                ),
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<ChartModel, dynamic>(
                  name: widget.chartTitle,
                  dataSource: staffData,
                  xValueMapper: (datum, index) => datum.name,
                  yValueMapper: (ChartModel data, _) => data.amount.toInt(),
                  pointColorMapper: (datum, index) => datum.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  enableTooltip: true,
                  animationDuration: 850,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget staffDataGrid(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getStaffCount(org, dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final staffData = snapshot.data;
        if (staffData == null || staffData.length == 0) {
          return const Center(child: Text("No Data Available"));
        }

        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: SfDataGrid(
              source: StaffTableDataSource(
                certificateData: staffData,
              ),
              // onQueryRowHeight: (details) {
              //   return details.getIntrinsicRowHeight(details.rowIndex);
              // },
              // shrinkWrapRows: true,
              // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
              columns: List.generate(
                headerTitles.length,
                (index) {
                  return GridColumn(
                    columnName: headerTitles[index],
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        headerTitles[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "KhmerOSBattambong",
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    allowSorting: true,
                  );
                },
              ),
              columnWidthMode: ColumnWidthMode.auto,
              allowSorting: true,
              sortingGestureType: SortingGestureType.tap,
            ),
          ),
        );
      },
    );
  }

  Widget staffPeopleDataGrid(String org, String dept) {
    return StaffPeopleDataGrid(org: org, dept: dept);
  }

  @override
  bool get wantKeepAlive => true;
}

class StaffPeopleDataGrid extends StatefulWidget {
  const StaffPeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  State<StaffPeopleDataGrid> createState() => _StaffPeopleDataGridState();
}

class _StaffPeopleDataGridState extends State<StaffPeopleDataGrid> {
  // bool isLoading = false;
  final statService = StatisticService();
  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខដំណែង',
  ];
  final rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  // final filterController = Get.find<FilterDialogController>();
  // final certificatedTextController = TextEditingController();
  // List<String>? certificates;
  // String? selectedCertificate;

  @override
  void initState() {
    super.initState();
    // certificates = filterController.degrees.keys.toList();
    // selectedCertificate = certificates?[0];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatisticPeopleResponse?>(
      future: statService.getStaffPeople(
        widget.org,
        widget.dept,
        start: start,
        length: 10,
        search: "",
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final responseData = snapshot.data;
          final List<StatisticPeople>? skillPeopleData =
              responseData?.data;
          if (skillPeopleData == null || skillPeopleData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomDataGridWidget(
                  dataSource: SkillByDegreePeopleDataGridSource(
                    tableData: skillPeopleData,
                  ),
                  headerTitles: peopleHeaderTitles,
                  bottomWidget: DataGridPager(
                    rowsPerPage: rowsPerPage,
                    totalAmount: responseData?.totalFilteredRecord ?? 0,
                    selectedPage: selectedPage,
                    onChange: (index) {
                      // setState(() {
                      //   isLoading = true;
                      // });
                      int tempStart = start;
                      if (index > selectedPage) {
                        tempStart += rowsPerPage;
                      } else if (index < selectedPage) {
                        tempStart -= rowsPerPage;
                      } else {
                        tempStart = 0;
                      }
                      setState(() {
                        if (tempStart >= 0) {
                          start = tempStart;
                        }
                        selectedPage = index;
                        // isLoading = false;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible:
                      (snapshot.connectionState == ConnectionState.waiting),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class SkillByDegreePeopleDataGridSource extends DataGridSource {
  SkillByDegreePeopleDataGridSource({
    required this.tableData,
  }) {
    buildPaginatedDataGridRows();
  }

  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខដំណែង',
  ];

  List<StatisticPeople> tableData;
  List<DataGridRow> _tableData = [];

  @override
  List<DataGridRow> get rows => _tableData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataGridCell.value.toString(),
              style: const TextStyle(
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

  void buildPaginatedDataGridRows() {
    _tableData = tableData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: peopleHeaderTitles[0],
            value: e.firstNameKh,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[1],
            value: e.lastNameKh,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[2],
            value: e.gender,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[3],
            value: e.position,
          ),
        ],
      );
    }).toList(growable: false);
  }
}

class StaffTableDataSource extends DataGridSource {
  StaffTableDataSource({
    required this.certificateData,
  }) {
    _certificateData = certificateData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'កម្រិតសញ្ញាបត្រ',
            value: e.name,
          ),
          DataGridCell<int>(
            columnName: 'រាប់តែចំនួនសរុប',
            value: e.amount.toInt(),
          ),
        ],
      );
    }).toList();
  }

  final List<ChartModel> certificateData;
  List<DataGridRow> _certificateData = [];

  @override
  List<DataGridRow> get rows => _certificateData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              style: const TextStyle(
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
