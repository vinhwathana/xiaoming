import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/constant.dart';

class AdditionalPositionPage extends StatelessWidget {
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
            child: AdditionalPositionTable(),
          ),
        ),
      ),
    );
  }
}

class AdditionalPositionTable extends StatefulWidget {
  const AdditionalPositionTable({Key? key}) : super(key: key);

  @override
  _AdditionalPositionTableState createState() =>
      _AdditionalPositionTableState();
}

class _AdditionalPositionTableState extends State<AdditionalPositionTable> {
  final userController = Get.find<UserController>();
  late final List<AdditionalPosition> additionalPositions;
  late AdditionalPositionDataSource additionalPositionDataSource;

  @override
  void initState() {
    super.initState();
    additionalPositions = getAdditionalPosition();
    additionalPositionDataSource =
        AdditionalPositionDataSource(additionalPositions: additionalPositions);
  }

  List<AdditionalPosition> getAdditionalPosition() {
    return userController.users!.value.additionalPositions!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    "មុខតំណែងបច្ចុប្បន្ន",
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'ក្រសួង',
    'អង្គភាព',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: additionalPositionDataSource,
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

class AdditionalPositionDataSource extends DataGridSource {
  AdditionalPositionDataSource(
      {required List<AdditionalPosition> additionalPositions}) {
    _additionalPositions = additionalPositions.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'មុខតំណែងបច្ចុប្បន្ន',
            value: e.position,
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: formatDateTime(e.startDate),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: formatDateTime(e.endDate),
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

  List<DataGridRow> _additionalPositions = [];

  @override
  List<DataGridRow> get rows => _additionalPositions;

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
