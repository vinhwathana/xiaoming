import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'certificate_statistic_page.dart';

class SkillByDegreeStatisticPage extends StatefulWidget {
  const SkillByDegreeStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);
  final String dept;
  final String org;

  @override
  _SkillByDegreeStatisticPageState createState() =>
      _SkillByDegreeStatisticPageState();
}

class _SkillByDegreeStatisticPageState
    extends State<SkillByDegreeStatisticPage> {
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
    return Container(
      child: Center(child: Text("In Development")),
    );
  }

  Widget certificateSkillChart() {
    return FutureBuilder<List<CertificateData>?>(
      future: statService.getCertificates("${widget.org}", "${widget.dept}"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<CertificateData>? certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return Center(child: Text("No Data Available"));
          }
          int max = certificateData[0].numberOfCertificate;
          certificateData.forEach((element) {
            if (max < element.numberOfCertificate) {
              max = element.numberOfCertificate;
            }
          });
          return Column(
            children: [
              Card(
                margin: EdgeInsets.all(8),
                elevation: 3,
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
                  series: <BarSeries<CertificateData, String>>[
                    BarSeries(
                      name: "កម្រិតសញ្ញាបត្រ",
                      dataSource: certificateData,
                      xValueMapper: (datum, index) => datum.certificateName,
                      yValueMapper: (datum, index) => datum.numberOfCertificate,
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
              Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    sortIconColor: Colors.black,
                  ),
                  child: SfDataGrid(
                    source: TableDataSource(
                      certificateData: certificateData,
                    ),
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
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
