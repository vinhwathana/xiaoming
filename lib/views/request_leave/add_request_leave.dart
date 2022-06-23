import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/clickable_textfield.dart';
import 'package:xiaoming/components/custom_type_text_field.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
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
  ];

  String? selectedTypeRequestLeave;

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
                const SizedBox(height: 16),
                ClickableTextField(
                  controller: rangeOfDateTextCon,
                  labelText: "ចាប់ពីថ្ងៃទី - ដល់ថ្ងៃទី",
                  suffixIcon: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: const [
                      Text(
                        "10 ថ្ងៃ",
                        style: TextStyle(
                          height: 1,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  onClickTextField: () {
                    pickDateRange();
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        const Text("កន្លះថ្ងៃល្ងាច"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
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
                    await FilePicker.platform.pickFiles(
                      allowedExtensions: ['jpg', 'png', 'pdf'],
                      type: FileType.custom,
                    );
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
      // initialDateRange: DateTimeRange(
      //   start: start,
      //   end: end,
      // ),
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
            "${formatDateTimeForView(start)} - ${formatDateTimeForView(end)}";
      });
    }
  }
}
