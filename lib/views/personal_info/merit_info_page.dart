import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/merit.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';

class MeritInfoPage extends StatelessWidget {
  const MeritInfoPage({
    Key? key,
  }) : super(key: key);

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
            // color: Colors.red,
            child: const MeritInfoTable(),
          ),
        ),
      ),
    );
  }
}

class MeritInfoTable extends StatefulWidget {
  const MeritInfoTable({
    Key? key,
  }) : super(key: key);

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
    meritInfoDataSource = MeritInfoDataSource(
      meritInfos: meritInfos,
      context: context,
    );
  }

  List<Merit> getMeritInfo() {
    return userController.users!.value.merits!;
  }

  final List<String> headerTitles = [
    "ប្រភេទគឿងឥស្សរិយយស្ស",
    'ប្រភេទមេដាយ',
    'ថ្នាក់',
    'កាលបរិច្ឆេទទទួល',
    'សម្គាល់',
    'ឯកសារភ្ជាប់',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDataGridWidget(
      tableTitle: "គ្រឿងឥស្សរិយយស",
      dataSource: meritInfoDataSource,
      headerTitles: headerTitles,
    );
  }
}

class MeritInfoDataSource extends DataGridSource {
  MeritInfoDataSource({
    required this.meritInfos,
    required this.context,
  }) {
    _meritInfos = meritInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ប្រភេទគឿងឥស្សរិយយស្ស',
            value: e.meritType?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'ប្រភេទមេដាយ',
            value: e.medalType?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'ថ្នាក់',
            value: e.rank?.nameKh ?? "",
          ),
          DataGridCell<String>(
            columnName: 'កាលបរិច្ឆេទទទួល',
            value: formatDateTimeForView(e.recievedDate),
          ),
          DataGridCell<String>(
            columnName: 'សម្គាល់',
            value: e.remark,
          ),
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: meritInfos.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<Merit> meritInfos;
  final BuildContext context;
  List<DataGridRow> _meritInfos = [];

  @override
  List<DataGridRow> get rows => _meritInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
            final index = dataGridCell.value;
            final attachmentList = meritInfos[index].attachmentList;
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
            // padding: const EdgeInsets.all(8.0),
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
      ).toList(),
    );
  }
}
