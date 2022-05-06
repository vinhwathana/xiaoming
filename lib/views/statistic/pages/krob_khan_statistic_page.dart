import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/statistic/utils/custom_data_grid_filter.dart';
import 'package:xiaoming/views/statistic/utils/custom_grid_column.dart';
import 'package:xiaoming/views/statistic/utils/people_statistic_data_grid.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';
import 'package:xiaoming/views/statistic/utils/custom_pie_series.dart';

class KrobKhanStatisticPage extends StatefulWidget {
  const KrobKhanStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);

  final String chartTitle;

  @override
  _KrobKhanStatisticPageState createState() => _KrobKhanStatisticPageState();
}

class _KrobKhanStatisticPageState extends State<KrobKhanStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();

  final List<String> headerTitles = [
    "ក្របខណ្ឌ",
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
            krobKhanChart(org, dept),
            krobKhanDataGrid(org, dept),
            krobKhanPeopleDataGrid(org, dept),
          ],
        );
      },
    );
  }

  Widget krobKhanChart(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getKrobKhans(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final krobKhanData = data;
        if (krobKhanData == null || krobKhanData.isEmpty) {
          return const Center(child: Text("No Data Available"));
        }

        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfCircularChart(
            title: ChartTitle(
              text: widget.chartTitle,
              textStyle: const TextStyle(
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
                dataSource: krobKhanData,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget krobKhanDataGrid(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getKrobKhans(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final krobKhanData = data;
        // if (krobKhanData == null || krobKhanData.isEmpty) {
        //   return const Center(child: Text("No Data Available"));
        // }

        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: SfDataGrid(
              source: TwoColumnDataGridSource(
                tableData: krobKhanData ?? [],
                firstColumnName: headerTitles[0],
                secondColumnName: headerTitles[1],
              ),
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

  Widget krobKhanPeopleDataGrid(String org, String dept) {
    return KrobKhanPeopleDataGrid(org: org, dept: dept);
  }

  @override
  bool get wantKeepAlive => true;
}

class KrobKhanPeopleDataGrid extends StatefulWidget {
  const KrobKhanPeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  State<KrobKhanPeopleDataGrid> createState() => _KrobKhanPeopleDataGridState();
}

class _KrobKhanPeopleDataGridState extends State<KrobKhanPeopleDataGrid>
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
    'ក្របខណ្ឌ',
  ];
  int rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder<StatisticPeopleResponse?>(
      future: statService.getKrobKhanPeople(
        widget.org,
        widget.dept,
        start: start,
        length: rowsPerPage,
        search: "",
      ),
      onDataRetrieved: (context, data, connectionState) {
        final responseData = data;
        final List<StatisticPeople>? krobKhanPeopleData = responseData?.data;

        return PeopleStatisticDataGrid(
          dataGridSource: KrobKhanPeopleDataGridSource(
            tableData: krobKhanPeopleData ?? [],
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

class KrobKhanPeopleDataGridSource extends DataGridSource {
  KrobKhanPeopleDataGridSource({
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
    'ក្របខណ្ឌ',
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
            value: e.krobKhanTypeName,
          ),
        ],
      );
    }).toList(growable: false);
  }
}