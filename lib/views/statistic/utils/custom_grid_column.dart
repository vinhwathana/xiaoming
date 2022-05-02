import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/utils/constant.dart';

class CustomGridColumn extends GridColumn {
  CustomGridColumn({
    required String columnName,
  }) : super(
          columnName: columnName,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              columnName,
              style: columnHeaderTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          allowSorting: true,
          visible: true,
        );
}
// return GridColumn(
//   columnName: headerTitles[index],
//   // columnWidthMode: ColumnWidthMode.auto,
//   label: Container(
//     padding: const EdgeInsets.all(8.0),
//     alignment: Alignment.centerLeft,
//     child: Text(
//       headerTitles[index],
//       style: const TextStyle(
//         color: Colors.black,
//         fontFamily: "KhmerOSBattambong",
//         fontWeight: FontWeight.bold,
//       ),
//       overflow: TextOverflow.ellipsis,
//     ),
//   ),
//   allowSorting: true,
// );
