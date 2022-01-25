//using tabbar to display personal information
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/components/custom_drawer.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
        title: Center(
          child: Text(
            '',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SfCircularChart(
                title: ChartTitle(
                    text: 'Gender',
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
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
                    'Male',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Female',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Total',
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
        ),
      ),
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
