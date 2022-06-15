import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/components/loading_widget.dart';

class PeopleStatisticDataGrid extends StatefulWidget {
  const PeopleStatisticDataGrid({
    Key? key,
    required this.dataGridSource,
    required this.topWidget,
    required this.headerTitle,
    required this.rowsPerPage,
    required this.totalAmount,
    required this.selectedPage,
    required this.start,
    required this.onChangePage,
    required this.connectionState,
  }) : super(key: key);

  final DataGridSource dataGridSource;
  final Widget topWidget;
  final List<String> headerTitle;
  final int rowsPerPage;
  final int? totalAmount;
  final int selectedPage;
  final int start;
  final Function(int index) onChangePage;
  final ConnectionState connectionState;

  @override
  State<PeopleStatisticDataGrid> createState() =>
      _PeopleStatisticDataGridState();
}

class _PeopleStatisticDataGridState extends State<PeopleStatisticDataGrid> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomDataGridWidget(
            topWidget: widget.topWidget,
            dataSource: widget.dataGridSource,
            headerTitles: widget.headerTitle,
            bottomWidget: DataGridPager(
              rowsPerPage: widget.rowsPerPage,
              totalAmount: widget.totalAmount ?? 0,
              selectedPage: widget.selectedPage,
              onChange: widget.onChangePage,
            ),
          ),
          Visibility(
            visible: (widget.connectionState == ConnectionState.waiting),
            child: const LoadingWidget(),
          ),
        ],
      ),
    );
  }
}
