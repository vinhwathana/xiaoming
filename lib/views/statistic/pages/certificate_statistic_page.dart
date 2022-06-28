import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_error_widget.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/statistic/utils/custom_data_grid_filter.dart';
import 'package:xiaoming/views/statistic/utils/people_statistic_data_grid.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';
import 'package:xiaoming/views/statistic/utils/custom_bar_series.dart';
import 'package:xiaoming/views/statistic/utils/custom_grid_column.dart';

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
        fontFamily: khmerFont,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StatisticsPageWrapper(
      title: widget.chartTitle,
      builder: (controller, org, dept, degree, region) {
        // print("""org: $org,
        // dept: $dept,
        // degree: $degree,
        // region: $region,
        // """);
        return TabBarView(
          controller: controller,
          children: [
            certificateChart(org, dept, region),
            certificateDataGrid(org, dept, region),
            certificatePeople(org, dept, region),
          ],
        );
      },
    );
  }

  Widget certificatePeople(String org, String dept, String region) {
    return CertificatePeopleDataGrid(
      org: org,
      dept: dept,
      region: region,
    );
  }

  Widget certificateChart(String org, String dept, String region) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getCertificates(org, dept, region),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? certificateData = data;
        if (certificateData == null || certificateData.length == 0) {
          return const CustomErrorWidget(text: "មិនមានទិន្នន័យ");
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
              textStyle: fontKhmerTextStyle,
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: fontKhmerTextStyle,
            ),
            primaryYAxis: NumericAxis(
              maximum: max,
              labelFormat: '{value}',
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CustomBarSeries<ChartModel, String>>[
              CustomBarSeries(
                chartTitle: widget.chartTitle,
                dataSource: certificateData,
              )
            ],
          ),
        );
      },
    );
  }

  Widget certificateDataGrid(String org, String dept, String region) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getCertificates(org, dept, region),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? certificateData = data;
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGrid(
            source: TwoColumnDataGridSource(
              tableData: certificateData ?? [],
              firstColumnName: headerTitles[0],
              secondColumnName: headerTitles[1],
            ),
            // shrinkWrapRows: true,
            // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
            horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
            columns: List.generate(
              headerTitles.length,
              (index) {
                return CustomGridColumn(
                  columnName: headerTitles[index],
                );
              },
            ),
            columnWidthMode: ColumnWidthMode.fill,
            allowSorting: true,
            sortingGestureType: SortingGestureType.tap,
          ),
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
    required this.region,
  }) : super(key: key);

  final String dept;
  final String org;
  final String region;

  @override
  State<CertificatePeopleDataGrid> createState() =>
      _CertificatePeopleDataGridState();
}

class _CertificatePeopleDataGridState extends State<CertificatePeopleDataGrid>
    with AutomaticKeepAliveClientMixin {
  // bool isLoading = false;
  final statService = StatisticService();
  final List<String> peopleHeaderTitles = [
    "គោត្តនាម",
    "នាម",
    'ភេទ',
    'មុខតំណែង',
    'ការសិក្សា',
    'ជំនាញ',
    'គ្រឹះស្ថានសិក្សា',
    'ប្រទេស',
    'ថ្ងៃខែឆ្នាំបញ្ចប់',
  ];
  int rowsPerPage = 10;
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
    super.build(context);
    return CustomFutureBuilder<StatisticPeopleResponse?>(
      future: statService.getCertificatePeople(
        widget.org,
        widget.dept,
        filterController.degrees[selectedCertificate] ?? "P",
        widget.region,
        start: start,
        length: rowsPerPage,
        search: "",
      ),
      onDataRetrieved: (context, data, connectionState) {
        final responseData = data;
        final List<StatisticPeople>? certificatePeopleData = responseData?.data;

        return PeopleStatisticDataGrid(
          dataGridSource: CertificatePeopleDataGridSource(
            tableData: certificatePeopleData ?? [],
          ),
          topWidget: CustomDataGridFilter(
            customFiltersWidget: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropDownTextField(
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
              ),
            ],
            rowsPerPage: rowsPerPage,
            onChange: (value) {
              if (value != rowsPerPage) {
                setState(() {
                  rowsPerPage = int.parse(value.toString());
                });
              }
            },
          ),
          headerTitle: peopleHeaderTitles,
          rowsPerPage: rowsPerPage,
          totalAmount: responseData?.totalFilteredRecord,
          selectedPage: selectedPage,
          start: start,
          onChangePage: (index) {
            int tempStart = start;
            tempStart = rowsPerPage * (index);
            setState(() {
              if (tempStart >= 0) {
                start = tempStart;
              }
              selectedPage = index;
            });
          },
          connectionState: connectionState,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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
    'មុខតំណែង',
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
                fontFamily: khmerFont,
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
            value: formatDateForView(e.endDate),
          ),
        ],
      );
    }).toList(growable: false);
  }
}
