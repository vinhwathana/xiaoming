import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';

class SkillStatisticPage extends StatefulWidget {
  const SkillStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
    required this.chartTitle,
  }) : super(key: key);

  final String dept;
  final String org;
final String chartTitle;

  @override
  _SkillStatisticPageState createState() => _SkillStatisticPageState();
}

class _SkillStatisticPageState extends State<SkillStatisticPage>
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
    return skillChart();
  }

  Widget skillChart() {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getSkills(widget.org, widget.dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? skillData = snapshot.data;
          if (skillData == null || skillData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          double max = skillData[0].amount;
          for (var element in skillData) {
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
                    height: Get.height / 1.5,
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
                          dataSource: skillData,
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
                        tableData: skillData,
                        firstColumnName: headerTitles[0],
                        secondColumnName: headerTitles[1],
                      ),
                      onQueryRowHeight: (details) {
                        return details.getIntrinsicRowHeight(details.rowIndex);
                      },
                      shrinkWrapRows: true,
                      verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                      horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
                      columns: List.generate(headerTitles.length, (index) {
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

// class TableDataSource extends DataGridSource {
//   TableDataSource({
//     required this.certificateData,
//   }) {
//     _certificateData = certificateData.map<DataGridRow>((e) {
//       return DataGridRow(
//         cells: [
//           DataGridCell<String>(
//             columnName: 'កម្រិតសញ្ញាបត្រ',
//             value: e.name,
//           ),
//           DataGridCell<int>(
//             columnName: 'រាប់តែចំនួនសរុប',
//             value: e.amount.toInt(),
//           ),
//         ],
//       );
//     }).toList();
//   }
//
//   final List<BarChartModel> certificateData;
//   List<DataGridRow> _certificateData = [];
//
//   @override
//   List<DataGridRow> get rows => _certificateData;
//
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//       cells: row.getCells().map<Widget>(
//         (dataGridCell) {
//           return Container(
//             padding: EdgeInsets.all(12.0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               dataGridCell.value.toString(),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: 'KhmerOSBattambong',
//                 height: 1.5,
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }
// }
