import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/views/statistic/statistics_page_wrapper.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class KrobKhanStatisticPage extends StatefulWidget {
  const KrobKhanStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
    required this.chartTitle,
  }) : super(key: key);

  final String dept;
  final String org;
  final String chartTitle;

  @override
  _KrobKhanStatisticPageState createState() => _KrobKhanStatisticPageState();
}

class _KrobKhanStatisticPageState extends State<KrobKhanStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();

  final List<String> headerTitles = [
    "កាំបៀវត្ស",
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
    return krobKhanChart();
  }

  Widget krobKhanChart() {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getKrobKhans(widget.org, widget.dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final krobKhanData = snapshot.data;
        if (krobKhanData == null || krobKhanData.isEmpty) {
          return const Center(child: Text("No Data Available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                        fontFamily: 'KhmerOSBattambong',
                      ),
                    ),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<ChartModel, dynamic>(
                        name: widget.chartTitle,
                        dataSource: krobKhanData,
                        xValueMapper: (datum, index) => datum.name,
                        yValueMapper: (ChartModel data, _) =>
                            data.amount.toInt(),
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
                      tableData: krobKhanData,
                      firstColumnName: headerTitles[0],
                      secondColumnName: headerTitles[1],
                    ),
                    shrinkWrapRows: true,
                    verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                    horizontalScrollPhysics:
                        const NeverScrollableScrollPhysics(),
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
