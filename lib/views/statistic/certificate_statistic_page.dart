import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/data_grid_pager.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/components/custom_data_grid_widget.dart';
import 'package:xiaoming/views/statistic/statistics_page_wrapper.dart';

class CertificateStatisticPage extends StatefulWidget {
  const CertificateStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);
  final String chartTitle;

  @override
  _CertificateStatisticPageState createState() =>
      _CertificateStatisticPageState();
}

class _CertificateStatisticPageState extends State<CertificateStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;

  bool isLoading = false;
  final statService = StatisticService();
  final List<String> headerTitles = [
    "កម្រិតសញ្ញាបត្រ",
    "រាប់តែចំនួនសរុប",
  ];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      textStyle: const TextStyle(
        fontFamily: 'KhmerOSBattambong',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StatisticsPageWrapper(
      title: widget.chartTitle,
      builder: (controller, org, dept, degree) {
        return TabBarView(
          controller: controller,
          children: [
            certificateChart(org, dept),
            certificateDataGrid(org, dept),
            certificatePeople(org, dept),
          ],
        );
      },
    );
  }

  Widget certificatePeople(String org, String dept) {
    return CertificatePeopleDataGrid(org: org, dept: dept);
  }

  Widget certificateChart(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getCertificates(org, dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          double max = certificateData[0].amount;
          for (var element in certificateData) {
            if (max < element.amount) {
              max = element.amount;
            }
          }
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 3,
            child: SfCartesianChart(
              title: ChartTitle(
                text: widget.chartTitle,
                textStyle: const TextStyle(
                  fontFamily: 'KhmerOSBattambong',
                ),
              ),
              primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(
                  fontFamily: 'KhmerOSBattambong',
                ),
              ),
              primaryYAxis: NumericAxis(
                maximum: max,
                labelFormat: '{value}',
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <BarSeries<ChartModel, String>>[
                BarSeries(
                  name: widget.chartTitle,
                  dataSource: certificateData,
                  xValueMapper: (datum, index) => datum.name,
                  yValueMapper: (datum, index) => datum.amount,
                  pointColorMapper: (datum, index) => datum.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  ),
                  enableTooltip: true,
                  animationDuration: 500,
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget certificateDataGrid(String org, String dept) {
    return FutureBuilder<List<ChartModel>?>(
      future: statService.getCertificates(org, dept),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final List<ChartModel>? certificateData = snapshot.data;
          if (certificateData == null || certificateData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(8),
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                sortIconColor: Colors.black,
              ),
              child: SfDataGrid(
                source: TwoColumnDataGridSource(
                  tableData: certificateData,
                  firstColumnName: headerTitles[0],
                  secondColumnName: headerTitles[1],
                ),
                // shrinkWrapRows: true,
                // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
                columns: List.generate(
                  headerTitles.length,
                  (index) {
                    return GridColumn(
                      columnName: headerTitles[index],
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          headerTitles[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "KhmerOSBattambong",
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      allowSorting: true,
                    );
                  },
                ),
                columnWidthMode: ColumnWidthMode.auto,
                allowSorting: true,
                sortingGestureType: SortingGestureType.tap,
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CertificatePeopleDataGrid extends StatefulWidget {
  const CertificatePeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  State<CertificatePeopleDataGrid> createState() =>
      _CertificatePeopleDataGridState();
}

class _CertificatePeopleDataGridState extends State<CertificatePeopleDataGrid> {
  // bool isLoading = false;
  final statService = StatisticService();
  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខដំណែង',
    'ការសិក្សា',
    'ជំនាញ',
    'គ្រឹះស្ថានសិក្សា',
    'ប្រទេស',
    'ថ្ងៃខែឆ្នាំបញ្ចប់',
  ];
  final rowsPerPage = 10;
  int start = 0;
  int selectedPage = 0;

  final filterController = Get.find<FilterDialogController>();
  final certificatedTextController = TextEditingController();
  List<String>? certificates;
  String? selectedCertificate;

  @override
  void initState() {
    super.initState();
    certificates = filterController.degrees.keys.toList();
    selectedCertificate = certificates?[0];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatisticPeopleResponse?>(
      future: statService.getCertificatePeople(
        widget.org,
        widget.dept,
        filterController.degrees[selectedCertificate] ?? "P",
        start: start,
        length: 10,
        search: "",
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          final responseData = snapshot.data;
          final List<StatisticPeople>? certificatePeopleData =
              responseData?.data;
          if (certificatePeopleData == null ||
              certificatePeopleData.length == 0) {
            return const Center(child: Text("No Data Available"));
          }
          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomDataGridWidget(
                  topWidget: Container(
                    padding: EdgeInsets.all(8),
                    child: Wrap(
                      children: [
                        DropDownTextField(
                          labelText: "កម្រិតសញ្ញាបត្រ",
                          controller: TextEditingController(),
                          listString: certificates ?? [],
                          currentSelectedValue: selectedCertificate,
                          onChange: (value) {
                            setState(() {
                              selectedCertificate = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  dataSource: CertificatePeopleDataGridSource(
                    tableData: certificatePeopleData,
                  ),
                  headerTitles: peopleHeaderTitles,
                  bottomWidget: DataGridPager(
                    rowsPerPage: rowsPerPage,
                    totalAmount: responseData?.totalFilteredRecord ?? 0,
                    selectedPage: selectedPage,
                    onChange: (index) {
                      int tempStart = start;
                      tempStart = rowsPerPage * (index);
                      setState(() {
                        if (tempStart >= 0) {
                          start = tempStart;
                        }
                        selectedPage = index;
                        // isLoading = false;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible:
                      (snapshot.connectionState == ConnectionState.waiting),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class CertificatePeopleDataGridSource extends DataGridSource {
  CertificatePeopleDataGridSource({
    required this.tableData,
  }) {
    buildPaginatedDataGridRows();
  }

  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខដំណែង',
    'ការសិក្សា',
    'ជំនាញ',
    'គ្រឹះស្ថានសិក្សា',
    'ប្រទេស',
    'ថ្ងៃខែឆ្នាំបញ្ចប់',
  ];

  List<StatisticPeople> tableData;
  List<DataGridRow> _tableData = [];

  @override
  List<DataGridRow> get rows => _tableData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
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
      ).toList(),
    );
  }

  void buildPaginatedDataGridRows() {
    _tableData = tableData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: peopleHeaderTitles[0],
            value: e.firstNameKh,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[1],
            value: e.lastNameKh,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[2],
            value: e.gender,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[3],
            value: e.position,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[4],
            value: e.education,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[5],
            value: e.skill,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[6],
            value: e.schoolName,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[7],
            value: e.country,
          ),
          DataGridCell<String>(
            columnName: peopleHeaderTitles[8],
            value: formatDateTimeForView(e.endDate),
          ),
        ],
      );
    }).toList(growable: false);
  }
}
