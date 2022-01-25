import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/components/mptc_profile_item.dart';
import 'package:xiaoming/services/statistic_service.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<GenderData>? _chartData;
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();
  String dept = "00";
  String org = "00";

  @override
  void initState() {
    _chartData = getChatData();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ស្ថិតិ:កម្រិតសញ្ញាបត្រ'),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                FilterDialog(
                  onChange: () {},
                ),
                useSafeArea: true,
                transitionCurve: Curves.easeInOut,
              );
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SafeArea(
        child: barChart(),
      ),
    );
  }



  Widget barChart() {
    return FutureBuilder<List<CertificateData>?>(
      future: statService.getCertificates("$org", "$dept"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return Text("No Data");
          }
          int max = certificateData[0].numberOfCertificate;
          certificateData.forEach((element) {
            if (max < element.numberOfCertificate) {
              max = element.numberOfCertificate;
            }
          });
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              maximum: max.toDouble(),
              labelFormat: '{value}',
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <BarSeries<CertificateData, String>>[
              BarSeries(
                name: "NameOfSeries",
                dataSource: certificateData,
                xValueMapper: (datum, index) => datum.certificateName,
                yValueMapper: (datum, index) => datum.numberOfCertificate,
                pointColorMapper: (datum, index) => datum.color,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                ),
                enableTooltip: true,
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

  List<CertificateData> barSeries() {
    return [
      CertificateData('Jan', 12, Colors.red),
      CertificateData('Feb', 23, Colors.black),
      CertificateData('Mar', 34, Colors.amberAccent),
      CertificateData('Apr', 45, Colors.cyanAccent),
      CertificateData('Jun', 56, Colors.greenAccent),
      CertificateData('Jul', 67, Colors.purpleAccent),
    ];
  }

  Widget pieChartWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: SfCircularChart(
            // title: ChartTitle(text: 'ភេទ',
            // textStyle: TextStyle(fontWeight: FontWeight.bold)),
            //legend: Legend(isVisible: true,),
            // tooltipBehavior: _tooltipBehavior,
            palette: [Colors.pink, Colors.blue],
            series: <CircularSeries>[
              PieSeries<GenderData, int>(
                  dataSource: _chartData,
                  xValueMapper: (GenderData data, _) => data.male,
                  yValueMapper: (GenderData data, _) => data.male,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  enableTooltip: true),
            ],
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ប្រុស',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'ស្រី',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'សរុប',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '934',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '459',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '1393',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  List<GenderData> getChatData() {
    final List<GenderData> chartData = [
      GenderData(459),
      GenderData(934),
    ];
    return chartData;
  }
}

class CertificateData {
  const CertificateData(
    this.certificateName,
    this.numberOfCertificate,
    this.color,
  );

  final String certificateName;
  final int numberOfCertificate;
  final Color color;
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);

  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}

class GenderData {
  GenderData(this.male);

  final int male;
}
