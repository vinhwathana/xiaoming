import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/krob_khan.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/constant.dart';

class KrobKhanPage extends StatelessWidget {
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
            child: KrobKhanTable(),
          ),
        ),
      ),
    );
  }
}

class KrobKhanTable extends StatefulWidget {
  const KrobKhanTable({Key? key}) : super(key: key);

  @override
  _KrobKhanTableState createState() => _KrobKhanTableState();
}

class _KrobKhanTableState extends State<KrobKhanTable> {
  final userController = Get.find<UserController>();
  late final List<KrobKhan> krobKhans;
  late KrobKhanDataSource workHistoryDataSource;

  @override
  void initState() {
    super.initState();
    krobKhans = getKrobKhan();
    workHistoryDataSource = KrobKhanDataSource(krobKhans: krobKhans);
  }

  List<KrobKhan> getKrobKhan() {
    return userController.users!.value.krobKhans!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    "កាំប្រាក់",
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'ឡើងតាម',
    'ប្រភេទ',
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

class KrobKhanDataSource extends DataGridSource {
  KrobKhanDataSource({required List<KrobKhan> krobKhans}) {
    _krobKhans = krobKhans.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'កាំប្រាក់',
            value: "${e.krobKhanType.nameKh}. ${e.rank.nameKh}. ${e.level.nameKh}.",
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
            columnName: 'ឡើងតាម',
            value: e.upgradedBy.nameKh,
          ),
          DataGridCell<String>(
            columnName: '	ប្រភេទ',
            value: e.officialType.nameKh,
          ),
        ],
      );
    }).toList();
  }

  List<DataGridRow> _krobKhans = [];

  @override
  List<DataGridRow> get rows => _krobKhans;

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
