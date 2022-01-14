import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';

class WorkHistoryPage extends StatelessWidget {
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
            child: WorkHistoryTable(),
          ),
        ),
      ),
    );
  }
}

class WorkHistoryTable extends StatefulWidget {
  const WorkHistoryTable({Key? key}) : super(key: key);

  @override
  _WorkHistoryTableState createState() =>
      _WorkHistoryTableState();
}

class _WorkHistoryTableState extends State<WorkHistoryTable> {
  final userController = Get.find<UserController>();
  late final List<WorkHistory> workHistories;
  late WorkHistoryDataSource workHistoryDataSource;

  @override
  void initState() {
    super.initState();
    workHistories = getWorkHistory();
    workHistoryDataSource =
        WorkHistoryDataSource(workHistories: workHistories);
  }

  List<WorkHistory> getWorkHistory() {
    return userController.users!.value.workHistories!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    "មុខតំណែងបច្ចុប្បន្ន",
    'នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'ក្រសួង',
    'អង្គភាព',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: workHistoryDataSource,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: List.generate(headerTitles.length, (index) {
        return GridColumn(
            columnName: '${headerTitles[index]}',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Text(
                  '${headerTitles[index]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "KhmerOSBattambong",
                    fontWeight: FontWeight.bold,
                  ),
                )));
      }),
      columnWidthMode: ColumnWidthMode.auto,
    );
  }
}

class WorkHistoryDataSource extends DataGridSource {
  WorkHistoryDataSource(
      {required List<WorkHistory> workHistories}) {
    _workHistories = workHistories.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'មុខតំណែងបច្ចុប្បន្ន',
            value: e.position.title,
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: e.startDate.toString(),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: e.endDate.toString(),
          ),
          DataGridCell<String>(
            columnName: 'ក្រសួង',
            value: e.ministry.nameKh,
          ),
          DataGridCell<String>(
            columnName: '	អង្គភាព',
            value: e.organization[0].nameKh,
          ),
        ],
      );
    }).toList();
  }

  List<DataGridRow> _workHistories = [];

  @override
  List<DataGridRow> get rows => _workHistories;

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
