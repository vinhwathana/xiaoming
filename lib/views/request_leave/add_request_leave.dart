import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/clickable_textfield.dart';
import 'package:xiaoming/components/custom_type_text_field.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/components/file_viewer.dart';
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

  final typeOfRequestLeave = [
    "រយះពេលខ្លី",
    "មាតុភាព",
    "ឈឺ",
    "ភារះកិច្ចផ្តាល់ខ្លួន",
    "ច្បាប់ឈប់សម្រាកប្រចាំឆ្នាំ",
  ];

  String? selectedTypeRequestLeave;
  ShortLeaveType? selectedShortLeaveType;
  bool firstEvening = false;
  bool lastMorning = false;
  double? totalAmountOfDay;
  final List<PlatformFile> files = [];

  void onChangeShortLeaveType(ShortLeaveType? value) {
    setState(() {
      selectedShortLeaveType = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ការស្នើសុំច្បាប់"),
      ),
      body: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
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
                  visible: (selectedTypeRequestLeave == typeOfRequestLeave[0]),
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
                        "${totalAmountOfDay?.toStringAsFixed(0) ?? ""} ថ្ងៃ",
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
                            setState(() {
                              firstEvening = value ?? false;
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
                            setState(() {
                              lastMorning = value ?? false;
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
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
    );
  }

  DateTime? start;
  DateTime? end;
  final now = DateTime.now();

  void pickDateRange() async {
    final DateTime lastDate = now.add(const Duration(days: 365));

    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: lastDate,
      locale: Get.locale,
      currentDate: now,
      initialDateRange: DateTimeRange(
        start: start ?? now,
        end: end ?? now,
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
    final tempEnd = end!;

    while (tempStart != tempEnd) {
      tempStart = tempStart.add(Duration(days: 1));
      if (formatNameOfDate.format(tempStart) == "Sunday" ||
          formatNameOfDate.format(tempStart) == "Saturday") {
        totalAmountOfDay = totalAmountOfDay! - 1.0;
      }
    }
    setState(() {});
  }
}

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
