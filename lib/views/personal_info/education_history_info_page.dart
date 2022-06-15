import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/education.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';

class EducationHistoryInfoPage extends StatelessWidget {
  const EducationHistoryInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments ?? ""),
      ),
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const EducationHistoryInfoTable(),
          ),
        ),
      ),
    );
  }
}

class EducationHistoryInfoTable extends StatefulWidget {
  const EducationHistoryInfoTable({
    Key? key,
  }) : super(key: key);

  @override
  _EducationHistoryInfoTableState createState() =>
      _EducationHistoryInfoTableState();
}

class _EducationHistoryInfoTableState extends State<EducationHistoryInfoTable> {
  final userController = Get.find<UserController>();
  late final List<Education> educations;
  late EducationHistoryInfoDataSource educationHistoryInfoDataSource;

  @override
  void initState() {
    super.initState();
    educations = getEducationInfo();
    educationHistoryInfoDataSource = EducationHistoryInfoDataSource(
      educationInfos: educations,
      context: context,
    );
  }

  List<Education> getEducationInfo() {
    return userController.users!.value.educations!;
  }

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "KhmerOSBattambong",
  );

  final List<String> headerTitles = [
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'វត្គឬកម្រិតសិក្សា',
    'ថ្នាក់សិក្សា',
    'ជំនាញ',
    'សញ្ញាប័ត្រ',
    'គ្រឹះស្ថានសិក្សា',
    'រាជធានី/ខេត្ត',
    'ប្រទេស',
    "ឯកសារភ្ជាប់",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDataGridWidget(
      tableTitle: "ប្រវត្តិការសិក្សា",
      dataSource: educationHistoryInfoDataSource,
      headerTitles: headerTitles,
    );
  }
}

class EducationHistoryInfoDataSource extends DataGridSource {
  EducationHistoryInfoDataSource({
    required this.educationInfos,
    required this.context,
  }) {
    _educationInfos = educationInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: formatDateTimeForView(e.startDate),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: formatDateTimeForView(e.endDate),
          ),
          DataGridCell<String>(
            columnName: 'វត្គឬកម្រិតសិក្សា',
            value: e.educationType?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'ថ្នាក់សិក្សា',
            value: e.educationLevel?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'ជំនាញ',
            value: e.specialize?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'សញ្ញាប័ត្រ',
            value: e.certificationType?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'គ្រឹះស្ថានសិក្សា',
            value: e.schoolName,
          ),
          DataGridCell<String>(
            columnName: 'រាជធានី/ខេត្ត',
            value: e.city,
          ),
          DataGridCell<String>(
            columnName: 'ប្រទេស',
            value: e.country?.nameKh ?? "",
          ),
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: educationInfos.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<Education> educationInfos;
  final BuildContext context;
  List<DataGridRow> _educationInfos = [];

  @override
  List<DataGridRow> get rows => _educationInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
            final index = dataGridCell.value;
            final attachmentList = educationInfos[index].attachmentList;
            if (attachmentList == null ||
                attachmentList.isEmpty ||
                attachmentList.length == 0) {
              return Container();
            }
            return IconButton(
              onPressed: () {
                final fileViewer = FileViewer();
                fileViewer.displayFile(context, attachmentList);
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.description),
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataGridCell.value.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'KhmerOSBattambong',
                height: 1.5,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
