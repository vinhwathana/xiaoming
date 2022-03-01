import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/custom_alert_dialog.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/attendance/attendance.dart';
import 'package:xiaoming/models/attendance/attendance_log_response.dart';
import 'package:xiaoming/models/attendance/time_rule.dart';
import 'package:xiaoming/services/attendance_service.dart';
import 'package:xiaoming/utils/constant.dart';

class AttendanceDetail extends StatefulWidget {
  const AttendanceDetail({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

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

  Widget attendanceRuleView(TimeRule timeRule) {
    return highLevelCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "លក្ខខ័ណ្ឌម៉ោងស្កេនចូលស្កេនចេញ",
            style: boldTitleStyle,
          ),
          Divider(
            thickness: 1,
          ),
          Column(
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
          )
        ],
      ),
    );
  }

  Widget attendanceDetailView(AttendanceLog attendanceLog) {
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
                  formatDateTimeForView(widget.date),
                  style: boldTitleStyle,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: attendanceLog.logs.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              height: 0,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDetailDialog(attendanceLog.logs[index]);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                      child: Text(
                    attendanceLog.logs[index].authTime,
                  )),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void showDetailDialog(Log log) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            log.authTime,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text("- Device Name: ${log.devName}\n"
              "- Employee Id: ${log.empId}\n"
              "- Employee Name: ${log.empName}\n"
              "- Date Time Scan: ${log.authDateTime}\n"),
        );
      },
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
          child: FutureBuilder<AttendanceLog?>(
            future: attendanceService.getAttendanceLog(
              formatDateTimeForApi(widget.date),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                final attendanceLog = snapshot.data!;
                return Column(
                  children: [
                    attendanceRuleView(attendanceLog.timeRule),
                    attendanceDetailView(attendanceLog),
                  ],
                );
              }
              return Center(
                child: Text("No Information Available"),
              );
            },
          ),
        ),
      ),
    );
  }
}
