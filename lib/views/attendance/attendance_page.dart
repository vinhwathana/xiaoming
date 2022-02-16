import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/models/attendance/attendance.dart';
import 'package:xiaoming/models/attendance/attendance_response.dart';
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
                "${formatDateTime(start)} - ${formatDateTime(end)}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attendanceView() {
    return FutureBuilder<AttendanceResponse?>(
      future: attendanceService.getPersonalAttendance(
        formatDateTime(start),
        formatDateTime(end),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return AttendanceCard(
                onTap: () {
                  Get.to(() => AttendanceDetail());
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AttendanceCard(
                    onTap: () {
                      Get.to(() => AttendanceDetail());
                    },
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    Key? key,
    this.attendance,
    required this.onTap,
  }) : super(key: key);

  final Attendance? attendance;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final rand = Random();
    return Card(
      elevation: 5,
      shadowColor: (rand.nextInt(2) == 0) ? CompanyColors.red : Colors.green,
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
                formatDateTime(now),
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                color: CompanyColors.yellow,
                // height: 3,
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ម៉ោងធ្វើការសរុប: 4ម៉ោង"),
                  Text("វត្តមានកន្លះថ្ងៃ"),
                ],
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
                          Text("12:26:25"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ព្រឹក(ស្កេនចេញ)"),
                          Text("12:26:25"),
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
                          Text("12:26:25"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ថ្ងៃ(ស្កេនចេញ)"),
                          Text("12:26:25"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Column(
              //       children: [
              //         Column(
              //           children: [
              //             Text("ព្រឹក(ស្កេនចូល)"),
              //             Text("12:26:25"),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Column(
              //           children: [
              //             Text("ព្រឹក(ស្កេនចេញ)"),
              //             Text("12:26:25"),
              //           ],
              //         ),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Column(
              //           children: [
              //             Text("ថ្ងៃ(ស្កេនចូល)"),
              //             Text("12:26:25"),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Column(
              //           children: [
              //             Text("ថ្ងៃ(ស្កេនចេញ)"),
              //             Text("12:26:25"),
              //           ],
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
