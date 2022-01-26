import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class KrobKhanStatisticPage extends StatefulWidget {
  const KrobKhanStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

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
      textStyle: TextStyle(
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final krobKhanData = snapshot.data;
        if (krobKhanData == null || krobKhanData.length == 0) {
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
                      PieSeries<ChartModel, dynamic>(
                        dataSource: krobKhanData,
                        xValueMapper: (datum, index) => datum.name,
                        yValueMapper: (ChartModel data, _) =>
                            data.amount.toInt(),
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
                    source: TwoColumnDataGridSource(
                      tableData: krobKhanData,
                      firstColumnName: headerTitles[0],
                      secondColumnName: headerTitles[1],
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
