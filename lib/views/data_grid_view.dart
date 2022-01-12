import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/models/users.dart';
import 'package:xiaoming/utils/constant.dart';

class DataGridView extends StatefulWidget {
  const DataGridView({Key? key}) : super(key: key);

  @override
  _DataGridViewState createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  List<FamilyInfo> familyInfos = [];

  late FamilyInfoDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    familyInfos = getFamilyInfo();
    employeeDataSource = FamilyInfoDataSource(familyInfos: familyInfos);
    setState(() {});
  }

  List<FamilyInfo> getFamilyInfo() {
    return [
      dummyFamilyInfo,
      dummyFamilyInfo,
      dummyFamilyInfo,
      dummyFamilyInfo,
      dummyFamilyInfo,
      dummyFamilyInfo,
    ];
  }

  final textStyle =
      TextStyle(color: Colors.black, fontFamily: "KhmerOSBattambong");

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(

      source: employeeDataSource,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: <GridColumn>[
        GridColumn(
            columnName: 'ទំនាក់ទំនង',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ទំនាក់ទំនង',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'គោត្តនាម និង នាម',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'គោត្តនាម និង នាម',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
            width: 120,
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'ភេទ',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ភេទ',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'ស្ថានភាពគ្រួសារ',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ស្ថានភាពគ្រួសារ',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'ស្ថានភាព',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ស្ថានភាព',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'ជនជាតិ',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ជនជាតិ',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'សញ្ជាតិ',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'សញ្ជាតិ',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'មុខរបរ',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'មុខរបរ',
                  style: textStyle,
                ))),
        GridColumn(
            columnName: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
            label: Container(
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'អាស័យដ្ឋានបច្ចុប្បន្ន',
                  style: textStyle,
                ))),
      ],
      columnWidthMode: ColumnWidthMode.fitByColumnName,
    );
  }
}

class FamilyInfoDataSource extends DataGridSource {
  FamilyInfoDataSource({required List<FamilyInfo> familyInfos}) {
    _familyInfos = familyInfos
        .map<DataGridRow>(
          (e) => DataGridRow(
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
                value: e.dateOfBirth.toString(),
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
                value: e.job!.nameKh,
              ),
              DataGridCell<String>(
                columnName: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
                value: "${e.currentAddressProvince!.addressNameKh} "
                    "${e.currentAddressProvince!.addressNameKh} "
                    "${e.currentAddressProvince!.addressNameKh} "
                    "${e.currentAddressProvince!.addressNameKh}",
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _familyInfos = [];

  @override
  List<DataGridRow> get rows => _familyInfos;

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
          // color: Colors.red,
          padding: EdgeInsets.all(16.0),
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

class Employee {
  const Employee(
    this.id,
    this.name,
    this.designation,
    this.salary,
  );

  final int id;
  final String name;
  final String designation;
  final int salary;
}
