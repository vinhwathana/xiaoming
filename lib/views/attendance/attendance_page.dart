import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/models/attendance/attendance.dart';
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

  // final now = DateTime(2022, 4, 26);
  late DateTime start = validateDate(now.subtract(const Duration(days: 1)));
  late DateTime end = validateDate(now.subtract(const Duration(days: 1)));

  DateTime validateDate(DateTime date) {
    DateTime dateToShow = date;
    while (formatNameOfDate.format(dateToShow) == "Sunday" ||
        formatNameOfDate.format(dateToShow) == "Saturday") {
      dateToShow = dateToShow.subtract(const Duration(days: 1));
    }
    return dateToShow;
  }

  void pickDateRange() async {
    final DateTime yesterday = now.subtract(const Duration(days: 1));

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: validateDate(yesterday),
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
      setState(() {
        start = picked.start;
        end = picked.end;
      });
    }
  }

  Widget topTitle() {
    return Card(
      shadowColor: Colors.grey,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ចាប់ពីថ្ងៃទី - ដល់ថ្ងៃទី",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                pickDateRange();
              },
              child: Text(
                "${formatDateTimeForView(start)} - ${formatDateTimeForView(end)}",
                style: const TextStyle(fontSize: 16),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final List<Attendance>? attendances = snapshot.data;

          if (attendances == null || attendances.length == 0) {
            return const Center(
              child: Text("No Information Available"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attendances.length,
            itemBuilder: (context, index) {
              return AttendanceCard(
                attendance: attendances[index],
                onTap: () {
                  Get.to(
                    () => AttendanceDetail(
                      date: attendances[index].authDate,
                    ),
                  );
                },
              );
            },
          );
        }
        return const Center(
          child: Text("No Information Available"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("វត្តមានផ្ទាល់ខ្លួន"),
        actions: [
          IconButton(
            onPressed: () {
              pickDateRange();
            },
            icon: const Icon(Icons.date_range),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTitle(),
              attendanceView(),
              // dummyAttendanceView(),
              const SizedBox(height: 8),
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dummyAttendances.length,
      itemBuilder: (context, index) {
        return AttendanceCard(
          attendance: dummyAttendances[index],
          onTap: () {
            Get.to(
              () => AttendanceDetail(
                date: dummyAttendances[index].authDate,
              ),
            );
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
    return Card(
      elevation: 6,
      shadowColor: determineShadowColor(
        attendance.attendanceStatus,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDateTimeForView(attendance.authDate),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: CompanyColors.yellow,
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
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "វត្តមានកន្លះថ្ងៃ: ${attendance.attendanceStatus}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: CompanyColors.yellow,
                thickness: 1.5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("ព្រឹក(ស្កេនចូល)"),
                          Text(attendance.morningCheckIn),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("ព្រឹក(ស្កេនចេញ)"),
                          Text(attendance.morningCheckOut),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("ថ្ងៃ(ស្កេនចូល)"),
                          Text(attendance.afternoonCheckIn),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("ថ្ងៃ(ស្កេនចេញ)"),
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
