import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/constant.dart';

class EducationInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments ?? ""),
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            // color: Colors.red,
            child: EducationInfoTable(),
          ),
        ),
      ),
    );
  }
}

class EducationInfoTable extends StatefulWidget {
  const EducationInfoTable({Key? key}) : super(key: key);

  @override
  _EducationInfoTableState createState() => _EducationInfoTableState();
}

class _EducationInfoTableState extends State<EducationInfoTable> {
  final userController = Get.find<UserController>();
  late final List<Education> educations;
  late EducationInfoDataSource educationInfoDataSource;

  @override
  void initState() {
    super.initState();
    educations = getEducationInfo();
    educationInfoDataSource =
        EducationInfoDataSource(educationInfos: educations);
    // print(userController.users!.value.familyInfos.toString());
  }

  List<Education> getEducationInfo() {
    return userController.users!.value.educations!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'វត្គឬកំរិតសិក្សា',
    'ថ្នាក់សិក្សា',
    'ជំនាញ',
    'សញ្ញាប័ត្រ',
    'គ្រឹះស្ថានសិក្សា',
    'រាជធានី/ខេត្ត',
    'ប្រទេស',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: educationInfoDataSource,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: List.generate(headerTitles.length, (index) {
        return GridColumn(
            columnName: '${headerTitles[index]}',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  '${headerTitles[index]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "KhmerOSBattambong",
                    fontWeight: FontWeight.bold,
                  ),
                )));
      }),
      columnWidthMode: ColumnWidthMode.fitByColumnName,
    );
  }
}

class EducationInfoDataSource extends DataGridSource {
  EducationInfoDataSource({required List<Education> educationInfos}) {
    _educationInfos = educationInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: formatDateTime(e.startDate),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: formatDateTime(e.endDate),
          ),
          DataGridCell<String>(
            columnName: 'វត្គឬកំរិតសិក្សា',
            value: e.educationType.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'ថ្នាក់សិក្សា',
            value: e.educationLevel.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'ជំនាញ',
            value: e.specialize.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'សញ្ញាប័ត្រ',
            value: e.certificationType.nameKh,
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
            value: e.country.nameKh,
          ),
        ],
      );
    }).toList();
  }

  List<DataGridRow> _educationInfos = [];

  @override
  List<DataGridRow> get rows => _educationInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        return Container(
          // alignment: (dataGridCell.columnName == 'ទំនាក់ទំនង' ||
          //         dataGridCell.columnName == 'អាស័យដ្ឋានបច្ចុប្បន្ន')
          //     ? Alignment.centerRight
          //     : Alignment.centerLeft,
          // color: Colors.red,
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'KhmerOSBattambong',
                height: 1.5,
              ),
            ),
          ),
        );
      },
    ).toList());
  }
}