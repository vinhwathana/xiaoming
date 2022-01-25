import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/views/statistic/certificate_skill_statistic_page.dart';
import 'package:xiaoming/views/statistic/certificate_statistic_page.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<GenderData>? _chartData;

  String dept = "00";
  String org = "00";
  String degree = "P";

  final tabs = <Tab>[
    Tab(text: "កម្រិតសញ្ញាបត្រ និងជំនាញ"),
    Tab(text: "ជំនាញ"),
    Tab(text: "កម្រិតសញ្ញាបត្រ"),
    Tab(text: "ភេទ"),
    Tab(text: "ឥស្សរិយយស្ស"),
    Tab(text: "កាំបៀវត្ស"),
  ];

  @override
  void initState() {
    _chartData = getChatData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ស្ថិតិ'),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  FilterDialog(
                    showDegreeField: false,
                    onConfirm: (org, dept, degree) {
                      setState(() {
                        this.org = org;
                        this.dept = dept;
                        this.degree = degree;
                      });
                    },
                  ),
                  useSafeArea: true,
                  transitionCurve: Curves.ease,
                );
              },
              icon: Icon(Icons.filter_list),
            ),
          ],
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              CertificateSkillStatisticPage(),
              pieChart(),
              CertificateStatisticPage(
                org: org,
                dept: dept,
              ),
              pieChart(),
              pieChart(),
              pieChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pieChart() {
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

class GenderData {
  GenderData(this.male);
  final int male;
}
