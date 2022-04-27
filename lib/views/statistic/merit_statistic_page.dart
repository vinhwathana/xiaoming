import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/views/statistic/statistics_page_wrapper.dart';

class MeritStatisticPage extends StatefulWidget {
  const MeritStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);

  final String chartTitle;

  @override
  _MeritStatisticPageState createState() => _MeritStatisticPageState();
}

class _MeritStatisticPageState extends State<MeritStatisticPage>
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
            meritChart(org, dept),
            meritDataGrid(org, dept),
            meritPeopleDataGrid(org, dept),
          ],
        );
      },
    );
  }

  Widget meritChart(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getMerits(org, dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? meritData = snapshot.data;
          if (meritData == null || meritData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          double max = meritData[0].amount;
          for (var element in meritData) {
            if (max < element.amount) {
              max = element.amount;
            }
          }
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 3,
            child: SizedBox(
              height: Get.height,
              child: SfCartesianChart(
                title: ChartTitle(
                  text: widget.chartTitle,
                  textStyle: const TextStyle(
                    fontFamily: 'KhmerOSBattambong',
                  ),
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(
                    fontFamily: 'KhmerOSBattambong',
                  ),
                ),
                primaryYAxis: NumericAxis(
                  maximum: max,
                  labelFormat: '{value}',
                ),
                tooltipBehavior: _tooltipBehavior,
                series: <BarSeries<ChartModel, String>>[
                  BarSeries(
                    name: widget.chartTitle,
                    dataSource: meritData,
                    xValueMapper: (datum, index) => datum.name,
                    yValueMapper: (datum, index) => datum.amount,
                    pointColorMapper: (datum, index) => datum.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    enableTooltip: true,
                    animationDuration: 500,
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget meritDataGrid(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getMerits(org, dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? meritData = snapshot.data;
          if (meritData == null || meritData.length == 0) {
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
                source: TwoColumnDataGridSource(
                  tableData: meritData,
                  firstColumnName: headerTitles[0],
                  secondColumnName: headerTitles[1],
                ),
                horizontalScrollPhysics: NeverScrollableScrollPhysics(),
                columns: List.generate(
                  headerTitles.length,
                  (index) {
                    return GridColumn(
                      columnName: headerTitles[index],
                      columnWidthMode: ColumnWidthMode.auto,
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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget meritPeopleDataGrid(String org, String dept) {
    return MeritPeopleDataGrid(
      org: org,
      dept: dept,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MeritPeopleDataGrid extends StatefulWidget {
  const MeritPeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  State<MeritPeopleDataGrid> createState() => _MeritPeopleDataGridState();
}

class _MeritPeopleDataGridState extends State<MeritPeopleDataGrid> {
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
          final List<StatisticPeople>? skillPeopleData = responseData?.data;
          if (skillPeopleData == null || skillPeopleData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomDataGridWidget(
                  dataSource: MeritPeopleDataGridSource(
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

class MeritPeopleDataGridSource extends DataGridSource {
  MeritPeopleDataGridSource({
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
