import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/krob_khan.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/personal_info/custom_data_grid_widget.dart';

class KrobKhanInfoPage extends StatelessWidget {
  const KrobKhanInfoPage({Key? key}) : super(key: key);

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
            child: const KrobKhanInfoTable(),
          ),
        ),
      ),
    );
  }
}

class KrobKhanInfoTable extends StatefulWidget {
  const KrobKhanInfoTable({Key? key}) : super(key: key);

  @override
  _KrobKhanInfoTableState createState() => _KrobKhanInfoTableState();
}

class _KrobKhanInfoTableState extends State<KrobKhanInfoTable> {
  final userController = Get.find<UserController>();
  late final List<KrobKhan> krobKhans;
  late KrobKhanInfoDataSource krobKhanInfoDataSource;

  @override
  void initState() {
    super.initState();
    krobKhans = getKrobKhan();
    krobKhanInfoDataSource = KrobKhanInfoDataSource(
      krobKhanInfos: krobKhans,
      context: context,
    );
  }

  List<KrobKhan> getKrobKhan() {
    return userController.users!.value.krobKhans!;
  }

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
    return CustomDataGridWidget(
      tableTitle: "ក្របខណ្ឌ",
      dataSource: krobKhanInfoDataSource,
      headerTitles: headerTitles,
    );
  }
}

class KrobKhanInfoDataSource extends DataGridSource {
  KrobKhanInfoDataSource({
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
            value: formatDateTimeForView(e.startDate),
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំបញ្ចប់',
            value: formatDateTimeForView(e.endDate),
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
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'KhmerOSBattambong',
              height: 1.5,
            ),
            textAlign: TextAlign.start,
          ),
        );
      },
    ).toList());
  }
}
