import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/krob_khan.dart';
import 'package:xiaoming/utils/constant.dart';

class KrobKhanPage extends StatelessWidget {
  const KrobKhanPage({Key? key}) : super(key: key);

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
            child: const KrobKhanTable(),
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
    workHistoryDataSource = KrobKhanDataSource(
      krobKhanInfos: krobKhans,
      context: context,
    );
  }

  List<KrobKhan> getKrobKhan() {
    return userController.users!.value.krobKhans!;
  }

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "KhmerOSBattambong",
  );

  final List<String> headerTitles = [
    "កាំប្រាក់",
    'ឆ្នាំចាប់ផ្តើម',
    'ឆ្នាំបញ្ចប់',
    'ឡើងតាម',
    'ប្រភេទ',
    'ឯកសារភ្ជាប់',
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

class KrobKhanDataSource extends DataGridSource {
  KrobKhanDataSource({
    required this.krobKhanInfos,
    required this.context,
  }) {
    _krobKhanInfos = krobKhanInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'កាំប្រាក់',
            value:
                "${e.krobKhanType.nameKh}. ${e.rank.nameKh}. ${e.level.nameKh}.",
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
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: krobKhanInfos.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<KrobKhan> krobKhanInfos;
  final BuildContext context;
  List<DataGridRow> _krobKhanInfos = [];

  @override
  List<DataGridRow> get rows => _krobKhanInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
          final index = dataGridCell.value;
          final attachmentList = krobKhanInfos[index].attachmentList;
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
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              dataGridCell.value.toString(),
              style: const TextStyle(
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
