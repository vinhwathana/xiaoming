import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';

class CertificateStatisticPage extends StatefulWidget {
  const CertificateStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
    required this.chartTitle,
  }) : super(key: key);

  final String dept;
  final String org;
  final String chartTitle;

  @override
  _CertificateStatisticPageState createState() =>
      _CertificateStatisticPageState();
}

class _CertificateStatisticPageState extends State<CertificateStatisticPage>
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
    return certificateSkillChart();
  }

  Widget certificateSkillChart() {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getCertificates(widget.org, widget.dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          double max = certificateData[0].amount;
          for (var element in certificateData) {
            if (max < element.amount) {
              max = element.amount;
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  child: SizedBox(
                    height: Get.height / 2,
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
                          dataSource: certificateData,
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
                ),
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(8),
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
                      verticalScrollPhysics:
                          const NeverScrollableScrollPhysics(),
                      horizontalScrollPhysics:
                          const NeverScrollableScrollPhysics(),
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

  @override
  bool get wantKeepAlive => true;
}
