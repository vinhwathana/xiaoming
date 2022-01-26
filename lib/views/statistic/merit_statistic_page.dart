import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';

class MeritStatisticPage extends StatefulWidget {
  const MeritStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

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
      textStyle: TextStyle(
        fontFamily: 'KhmerOSBattambong',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return skillChart();
  }

  Widget skillChart() {
    return FutureBuilder<List<BarChartModel>?>(
      future: statService.getMerits("${widget.org}", "${widget.dept}"),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<BarChartModel>? meritData = snapshot.data;
          if (meritData == null || meritData.length == 0) {
            return Center(child: Text("No Data Available"));
          }
          double max = meritData[0].amount;
          meritData.forEach((element) {
            if (max < element.amount) {
              max = element.amount;
            }
          });
          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 3,
                  child: Container(
                    height: Get.height,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                          fontFamily: 'KhmerOSBattambong',
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        maximum: max,
                        labelFormat: '{value}',
                      ),
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<BarChartModel, String>>[
                        BarSeries(
                          name: "កម្រិតសញ្ញាបត្រ",
                          dataSource: meritData,
                          xValueMapper: (datum, index) => datum.name,
                          yValueMapper: (datum, index) => datum.amount,
                          pointColorMapper: (datum, index) => datum.color,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ),
                          enableTooltip: true,
                          animationDuration: 500,
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
                        certificateData: meritData,
                      ),
                      onQueryRowHeight: (details) {
                        return details.getIntrinsicRowHeight(details.rowIndex);
                      },
                      shrinkWrapRows: true,
                      verticalScrollPhysics: NeverScrollableScrollPhysics(),
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
                      columnWidthMode: ColumnWidthMode.fitByCellValue,
                      allowSorting: true,
                      sortingGestureType: SortingGestureType.tap,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
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

  final List<BarChartModel> certificateData;
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
