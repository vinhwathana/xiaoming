import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/components/loading_widget.dart';
import 'package:xiaoming/models/statistic/number/staff_statistic.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/statistic/utils/custom_data_grid_filter.dart';
import 'package:xiaoming/views/statistic/utils/custom_pie_series.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';

import '../utils/custom_grid_column.dart';

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
        fontFamily: khmerFont,
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
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getStaffCount(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final staffData = data;
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
                fontFamily: khmerFont,
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
                fontFamily: khmerFont,
              ),
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              CustomPieSeries<ChartModel, dynamic>(
                chartTitle: widget.chartTitle,
                dataSource: staffData,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget staffDataGrid(String org, String dept) {
    return CustomFutureBuilder<StaffStatistic?>(
      future: statService.getStaffCountByGender(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final staffData = data;
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
                  return CustomGridColumn(
                    columnName: headerTitles[index],
                  );
                },
              ),
              columnWidthMode: ColumnWidthMode.fill,
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

class _StaffPeopleDataGridState extends State<StaffPeopleDataGrid>
    with AutomaticKeepAliveClientMixin {
  // bool isLoading = false;
  final statService = StatisticService();
  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខតំណែង',
  ];
  int rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder<StatisticPeopleResponse?>(
      future: statService.getStaffPeople(
        widget.org,
        widget.dept,
        start: start,
        length: rowsPerPage,
        search: "",
      ),
      onDataRetrieved: (context, data, connectionState) {
        final responseData = data;
        final List<StatisticPeople>? skillPeopleData = responseData?.data;

        return SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomDataGridWidget(
                topWidget: CustomDataGridFilter(
                  rowsPerPage: rowsPerPage,
                  onChange: (value) {
                    if (value != rowsPerPage) {
                      setState(() {
                        rowsPerPage = int.parse(value.toString());
                      });
                    }
                  },
                ),
                dataSource: StaffPeopleDataGridSource(
                  tableData: skillPeopleData ?? [],
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
                visible: (connectionState == ConnectionState.waiting),
                child: const LoadingWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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
    'មុខតំណែង',
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
                fontFamily: khmerFont,
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
                fontFamily: khmerFont,
                height: 1.5,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}