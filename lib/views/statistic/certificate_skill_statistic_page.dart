import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CertificateSkillStatisticPage extends StatefulWidget {
  const CertificateSkillStatisticPage({Key? key}) : super(key: key);

  @override
  _CertificateSkillStatisticPageState createState() =>
      _CertificateSkillStatisticPageState();
}

class _CertificateSkillStatisticPageState
    extends State<CertificateSkillStatisticPage> {
  List<GenderData>? _chartData;

  @override
  void initState() {
    _chartData = getChatData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return certificateSkillChart();
  }
  Widget certificateSkillChart() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: SfCircularChart(
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
      },
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
