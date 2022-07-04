import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/clickable_textfield.dart';
import 'package:xiaoming/components/custom_type_text_field.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/holiday/holiday_response.dart';
import 'package:xiaoming/models/request_leave/create_request_leave_request.dart';
import 'package:xiaoming/services/holiday_service.dart';
import 'package:xiaoming/utils/constant.dart';

class AddRequestLeavePage extends StatefulWidget {
  const AddRequestLeavePage({Key? key}) : super(key: key);

  @override
  State<AddRequestLeavePage> createState() => _AddRequestLeaveState();
}

class _AddRequestLeaveState extends State<AddRequestLeavePage> {
  final categoryTextCon = TextEditingController(),
      startDateTextCon = TextEditingController(),
      endDateTextCon = TextEditingController(),
      rangeOfDateTextCon = TextEditingController(),
      amountOfDateTextCon = TextEditingController(),
      reasonTextCon = TextEditingController();
  final requestLeaveFormKey = GlobalKey<FormState>();

  final typeOfRequestLeave = [
    "ច្បាប់ឈប់សម្រាកប្រចាំឆ្នាំ",
    "រយះពេលខ្លី",
    "មាតុភាព",
    "ឈឺ",
    "ភារះកិច្ចផ្តាល់ខ្លួន",
  ];

  String? selectedTypeRequestLeave;
  ShortLeaveType? selectedShortLeaveType;
  bool firstEvening = false;
  bool lastMorning = false;
  double? totalAmountOfDay;
  final List<PlatformFile> files = [];
  final List<Holiday> holidays = [];

  final holidayService = HolidayService();

  void onChangeShortLeaveType(ShortLeaveType? value) {
    setState(() {
      selectedShortLeaveType = value;
    });
  }

  String determineDisplayDay() {
    final roundToInt = totalAmountOfDay?.round();
    final roundToDouble = totalAmountOfDay;
    if (roundToInt != roundToDouble) {
      return roundToDouble?.toString() ?? "";
    } else {
      return roundToInt?.toString() ?? "";
    }
  }

  void onConfirm() {
    if (!requestLeaveFormKey.currentState!.validate()) {
      return;
    }

    final request = generateCreateLeaveRequest();
  }

  final authController = Get.find<AuthenticationController>();

  void generateCreateLeaveRequest() {
    final ministryCode = authController.getUserMinistryCode();

    // return CreateRequestLeaveRequest(
    //   leaveType: leaveType,
    //   ministry: ministry,
    //   employeeId: employeeId,
    //   dateFrom: dateFrom,
    //   dateTo: dateTo,
    //   days: days,
    //   reasons: reasons,
    //   am: am,
    //   pm: pm,
    //   attachmentList: attachmentList,
    // );
  }

