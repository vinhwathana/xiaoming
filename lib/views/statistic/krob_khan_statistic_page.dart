import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/views/statistic/statistics_page.dart';

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

class _KrobKhanStatisticPageState extends State<KrobKhanStatisticPage> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return krobKhanChart();
  }

  Widget krobKhanChart() {
    return FutureBuilder<List<PieChartModel>?>(
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
                      PieSeries<PieChartModel, dynamic>(
                        dataSource: krobKhanData,
                        xValueMapper: (datum, index) => datum.name,
                        yValueMapper: (PieChartModel data, _) => data.amount.toInt(),
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
                      'កាំបៀវត្ស',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'រាប់តែចំនួនសរុប',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: krobKhanData.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            krobKhanData[index].name,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            krobKhanData[index].amount.toInt().toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}


