import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/work_history.dart';

import 'package:xiaoming/utils/constant.dart';

class WorkHistoryPage extends StatelessWidget {
  const WorkHistoryPage({Key? key}) : super(key: key);

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
            child: const WorkHistoryTable(),
          ),
        ),
      ),
    );
  }
}

class WorkHistoryTable extends StatefulWidget {
  const WorkHistoryTable({Key? key}) : super(key: key);

  @override
  _WorkHistoryTableState createState() => _WorkHistoryTableState();
}

class _WorkHistoryTableState extends State<WorkHistoryTable> {
  final userController = Get.find<UserController>();
  late final List<WorkHistory> workHistories;
  late WorkHistoryDataSource workHistoryDataSource;

  @override
  void initState() {
    super.initState();
    workHistories = getWorkHistory();
    workHistoryDataSource = WorkHistoryDataSource(
      workHistories: workHistories,
      context: context,
    );
  }

  List<WorkHistory> getWorkHistory() {
    return userController.users!.value.workHistories!;
  }

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "KhmerOSBattambong",
  );

  final List<String> headerTitles = [
    "មុខតំណែងបច្ចុប្បន្ន",
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'ក្រសួង',
    'អង្គភាព',
    "ឯកសារភ្ជាប់"
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
            columnName: headerTitles[index],
            columnWidthMode: ColumnWidthMode.auto,
            label: Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Text(
                  headerTitles[index],
                  style: const TextStyle(
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
  WorkHistoryDataSource({
    required this.workHistories,
    required this.context,
  }) {
    _workHistories = workHistories.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'មុខតំណែងបច្ចុប្បន្ន',
            value: e.position.title,
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: formatDateTime(e.startDate),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: e.endDate,
          ),
          DataGridCell<String>(
            columnName: 'ក្រសួង',
            value: e.ministry.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'អង្គភាព',
            value: e.organization[0].nameKh,
          ),
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: workHistories.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<WorkHistory> workHistories;
  final BuildContext context;
  List<DataGridRow> _workHistories = [];

  @override
  List<DataGridRow> get rows => _workHistories;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
          final index = dataGridCell.value as int;
          final attachmentList = workHistories[index].attachmentList;
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
              // height: 1.3,
            ),
          ),
        );
      },
    ).toList());
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }
}
