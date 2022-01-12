import 'package:flutter/material.dart';
import 'package:xiaoming/components/expansion_row.dart';
import 'package:xiaoming/views/data_grid_view.dart';

class FamilyInfoExpansionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 20, 10),
      child: DataGridView(),
    );
  }
}
