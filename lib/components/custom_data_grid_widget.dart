import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/colors/company_colors.dart';

class CustomDataGridWidget extends StatelessWidget {
  const CustomDataGridWidget({
    Key? key,
    this.tableTitle,
    required this.dataSource,
    required this.headerTitles,
    this.bottomWidget,
    this.topWidget,
    this.height,
  }) : super(key: key);
  final String? tableTitle;
  final List<String> headerTitles;
  final DataGridSource dataSource;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: CompanyColors.yellow,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topWidget ?? Container(),
            Visibility(
              visible: (tableTitle == null) ? false : true,
              maintainSize: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 8,
                ),
                child: Text(
                  tableTitle ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1),
            SfDataGrid(
              source: dataSource,
              verticalScrollPhysics: (height == null) ? const NeverScrollableScrollPhysics(): const AlwaysScrollableScrollPhysics(),
              horizontalScrollPhysics: const ClampingScrollPhysics(),
              shrinkWrapRows: (height == null) ? true:false,
              columns: List.generate(
                headerTitles.length,
                (index) {
                  return GridColumn(
                    columnName: headerTitles[index],
                    columnWidthMode: ColumnWidthMode.auto,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          headerTitles[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "KhmerOSBattambong",
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
              columnWidthMode: ColumnWidthMode.auto,
            ),
            bottomWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}
