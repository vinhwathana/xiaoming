import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/attendance/attendance.dart';
import 'package:xiaoming/models/attendance/attendance_rule.dart';
import 'package:xiaoming/services/attendance_service.dart';
import 'package:xiaoming/utils/constant.dart';

class AttendanceDetail extends StatefulWidget {
  const AttendanceDetail({
    Key? key,
    required this.attendance,
  }) : super(key: key);

  final Attendance attendance;

  @override
  State<AttendanceDetail> createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  final userController = Get.find<UserController>();
  final TextStyle boldTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  final attendanceService = AttendanceService();
  String? attendanceRuleId;

  Widget highLevelCardWidget({required Widget child}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }

  Widget customRow(String firstText, String secondText) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(firstText),
          Text(secondText),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget attendanceRuleView() {
    return highLevelCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "លក្ខខ័ណម៉ោងស្កេនចូលស្កេនចេញ",
            style: boldTitleStyle,
          ),
          Divider(
            thickness: 1,
          ),
          (attendanceRuleId == null)
              ? Center(
                  child: Text("No Information"),
                )
              : FutureBuilder<AttendanceRule?>(
                  future: attendanceService.getAttendanceRuleById(
                    attendanceRuleId ?? "0",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData && snapshot.data != null) {
                      final timeRule = snapshot.data;

                      if (timeRule == null) {
                        return Center(
                          child: Text("No Information Available"),
                        );
                      }

                      return Column(
                        children: [
                          customRow(
                            "ព្រឹក(ស្កេនចូល)",
                            "${timeRule.timeCheckIn1From} ដល់ ${timeRule.timeCheckIn1To}",
                          ),
                          customRow(
                            "ព្រឹក(ស្កេនចេញ)",
                            "${timeRule.timeCheckOut1From} ដល់ ${timeRule.timeCheckOut1To}",
                          ),
                          customRow(
                            "ថ្ងៃ(ស្កេនចូល)",
                            "${timeRule.timeCheckIn2From} ដល់ ${timeRule.timeCheckIn2To}",
                          ),
                          customRow(
                            "ថ្ងៃ(ស្កេនចេញ)",
                            "${timeRule.timeCheckOut2From} ដល់ ${timeRule.timeCheckOut2To}",
                          ),
                        ],
                      );
                    }

                    return Center(
                      child: Text("No Information Available"),
                    );
                  },
                )
        ],
      ),
    );
  }

  Widget selectedAttendanceDetailView() {
    final name = userController.users?.value.officialInfo?.getFullNameKh();

    return highLevelCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8,
              children: [
                Text(
                  name ?? "",
                  style: boldTitleStyle,
                ),
                Text(
                  formatDateTimeForView(widget.attendance.authDate),
                  style: boldTitleStyle,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          FutureBuilder<Attendance?>(
            future: attendanceService.getPersonalAttendanceByDate(
              formatDateTimeForApi(widget.attendance.authDate),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                final attendance = snapshot.data;
                if (attendance == null) {
                  return Center(child: Text("No Information Available"));
                }
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  if (attendanceRuleId == null) {
                    setState(() {
                      attendanceRuleId = attendance.timeRuleId.toString();
                    });
                  }
                });
                return Column(
                  children: [
                    customRow("ព្រឹក(ស្កេនចូល)", attendance.morningCheckIn),
                    customRow("ព្រឹក(ស្កេនចេញ)", attendance.morningCheckOut),
                    customRow("ថ្ងៃ(ស្កេនចូល)", attendance.afternoonCheckIn),
                    customRow("ថ្ងៃ(ស្កេនចេញ)", attendance.afternoonCheckOut),
                  ],
                );
              }
              return Center(
                child: Text("No Information Available"),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ម៉ោងស្កេន"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              attendanceRuleView(),
              selectedAttendanceDetailView(),
            ],
          ),
        ),
      ),
    );
  }
}
