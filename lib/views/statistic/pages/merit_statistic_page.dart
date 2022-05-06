import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/statistic/utils/custom_data_grid_filter.dart';
import 'package:xiaoming/views/statistic/utils/people_statistic_data_grid.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';
import 'package:xiaoming/views/statistic/utils/custom_bar_series.dart';
import 'package:xiaoming/views/statistic/utils/custom_grid_column.dart';

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
    "ឥស្សរិយយស្ស",
    "រាប់តែចំនួនសរុប",
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
            meritChart(org, dept),
            meritDataGrid(org, dept),
            meritPeopleDataGrid(org, dept),
          ],
        );
      },
    );
  }

  Widget meritChart(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getMerits(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? meritData = data;
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
          child: SfCartesianChart(
            title: ChartTitle(
              text: widget.chartTitle,
              textStyle: const TextStyle(
                fontFamily: khmerFont,
              ),
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(
                fontFamily: khmerFont,
              ),
            ),
            primaryYAxis: NumericAxis(
              maximum: max,
              labelFormat: '{value}',
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CustomBarSeries<ChartModel, String>>[
              CustomBarSeries(
                chartTitle: widget.chartTitle,
                dataSource: meritData,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget meritDataGrid(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getMerits(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? meritData = data;
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: SfDataGrid(
              source: TwoColumnDataGridSource(
                tableData: meritData ?? [],
                firstColumnName: headerTitles[0],
                secondColumnName: headerTitles[1],
              ),
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

class _MeritPeopleDataGridState extends State<MeritPeopleDataGrid>
    with AutomaticKeepAliveClientMixin {
  // bool isLoading = false;
  final statService = StatisticService();
  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខតំណែង',
    'អគ្គនាយកដ្ឋាន',
    'នាយកដ្ឋាន',
    'ប្រភេទគឿងឥស្សរិយយស្ស',
    'កាលបរិច្ឆេទទទួល',
  ];
  int rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder<StatisticPeopleResponse?>(
      future: statService.getMeritPeople(
        widget.org,
        widget.dept,
        start: start,
        length: rowsPerPage,
        search: "",
      ),
      onDataRetrieved: (context, data, connectionState) {
        final responseData = data;
        final List<StatisticPeople>? meritPeopleData = responseData?.data;

        return PeopleStatisticDataGrid(
          dataGridSource: MeritPeopleDataGridSource(
            tableData: meritPeopleData ?? [],
          ),
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
          headerTitle: peopleHeaderTitles,
          rowsPerPage: rowsPerPage,
          totalAmount: responseData?.totalFilteredRecord,
          selectedPage: selectedPage,
          start: start,
          onChangePage: (index) {
            int tempStart = start;
            tempStart = rowsPerPage * (index);
            setState(() {
              if (tempStart >= 0) {
                start = tempStart;
              }
              selectedPage = index;
            });
          },
          connectionState: connectionState,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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
    'មុខតំណែង',
    'អគ្គនាយកដ្ឋាន',
    'នាយកដ្ឋាន',
    'ប្រភេទគឿងឥស្សរិយយស្ស',
    'កាលបរិច្ឆេទទទួល',
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
              (dataGridCell.value == null) ? "" : dataGridCell.value.toString(),
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
          DataGridCell<String>(
            columnName: peopleHeaderTitles[4],
            value: e.org,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[5],
            value: e.dept,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[6],
            value: e.meritName,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[7],
            value: e.recievedDate,
          ),
        ],
      );
    }).toList(growable: false);
  }
}