  Future<void> getHoliday() async {
    final response = await holidayService.getHoliday();
    if (response != null && response.data != null) {
      holidays.addAll(response.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ការស្នើសុំច្បាប់"),
        actions: [
          IconButton(
            onPressed: () {
              onConfirm();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Form(
              key: requestLeaveFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  DropDownTextField(
                    labelText: "ប្រភេទ",
                    controller: categoryTextCon,
                    listString: typeOfRequestLeave,
                    currentSelectedValue: selectedTypeRequestLeave,
                    onChange: (value) {
                      setState(() {
                        selectedTypeRequestLeave = value.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: (selectedTypeRequestLeave == "រយះពេលខ្លី"),
                    maintainSize: false,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio<ShortLeaveType?>(
                              groupValue: selectedShortLeaveType,
                              value: ShortLeaveType.LESSTHAN5,
                              onChanged: onChangeShortLeaveType,
                            ),
                            const Text("តិចជាង៥ថ្ងៃ"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<ShortLeaveType?>(
                              groupValue: selectedShortLeaveType,
                              value: ShortLeaveType.BETWEEN6AND15,
                              onChanged: onChangeShortLeaveType,
                            ),
                            const Text("៦ថ្ងៃ ទៅ១៥ថ្ងៃ"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: ClickableTextField(
                          controller: rangeOfDateTextCon,
                          labelText: "ចាប់ពីថ្ងៃទី - ដល់ថ្ងៃទី",
                          onClickTextField: () {
                            pickDateRange();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${determineDisplayDay()} ថ្ងៃ",
                          style: TextStyle(
                            height: 1,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: firstEvening,
                            onChanged: (bool? value) {
                              if (totalAmountOfDay == null) {
                                return;
                              }
                              setState(() {
                                firstEvening = value ?? false;
                                if (firstEvening) {
                                  totalAmountOfDay = totalAmountOfDay! - 0.5;
                                } else {
                                  totalAmountOfDay = totalAmountOfDay! + 0.5;
                                }
                              });
                            },
                          ),
                          const Text("កន្លះថ្ងៃល្ងាច"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: lastMorning,
                            onChanged: (bool? value) {
                              if (totalAmountOfDay == null) {
                                return;
                              }
                              setState(() {
                                lastMorning = value ?? false;
                                if (lastMorning) {
                                  totalAmountOfDay = totalAmountOfDay! - 0.5;
                                } else {
                                  totalAmountOfDay = totalAmountOfDay! + 0.5;
                                }
                              });
                            },
                          ),
                          const Text("កន្លះថ្ងៃព្រឹក"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTypeTextField(
                    labelText: "មូលហេតុ",
                    controller: reasonTextCon,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowedExtensions: ['jpg', 'png', 'pdf'],
                        type: FileType.custom,
                        allowMultiple: true,
                      );
                      if (result != null) {
                        files.addAll(result.files);
                        setState(() {});
                      }
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      strokeCap: StrokeCap.round,
                      dashPattern: const [5],
                      strokeWidth: 2,
                      color: CompanyColors.blue,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: SizedBox(
                          height: 150,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("ឯកសារភ្ជាប់"),
                              Text("ប្រភេទឯកសារ (.PDF, .JPG, .PNG)"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          await OpenFile.open(files[index].path);
                        },
                        title: Text(files[index].name),
                        trailing: IconButton(
                          onPressed: () {
                            files.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.clear,
                            color: CompanyColors.yellow,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? start;
  DateTime? end;
  final now = DateTime.now();

  void pickDateRange() async {
    final DateTime lastDate = now.add(const Duration(days: 365));

    DateTimeRange? initialDateRange;
    if (start != null && end != null) {
      initialDateRange = DateTimeRange(
        start: start!,
        end: end!,
      );
    }

    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: lastDate,
      locale: Get.locale,
      currentDate: now,
      initialDateRange: initialDateRange,
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
        rangeOfDateTextCon.text =
            "${formatDateForView(start)} - ${formatDateForView(end)}";
      });
      calculateAmountOfDay();
    }
  }

  void calculateAmountOfDay() {
    if (end == null || start == null) {
      return;
    }
    final difference = end!.difference(start!);
    totalAmountOfDay = difference.inDays.toDouble() + 1;
    DateTime tempStart = start!;
    final tempEnd = end!.add(Duration(days: 1));
    while (tempStart != tempEnd) {
      if (isWeekend(tempStart)) {
        // print("$tempStart: is weekend");
        reduceTotalAmountOfDay();
      } else if (isHoliday(tempStart)) {
        // print("$tempStart: is holiday");
        reduceTotalAmountOfDay();
      } else {
        // print("$tempStart: is normal day");
      }
      tempStart = tempStart.add(Duration(days: 1));
    }

    setState(() {});
  }

  void reduceTotalAmountOfDay() {
    totalAmountOfDay = totalAmountOfDay! - 1.0;
  }

  bool isWeekend(DateTime dateTime) {
    if (formatNameOfDate.format(dateTime) == "Sunday" ||
        formatNameOfDate.format(dateTime) == "Saturday") {
      return true;
    }
    return false;
  }

  bool isHoliday(DateTime dateTime) {
    for (var holiday in holidays) {
      DateTime currentHolidayStart = holiday.startDate!;
      DateTime currentHolidayEnd = holiday.endDate!.add(Duration(days: 1));

      if (currentHolidayEnd == currentHolidayStart) {
        if (dateTime.compareTo(currentHolidayStart) == 0) {
          return true;
        }
      } else {
        while (currentHolidayStart != currentHolidayEnd) {
          if (dateTime.compareTo(currentHolidayStart) == 0) {
            return true;
          }
          currentHolidayStart = currentHolidayStart.add(Duration(days: 1));
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getHoliday();
  }
}

// class AttendanceType {
//   final String name;
//   final String code;
//
//   AttendanceType({
//     required this.name,
//     required this.code,
//   });
// }
//
// class ShortAttendanceType extends AttendanceType {
//   ShortAttendanceType({
//     required String name,
//     required String code,
//   }) : super(name: name, code: code);
// }

enum RequestLeaveType {
  SHORT,
  MATERNITY,
  SICK,
  PERSONAL,
  ANNUAL,
}

enum ShortLeaveType {
  LESSTHAN5,
  BETWEEN6AND15,
}
