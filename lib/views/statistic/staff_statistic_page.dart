import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/loading_widget.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/models/statistic/number/staff_statistic.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/utils/constant.dart';
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
    "ប្រុស",
    "ស្រី",
    'សរុប',
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
              isResponsive: true,
              overflowMode: LegendItemOverflowMode.wrap,
              iconHeight: 24,
              iconWidth: 24,
              alignment: ChartAlignment.center,
              textStyle: const TextStyle(
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
        );
      },
    );
  }

  Widget staffDataGrid(String org, String dept) {
    return FutureBuilder<StaffStatistic?>(
      future: statService.getStaffCountByGender(org, dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final staffData = snapshot.data;
        if (staffData == null) {
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
                staffStatisticData: [staffData],
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
  int rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatisticPeopleResponse?>(
      future: statService.getStaffPeople(
        widget.org,
        widget.dept,
        start: start,
        length: rowsPerPage,
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
                  topWidget: customTopChartWidget(),
                  dataSource: StaffPeopleDataGridSource(
                    tableData: skillPeopleData,
                  ),
                  headerTitles: peopleHeaderTitles,
                  bottomWidget: DataGridPager(
                    rowsPerPage: rowsPerPage,
                    totalAmount: responseData?.totalFilteredRecord ?? 0,
                    selectedPage: selectedPage,
                    onChange: (index) {
                      int tempStart = start;
                      tempStart = rowsPerPage * (index);
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
                  child: const LoadingWidget(),
                ),
              ],
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }
  Widget customTopChartWidget() {
    return ExpansionTile(
      title: const Text(
        "ច្រោះព័ត៌មាន",
        style: TextStyle(fontSize: 18),
      ),
      leading: Icon(
        Icons.filter_list,
        color: CompanyColors.yellowPrimaryValue,
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        Row(
          children: [
            const Text(
              "Show : ",
              style: TextStyle(
                color: Colors.black,
                height: 1.5,
              ),
            ),
            DropdownButton(
              underline: null,
              isDense: false,
              itemHeight: 50,
              value: rowsPerPage,
              items: typeOfEntries.map((e) {
                return DropdownMenuItem<int>(
                  value: e,
                  child: Text(
                    e.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != rowsPerPage) {
                  setState(() {
                    rowsPerPage = int.parse(value.toString());
                  });
                }
              },
            ),
            const Text(
              " entries ",
              style: TextStyle(
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StaffPeopleDataGridSource extends DataGridSource {
  StaffPeopleDataGridSource({
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
    required this.staffStatisticData,
  }) {
    _staffStatisticData = staffStatisticData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<int>(
            columnName: 'ប្រុស',
            value: (int.parse(e.total) - int.parse(e.female)),
          ),
          DataGridCell<int>(
            columnName: 'ស្រី',
            value: int.parse(e.female),
          ),
          DataGridCell<int>(
            columnName: 'សរុប',
            value: int.parse(e.total),
          ),
        ],
      );
    }).toList();
  }

  final List<StaffStatistic> staffStatisticData;
  List<DataGridRow> _staffStatisticData = [];

  @override
  List<DataGridRow> get rows => _staffStatisticData;

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
