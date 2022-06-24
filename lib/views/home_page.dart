import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/custom_drawer.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/models/dashboard/today_work_period.dart';
import 'package:xiaoming/services/dashboard_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/id_card/id_card_page.dart';
import 'package:xiaoming/views/personal_info/user_info_page.dart';
import 'package:xiaoming/views/request_leave/request_leave_page.dart';
import 'package:xiaoming/views/statistic/pages/list_statistic_page.dart';

import 'attendance/attendance_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ប្រព័ន្ធព័ត៌មានមន្ត្រីរាជការ'),
          ),
          drawer: const CustomDrawer(),
          body: SafeArea(
            child: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(height: 8),
                    WorkHourChart(),
                    HomePageGridView(),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WorkHourChart extends StatefulWidget {
  const WorkHourChart({Key? key}) : super(key: key);

  @override
  State<WorkHourChart> createState() => _WorkHourChartState();
}

class _WorkHourChartState extends State<WorkHourChart> {
  final List<ChartData> chartData = [
    ChartData('David', 70, CompanyColors.blue),
    ChartData('Steve', 30, Colors.grey),
  ];
  final dashboardService = DashboardService();

  @override
  Widget build(BuildContext context) {
    // final TodayWorkPeriod todayWorkPeriod = TodayWorkPeriod(
    //   lastScan: "14:38:20",
    //   periodInHour: 6.9,
    // );
    // return donutChart(workPeriod: todayWorkPeriod);
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomFutureBuilder<TodayWorkPeriod?>(
        future: dashboardService.getTodayWorkPeriod(),
        onLoading: donutChart(workPeriod: null),
        onDataRetrieved: (context, result, connectionState) {
          return donutChart(workPeriod: result);
        },
      ),
    );
  }

  String stringToTimeOfDay(String tod) {
    final timeFormat = DateFormat('HH:mm:ss');
    final time = timeFormat.parse(tod);
    // return TimeOfDay.fromDateTime(time).format(context);
    //for 24 hour fomat
    return "${time.hour}:${time.minute}";
  }

  Widget donutChart({TodayWorkPeriod? workPeriod}) {
    final List<ChartData> defaultChartData = [
      ChartData('David', 0, CompanyColors.blue),
      ChartData('Steve', 100, Colors.grey),
    ];
    List<ChartData>? chartData;
    final String periodInHour = workPeriod?.periodInHour?.toString() ?? "0.0";
    final lastScanTime = (workPeriod?.lastScan == null)
        ? ""
        : stringToTimeOfDay(workPeriod?.lastScan ?? "");

    if (workPeriod != null) {
      final workHours = workPeriod.periodInHour ?? 0.0;
      final workHourPercentage = workHours * 100 / 7;
      final remainingPercentage = 100 - workHourPercentage;
      chartData = [
        ChartData(lastScanTime, workHourPercentage, CompanyColors.blue),
        ChartData("Total", remainingPercentage, Colors.grey),
      ];
      if (workHourPercentage >= 100 || remainingPercentage <= 0) {
        // final extra = workHours - 8;
        chartData = [
          ChartData(lastScanTime, 7, CompanyColors.blue),
          // ChartData("Extra", extra, Colors.green),
        ];
      }
    }

    return Stack(
      children: [
        const Positioned(
          top: 8,
          left: 8,
          child: Text(
            "រយះពេលធ្វើការ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'KhmerMPTC',
            ),
          ),
        ),
        Positioned.fill(
          bottom: 8,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "ម៉ោងស្កេនចុងក្រោយ $lastScanTime",
              style: const TextStyle(
                fontSize: 16,
                // fontFamily: 'KhmerOSBattambong',
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Stack(
            children: [
              Positioned.fill(
                top: 30,
                child: Center(
                  child: Text(
                    "${periodInHour}h",
                    style: TextStyle(
                      fontSize: 36,
                      color: CompanyColors.blue,
                    ),
                  ),
                ),
              ),
              SfCircularChart(
                title: ChartTitle(
                  text: "ថ្ងៃនេះ",
                  textStyle: const TextStyle(
                    fontFamily: 'KhmerMPTC',
                    fontSize: 16,
                  ),
                ),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData ?? defaultChartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.name,
                    yValueMapper: (ChartData data, _) => data.amount,
                    animationDuration: 300,
                    innerRadius: "80",
                    radius: "120",
                    endAngle: 120,
                    startAngle: 240,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final String name;
  final double amount;
  final Color color;

  ChartData(this.name, this.amount, this.color);
}

class HomePageGridView extends StatelessWidget {
  const HomePageGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: homePageItems.length,
      padding: const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => homePageItems[index].destination);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Icon(
                    homePageItems[index].icon,
                    size: 75,
                    color: CompanyColors.blue,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      homePageItems[index].title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 14,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 18,
                        color: CompanyColors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final List<_HomePageItem> homePageItems = [
  const _HomePageItem(
    title: "ព័ត៌មានផ្ទាល់ខ្លួន",
    icon: Icons.account_circle,
    destination: UserInfoPage(),
  ),
  const _HomePageItem(
    title: "វត្តមានផ្ទាល់ខ្លួន",
    icon: Icons.calendar_today,
    destination: AttendancePage(),
  ),
  const _HomePageItem(
    title: "ស្ថិតិ",
    icon: Icons.pie_chart,
    destination: ListStatisticPage(),
  ),
  const _HomePageItem(
    title: "ប័ណ្ណសម្គាល់ផ្ទាល់ខ្លួន",
    icon: Icons.badge_outlined,
    destination: IdCardPage(),
  ),
  const _HomePageItem(
    title: "ស្នើសុំច្បាប់",
    icon: Icons.event_note_rounded,
    destination: RequestLeavePage(),
  ),
];

class _HomePageItem {
  final String title;
  final IconData icon;
  final Widget destination;

  const _HomePageItem({
    required this.title,
    required this.icon,
    required this.destination,
  });
}
