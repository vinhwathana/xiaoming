import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class StaffStatisticPage extends StatefulWidget {
  const StaffStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  _StaffStatisticPageState createState() => _StaffStatisticPageState();
}

class _StaffStatisticPageState extends State<StaffStatisticPage> with AutomaticKeepAliveClientMixin {
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
      textStyle: TextStyle(
        fontFamily: 'KhmerOSBattambong',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return certificateSkillChart();
  }

  Widget certificateSkillChart() {
    return FutureBuilder<List<PieChartModel>?>(
      future: statService.getStaffCount(widget.org, widget.dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final staffData = snapshot.data;
        if (staffData == null || staffData.length == 0) {
          return Center(child: Text("No Data Available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  width: Get.width,
                  height: Get.height / 2,
                  child: SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<PieChartModel, dynamic>(
                        dataSource: staffData,
                        xValueMapper: (datum, index) => datum.name,
                        yValueMapper: (PieChartModel data, _) => data.amount.toInt(),
                        pointColorMapper: (datum, index) => datum.color,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        enableTooltip: true,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    sortIconColor: Colors.black,
                  ),
                  child: SfDataGrid(
                    source: TableDataSource(
                      certificateData: staffData ?? [],
                    ),
                    onQueryRowHeight: (details) {
                      return details.getIntrinsicRowHeight(details.rowIndex);
                    },
                    shrinkWrapRows: true,
                    verticalScrollPhysics: NeverScrollableScrollPhysics(),
                    horizontalScrollPhysics: NeverScrollableScrollPhysics(),
                    columns: List.generate(headerTitles.length, (index) {
                      return GridColumn(
                        columnName: '${headerTitles[index]}',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${headerTitles[index]}',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "KhmerOSBattambong",
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                        allowSorting: true,
                      );
                    }),
                    columnWidthMode: ColumnWidthMode.auto,
                    allowSorting: true,
                    sortingGestureType: SortingGestureType.tap,
                  ),
                ),
              ),
              // Divider(),
              // Container(
              //   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'ប្រុស',
              //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //       ),
              //       Text(
              //         'ស្រី',
              //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //       ),
              //       Text(
              //         'សរុប',
              //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //       )
              //     ],
              //   ),
              // ),
              // Card(
              //   elevation: 3,
              //   margin: EdgeInsets.all(8),
              //   child: Container(
              //     padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           staffData[0].amount.toInt().toString(),
              //           style: TextStyle(fontSize: 16),
              //         ),
              //         Text(
              //           staffData[1].amount.toInt().toString(),
              //           style: TextStyle(fontSize: 16),
              //         ),
              //         Text(
              //           (staffData[0].amount + staffData[1].amount).toInt().toString(),
              //           style: TextStyle(fontSize: 16),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Divider(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TableDataSource extends DataGridSource {
  TableDataSource({
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

  final List<PieChartModel> certificateData;
  List<DataGridRow> _certificateData = [];

  @override
  List<DataGridRow> get rows => _certificateData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
            (dataGridCell) {
          return Container(
            padding: EdgeInsets.all(12.0),
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


