import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/language.dart';

class LanguageInfoPage extends StatelessWidget {
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
            child: LanguageInfoTable(),
          ),
        ),
      ),
    );
  }
}

class LanguageInfoTable extends StatefulWidget {
  const LanguageInfoTable({Key? key}) : super(key: key);

  @override
  _LanguageInfoTableState createState() => _LanguageInfoTableState();
}

class _LanguageInfoTableState extends State<LanguageInfoTable> {
  final userController = Get.find<UserController>();
  late final List<Language> languageInfos;
  late LanguageDataSource languageInfoDataSource;

  @override
  void initState() {
    super.initState();
    languageInfos = getLanguageInfo();
    languageInfoDataSource = LanguageDataSource(
      languageInfos: languageInfos,
      context: context,
    );
  }

  List<Language> getLanguageInfo() {
    return userController.users!.value.languages!;
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  final List<String> headerTitles = [
    "ភាសា",
    'អាន',
    'សរសេរ',
    'សរសេរ',
    'និយាយ',
    'ឯកសារភ្ជាប់',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: languageInfoDataSource,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: List.generate(headerTitles.length, (index) {
        return GridColumn(
            columnName: '${headerTitles[index]}',
            columnWidthMode: ColumnWidthMode.fitByColumnName,
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

class LanguageDataSource extends DataGridSource {
  LanguageDataSource({
    required this.languageInfos,
    required this.context,
  }) {
    _languageInfos = languageInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ភាសា',
            value: e.languageName.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'អាន',
            value: e.reading.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'សរសេរ',
            value: e.reading.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'សរសេរ',
            value: e.writing.nameKh,
          ),
          DataGridCell<String>(
            columnName: '	និយាយ',
            value: e.listening.nameKh,
          ),
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: languageInfos.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<Language> languageInfos;
  final BuildContext context;
  List<DataGridRow> _languageInfos = [];

  @override
  List<DataGridRow> get rows => _languageInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
          final index = dataGridCell.value;
          final attachmentList = languageInfos[index].attachmentList;
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
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.description),
          );
        }
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
