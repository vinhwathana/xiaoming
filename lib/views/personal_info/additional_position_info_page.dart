import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/additiona_position.dart';
import 'package:xiaoming/views/personal_info/custom_data_grid_widget.dart';

class AdditionalPositionInfoPage extends StatelessWidget {
  const AdditionalPositionInfoPage({Key? key}) : super(key: key);

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
            child: const AdditionalPositionInfoTable(),
          ),
        ),
      ),
    );
  }
}

class AdditionalPositionInfoTable extends StatefulWidget {
  const AdditionalPositionInfoTable({Key? key}) : super(key: key);

  @override
  _AdditionalPositionInfoTableState createState() =>
      _AdditionalPositionInfoTableState();
}

class _AdditionalPositionInfoTableState
    extends State<AdditionalPositionInfoTable> {
  final userController = Get.find<UserController>();
  late final List<AdditionalPosition> additionalPositions;
  late AdditionalPositionInfoDataSource additionalPositionInfoDataSource;

  @override
  void initState() {
    super.initState();
    additionalPositions = getAdditionalPosition();
    additionalPositionInfoDataSource = AdditionalPositionInfoDataSource(
      additionalPositions: additionalPositions,
      context: context,
    );
  }

  List<AdditionalPosition> getAdditionalPosition() {
    return userController.users!.value.additionalPositions!;
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
    return CustomDataGridWidget(
      tableTitle: "មុខងារបន្ថែម",
      dataSource: additionalPositionInfoDataSource,
      headerTitles: headerTitles,
    );
  }
}

class AdditionalPositionInfoDataSource extends DataGridSource {
  AdditionalPositionInfoDataSource({
    required this.additionalPositions,
    required this.context,
  }) {
    _additionalPositions = additionalPositions.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'មុខតំណែងបច្ចុប្បន្ន',
            value: e.position,
          ),
          DataGridCell<String>(
            columnName: 'ឆ្នាំចាប់ផ្តើម',
            value: e.startDate,
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
            value: additionalPositions.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<AdditionalPosition> additionalPositions;
  final BuildContext context;
  List<DataGridRow> _additionalPositions = [];

  @override
  List<DataGridRow> get rows => _additionalPositions;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
          final index = dataGridCell.value as int;
          final attachmentList = additionalPositions[index].attachmentList;
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
          // padding: const EdgeInsets.all(8.0),
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
    ).toList());
  }
}
