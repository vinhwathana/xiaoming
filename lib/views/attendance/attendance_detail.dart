import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/loading_widget.dart';
import 'package:xiaoming/controllers/user_controller.dart';
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
  final TextStyle boldTitleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  final attendanceService = AttendanceService();
  String? attendanceRuleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ម៉ោងស្កេន"),
      ),
      body: FutureBuilder<AttendanceLog?>(
        future: attendanceService.getAttendanceLog(
          formatDateTimeForApi(widget.date),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasData && snapshot.data != null) {
            final attendanceLog = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  attendanceDetailView(attendanceLog),
                  attendanceRuleView(attendanceLog.timeRule),
                  workingHoursViews(),
                ],
              ),
            );
          }
          return const Center(
            child: Text("មិនមានព័ត៌មាន"),
          );
        },
      ),
    );
  }

  Widget highLevelCardWidget({required Widget child}) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }

  Widget workingHoursViews() {
    return highLevelCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ពេលវេលាបំពេញការងារ",
            style: boldTitleStyle,
          ),
          const Divider(
            thickness: 1,
          ),
          Column(
            children: [
              attendanceRuleRow(
                "ច្រើនជាង ៨ម៉ោង/ថ្ងៃ",
                "វត្តមានល្អប្រសើរ",
              ),
              attendanceRuleRow(
                "ច្រើនជាង ៧ម៉ោង/ថ្ងៃ",
                "វត្តមានមួយថ្ងៃ",
              ),
              attendanceRuleRow(
                "ច្រើនជាង ៣ម៉ោងកន្លះ/ថ្ងៃ",
                "អវត្តមានកន្លះថ្ងៃ",
              ),
              attendanceRuleRow(
                "តិចជាង ៣ម៉ោងកន្លះ/ថ្ងៃ ",
                "អវត្តមានមួយថ្ងៃ",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget attendanceRuleRow(String firstText, String secondText) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(firstText),
          Text(secondText),
          const Divider(
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
          const Divider(
            thickness: 1,
          ),
          Column(
            children: [
              attendanceRuleRow(
                "ព្រឹក(ស្កេនចូល)",
                "${timeRule.timeCheckIn1From} ដល់ ${timeRule.timeCheckIn1To}",
              ),
              attendanceRuleRow(
                "ព្រឹក(ស្កេនចេញ)",
                "${timeRule.timeCheckOut1From} ដល់ ${timeRule.timeCheckOut1To}",
              ),
              attendanceRuleRow(
                "ថ្ងៃ(ស្កេនចូល)",
                "${timeRule.timeCheckIn2From} ដល់ ${timeRule.timeCheckIn2To}",
              ),
              attendanceRuleRow(
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
                  "កាលបរិច្ឆេទស្កេនវត្តមាន",
                  style: boldTitleStyle,
                ),
                Text(
                  formatDateTimeForView(widget.date),
                  style: boldTitleStyle,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attendanceLog.logs.length,
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1,
                height: 0,
              );
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // showDetailDialog(attendanceLog.logs[index]);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      attendanceLog.logs[index].authTime ?? "",
                    ),
                  ),
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
            log.authTime ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "- Device Name: ${log.devName}\n"
            "- Employee Id: ${log.empId}\n"
            "- Employee Name: ${log.empName}\n"
            "- Date Time Scan: ${log.authDateTime}\n",
          ),
        );
      },
    );
  }
}
