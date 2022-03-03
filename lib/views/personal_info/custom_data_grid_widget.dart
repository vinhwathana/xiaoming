import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomDataGridWidget extends StatelessWidget {
  const CustomDataGridWidget({
    Key? key,
    required this.tableTitle,
    required this.dataSource,
    required this.headerTitles,
  }) : super(key: key);
  final String tableTitle;
  final List<String> headerTitles;
  final DataGridSource dataSource;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            tableTitle,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        SfDataGrid(
          source: dataSource,
          verticalScrollPhysics: const NeverScrollableScrollPhysics(),
          shrinkWrapRows: true,
          columns: List.generate(
            headerTitles.length,
            (index) {
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
                  ),
                ),
              );
            },
          ),
          columnWidthMode: ColumnWidthMode.auto,
        ),
      ],
    );
  }
}
