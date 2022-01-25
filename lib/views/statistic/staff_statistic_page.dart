import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/services/statistic_service.dart';

class StaffStatisticPage extends StatefulWidget {
  const StaffStatisticPage({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  _StaffStatisticPageState createState() => _StaffStatisticPageState();
}

class _StaffStatisticPageState extends State<StaffStatisticPage> {
  // List<StaffData>? _chartData;
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();
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
    return certificateSkillChart();
  }

  Widget certificateSkillChart() {
    return FutureBuilder<List<StaffData>?>(
      future: statService.getStaffCount(widget.org, widget.dept),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final staffData = snapshot.data;
        if(staffData == null || staffData.length == 0){
          return Center(child: Text("No Data Available"));
        }

        return Column(
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
                    PieSeries<StaffData, dynamic>(
                      dataSource: staffData,
                      xValueMapper: (datum, index) => datum.gender,
                      yValueMapper: (StaffData data, _) => data.amount,
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
            Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      staffData[0].amount.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      staffData[1].amount.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      (staffData[0].amount + staffData[1].amount).toString(),
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }

  // List<StaffData> getChatData() {
  //   final List<StaffData> chartData = [
  //     StaffData("ប្រុស", 12, Colors.green),
  //     StaffData("ស្រី", 23, Colors.deepPurpleAccent),
  //   ];
  //   return chartData;
  // }
}

class StaffData {
  const StaffData(this.gender, this.amount, this.color);

  final String gender;
  final int amount;
  final Color color;
}
