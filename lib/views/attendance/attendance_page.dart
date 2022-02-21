import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/models/attendance/attendance.dart';
import 'package:xiaoming/models/attendance/personal_attendance_range_response.dart';
import 'package:xiaoming/services/attendance_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/attendance/attendance_detail.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final attendanceService = AttendanceService();

  final now = DateTime.now();
  late DateTime start = now.subtract(Duration(days: 1));
  late DateTime end = now;

  void pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: now,
      locale: Get.locale,
      currentDate: now,
      initialDateRange: DateTimeRange(
        start: start,
        end: end,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  toolbarHeight: 100,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      print(picked);
      setState(() {
        start = picked.start;
        end = picked.end;
      });
    }
  }

  Widget topTitle() {
    return Card(
      // elevation: 3,
      shadowColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ចាប់ពីថ្ងៃទី - ដល់ថ្ងៃទី",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                pickDateRange();
              },
              child: Text(
                "${formatDateTimeForView(start)} - ${formatDateTimeForView(end)}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attendanceView() {
    return FutureBuilder<List<Attendance>?>(
      future: attendanceService.getPersonalAttendanceRange(
        formatDateTimeForApi(start),
        formatDateTimeForApi(end),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final List<Attendance>? attendances = snapshot.data;

          if (attendances == null || attendances.length == 0) {
            return Center(child: Text("No Information Available"));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: attendances.length,
            itemBuilder: (context, index) {
              return AttendanceCard(
                attendance: attendances[index],
                onTap: () {
                  Get.to(
                    () => AttendanceDetail(
                      attendance: attendances[index],
                    ),
                  );
                },
              );
            },
          );
        }
        return Center(
          child: Text("No Information Available"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("វត្តមានផ្ទាល់ខ្លួន"),
        actions: [
          IconButton(
            onPressed: () {
              pickDateRange();
            },
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTitle(),
              attendanceView(),
              // dummyAttendanceView(),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dummyAttendanceView() {
    final List<Attendance> dummyAttendances = [
      Attendance(
        timeRuleId: 1,
        authDate: DateTime.parse("2022-01-03"),
        morningCheckIn: "12:12:12",
        morningCheckOut: "12:12:12",
        afternoonCheckIn: "12:12:12",
        afternoonCheckOut: "12:12:12",
        periodInHour: 4.1,
        attendanceStatus: "វត្តមានពេញល្អប្រសើរ",
      ),
      Attendance(
        timeRuleId: 1,
        authDate: DateTime.parse("2022-01-03"),
        morningCheckIn: "12:12:12",
        morningCheckOut: "12:12:12",
        afternoonCheckIn: "12:12:12",
        afternoonCheckOut: "12:12:12",
        periodInHour: 7.1,
        attendanceStatus: "វត្តមាន",
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dummyAttendances.length,
      itemBuilder: (context, index) {
        return AttendanceCard(
          attendance: dummyAttendances[index],
          onTap: () {
            Get.to(() => AttendanceDetail(
                  attendance: dummyAttendances[index],
                ));
          },
        );
      },
    );
  }
}

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    Key? key,
    required this.attendance,
    required this.onTap,
  }) : super(key: key);

  final Attendance attendance;
  final Function() onTap;

  Color determineShadowColor(String status) {
    switch (status) {
      case "វត្តមានពេញល្អប្រសើរ":
        return Colors.green;
      case "វត្តមានពេញ":
        return Colors.green;
      case "វត្តមានកន្លះថ្ងៃ":
        return Colors.yellow;
      case "អវត្តមាន":
        return Colors.red;
      case "អវត្តមានកន្លះថ្ងៃ":
        return Colors.yellow;
      case "មានច្បាប់":
        return Colors.blue;
      case "បេសកកម្ម":
        return Colors.purple;
      default:
        return CompanyColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now();
    // final rand = Random();
    return Card(
      elevation: 6,
      shadowColor: determineShadowColor(
        attendance.attendanceStatus,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(8),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDateTimeForView(attendance.authDate),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: CompanyColors.yellow,
                // height: 3,
                thickness: 1.5,
              ),
              SizedBox(
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 8,
                  children: [
                    Text(
                      "ម៉ោងធ្វើការសរុប: ${attendance.periodInHour}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "វត្តមានកន្លះថ្ងៃ: ${attendance.attendanceStatus}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: CompanyColors.yellow,
                // height: 3,
                thickness: 1.5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("ព្រឹក(ស្កេនចូល)"),
                          Text(attendance.morningCheckIn),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ព្រឹក(ស្កេនចេញ)"),
                          Text(attendance.morningCheckOut),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("ថ្ងៃ(ស្កេនចូល)"),
                          Text(attendance.afternoonCheckIn),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ថ្ងៃ(ស្កេនចេញ)"),
                          Text(attendance.afternoonCheckOut),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
