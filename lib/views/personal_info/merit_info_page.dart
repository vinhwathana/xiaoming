import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/merit.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/constant.dart';

class MeritInfoPage extends StatelessWidget {
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
            child: MeritInfoTable(),
          ),
        ),
      ),
    );
  }
}

class MeritInfoTable extends StatefulWidget {
  const MeritInfoTable({Key? key}) : super(key: key);

  @override
  _MeritInfoTableState createState() => _MeritInfoTableState();
}

class _MeritInfoTableState extends State<MeritInfoTable> {
  final userController = Get.find<UserController>();
  late final List<Merit> meritInfos;
  late MeritInfoDataSource meritInfoDataSource;

  @override
  void initState() {
    super.initState();
    meritInfos = getMeritInfo();
    meritInfoDataSource = MeritInfoDataSource(meritInfos: meritInfos);
  }

  List<Merit> getMeritInfo() {
    return userController.users!.value.merits!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    "ប្រភេទគឿងឥស្សរិយយស្ស",
    'ប្រភេទមេដាយ',
    'ថ្នាក់',
    'កាលបរិច្ឆេទទទួល',
    'សំគាល់',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: meritInfoDataSource,
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
      columnWidthMode: ColumnWidthMode.fitByColumnName,
    );
  }
}

class MeritInfoDataSource extends DataGridSource {
  MeritInfoDataSource({required List<Merit> meritInfos}) {
    _meritInfos = meritInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ប្រភេទគឿងឥស្សរិយយស្ស',
            value: e.meritType.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'ប្រភេទមេដាយ',
            value: e.medalType.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'ថ្នាក់',
            value: e.rank.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'កាលបរិច្ឆេទទទួល',
            value: formatDateTime(e.recievedDate),
          ),
          DataGridCell<String>(
            columnName: '	សំគាល់',
            value: e.remark,
          ),
        ],
      );
    }).toList();
  }

  List<DataGridRow> _meritInfos = [];

  @override
  List<DataGridRow> get rows => _meritInfos;

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
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'KhmerOSBattambong',
                height: 1.5,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        );
      },
    ).toList());
  }
}
