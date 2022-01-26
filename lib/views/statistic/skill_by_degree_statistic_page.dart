import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';
import 'certificate_statistic_page.dart';

final List<String> headerTitles = [
  "ជំនាញ",
  "រាប់តែចំនួនសរុប",
];

class SkillByDegreeStatisticPage extends StatefulWidget {
  const SkillByDegreeStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
    required this.degree,
  }) : super(key: key);
  final String dept;
  final String org;
  final String degree;

  @override
  _SkillByDegreeStatisticPageState createState() =>
      _SkillByDegreeStatisticPageState();
}

class _SkillByDegreeStatisticPageState extends State<SkillByDegreeStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();

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
    return skillByDegreeChart();
  }

  Widget skillByDegreeChart() {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getSkillByDegree(
        widget.org,
        widget.dept,
        widget.degree,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return Center(child: Text("No Data Available"));
          }
          double max = certificateData[0].amount;
          certificateData.forEach((element) {
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
                    height: Get.height / 2,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                          fontFamily: 'KhmerOSBattambong',
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        maximum: max.toDouble(),
                        labelFormat: '{value}',
                      ),
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<ChartModel, String>>[
                        BarSeries(
                          name: "កម្រិតសញ្ញាបត្រ និង ជំនាញ",
                          dataSource: certificateData,
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
                      source: TwoColumnDataGridSource(
                        tableData: certificateData,
                        firstColumnName: headerTitles[0],
                        secondColumnName: headerTitles[1],
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
                          columnWidthMode: ColumnWidthMode.auto,
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
