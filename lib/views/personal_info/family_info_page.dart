
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/file_viewer.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/offical_info/family_info.dart';
import 'package:xiaoming/services/file_service.dart';
import 'package:xiaoming/utils/constant.dart';

class FamilyInfoPage extends StatelessWidget {
  const FamilyInfoPage({Key? key}) : super(key: key);

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
            child: const FamilyInfoTable(),
          ),
        ),
      ),
    );
  }
}

class FamilyInfoTable extends StatefulWidget {
  const FamilyInfoTable({Key? key}) : super(key: key);

  @override
  _FamilyInfoTableState createState() => _FamilyInfoTableState();
}

class _FamilyInfoTableState extends State<FamilyInfoTable> {
  final userController = Get.find<UserController>();
  late final List<FamilyInfo> familyInfos;
  late FamilyInfoDataSource familyInfoDataSource;

  final fileService = FileService();

  @override
  void initState() {
    super.initState();
    familyInfos = getFamilyInfo();
    familyInfoDataSource = FamilyInfoDataSource(
      familyInfos: familyInfos,
      context: context,
    );
  }

  List<FamilyInfo> getFamilyInfo() {
    return userController.users!.value.familyInfos!;
  }

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "KhmerOSBattalion",
  );

  final List<String> headerTitles = [
    "ទំនាក់ទំនង",
    "គោត្តនាម និង នាម",
    'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
    'ភេទ',
    'ស្ថានភាពគ្រួសារ',
    'ស្ថានភាព',
    'ជនជាតិ',
    'សញ្ជាតិ',
    'មុខរបរ',
    'អាស័យដ្ឋានបច្ចុប្បន្ន',
    'ឯកសារភ្ជាប់',
  ];

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: familyInfoDataSource,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: List.generate(headerTitles.length, (index) {
        return GridColumn(
          columnName: headerTitles[index],
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                headerTitles[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "KhmerOSBattambong",
                  fontWeight: FontWeight.bold,
                ),
              )),
        );
      }),
      columnWidthMode: ColumnWidthMode.auto,
    );
  }
}

class FamilyInfoDataSource extends DataGridSource {
  FamilyInfoDataSource({
    required this.familyInfos,
    required this.context,
  }) {
    _familyInfos = familyInfos.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ទំនាក់ទំនង',
            value: e.relation!.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'គោត្តនាម និង នាម',
            value: "${e.firstNameKh!} ${e.lastNameKh!}",
          ),
          DataGridCell<String>(
            columnName: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
            value: formatDateTime(e.dateOfBirth),
          ),
          DataGridCell<String>(
            columnName: 'ភេទ',
            value: e.gender,
          ),
          DataGridCell<String>(
            columnName: 'ស្ថានភាពគ្រួសារ',
            value: e.maritalStatus!.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'ស្ថានភាព',
            value: e.status,
          ),
          DataGridCell<String>(
            columnName: 'ជនជាតិ',
            value: e.race!.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'សញ្ជាតិ',
            value: e.nationality!.nameKh,
          ),
          DataGridCell<String>(
            columnName: 'មុខរបរ',
            value: e.job?.nameKh ?? "N/A",
          ),
          // Village , Commune , District , Province
          DataGridCell<String>(
            columnName: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
            value: "${e.currentAddressVillage!.addressNameKh} "
                "${e.currentAddressCommune!.addressNameKh} "
                "${e.currentAddressDistrict!.addressNameKh} "
                "${e.currentAddressProvince!.addressNameKh}",
          ),
          DataGridCell<int>(
            columnName: 'ឯកសារភ្ជាប់',
            value: familyInfos.indexOf(e),
          ),
        ],
      );
    }).toList();
  }

  final List<FamilyInfo> familyInfos;
  final BuildContext context;
  List<DataGridRow> _familyInfos = [];

  @override
  List<DataGridRow> get rows => _familyInfos;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          if (dataGridCell.columnName == "ឯកសារភ្ជាប់") {
            final index = dataGridCell.value;
            final attachmentList = familyInfos[index].attachmentList;
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
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Center(
              child: Text(
                dataGridCell.value.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'KhmerOSBattambong',
                  height: 1.5,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
