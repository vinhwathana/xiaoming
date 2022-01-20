import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/components/mptc_profile_item.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<GenderData>? _chartData;
  late final TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChatData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ស្ថិតិ'),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(FiltersDialog());
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SafeArea(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <BarSeries<CertificateData, String>>[
            BarSeries(
              dataSource: <CertificateData>[
                CertificateData('Jan', 12, Colors.red),
                CertificateData('Feb', 23, Colors.black),
                CertificateData('Mar', 34, Colors.amberAccent),
                CertificateData('Apr', 45, Colors.cyanAccent),
                CertificateData('Jun', 56, Colors.greenAccent),
                CertificateData('Jul', 67, Colors.purpleAccent),
              ],
              xValueMapper: (datum, index) => datum.certificateName,
              yValueMapper: (datum, index) => datum.numberOfCertificate,
              pointColorMapper: (datum, index) => datum.color,
              // dataLabelMapper: (datum, index) => index.T,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
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
            tooltipBehavior: _tooltipBehavior,
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
  CertificateData(this.certificateName, this.numberOfCertificate, this.color);

  final String certificateName;
  final double numberOfCertificate;
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
