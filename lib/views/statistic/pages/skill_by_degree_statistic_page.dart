import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/components/dropdown_textfield_search.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/people/statistic_people.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/services/autocomplete_service.dart';
import 'package:xiaoming/services/statistic_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/statistic/utils/custom_data_grid_filter.dart';
import 'package:xiaoming/views/statistic/utils/people_statistic_data_grid.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';
import 'package:xiaoming/views/statistic/utils/custom_bar_series.dart';
import 'package:xiaoming/views/statistic/utils/custom_grid_column.dart';

class SkillByDegreeStatisticPage extends StatefulWidget {
  const SkillByDegreeStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);
  final String chartTitle;

  @override
  _SkillByDegreeStatisticPageState createState() =>
      _SkillByDegreeStatisticPageState();
}

class _SkillByDegreeStatisticPageState extends State<SkillByDegreeStatisticPage>
    with AutomaticKeepAliveClientMixin {
  late final TooltipBehavior _tooltipBehavior;
  final statService = StatisticService();

  final List<String> headerTitles = [
    "ជំនាញ",
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
      showDegree: true,
      builder: (controller, org, dept, degree) {
        return TabBarView(
          controller: controller,
          children: [
            skillByDegreeChart(org, dept, degree),
            skillByDegreeDataGrid(org, dept, degree),
            skillByDegreePeopleDataGrid(org, dept, degree),
          ],
        );
      },
    );
  }

  Widget skillByDegreeChart(String org, String dept, String degree) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getSkillByDegree(
        org,
        dept,
        degree,
      ),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? certificateData = data;
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
              textStyle: fontKhmerTextStyle,
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: fontKhmerTextStyle,
            ),
            primaryYAxis: NumericAxis(
              maximum: max.toDouble(),
              labelFormat: '{value}',
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CustomBarSeries<ChartModel, String>>[
              CustomBarSeries(
                chartTitle: widget.chartTitle,
                dataSource: certificateData,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget skillByDegreeDataGrid(String org, String dept, String degree) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getSkillByDegree(
        org,
        dept,
        degree,
      ),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? certificateData = data;

        final dataGridData = TwoColumnDataGridSource(
          tableData: certificateData ?? [],
          firstColumnName: headerTitles[0],
          secondColumnName: headerTitles[1],
        );
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: SfDataGrid(
              source: dataGridData,
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
          ),
        );
      },
    );
  }

  Widget skillByDegreePeopleDataGrid(String org, String dept, String degree) {
    return SkillByDegreePeopleDataGrid(
      org: org,
      dept: dept,
      degree: degree,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SkillByDegreePeopleDataGrid extends StatefulWidget {
  const SkillByDegreePeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
    required this.degree,
  }) : super(key: key);

  final String dept;
  final String org;
  final String degree;

  @override
  State<SkillByDegreePeopleDataGrid> createState() =>
      _SkillByDegreePeopleDataGridState();
}

class _SkillByDegreePeopleDataGridState
    extends State<SkillByDegreePeopleDataGrid>
    with AutomaticKeepAliveClientMixin {
  // bool isLoading = false;
  final statService = StatisticService();
  final autoCompleteService = AutocompleteService();
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
  String? selectedCountry;
  String? selectedCountryCode;
  String? selectedSkill;
  String? selectedSkillCode;

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
      future: statService.getSkillByDegreePeople(
        widget.org,
        widget.dept,
        filterController.degrees[selectedCertificate] ?? "P",
        start: start,
        length: rowsPerPage,
        search: "",
        country: selectedCountryCode ?? "",
        skill: selectedSkillCode ?? "",
      ),
      onDataRetrieved: (context, data, connectionState) {
        final responseData = data;
        final List<StatisticPeople>? skillByDegreePeopleData =
            responseData?.data;

        return PeopleStatisticDataGrid(
          dataGridSource: SkillByDegreePeopleDataGridSource(
            tableData: skillByDegreePeopleData ?? [],
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomFutureBuilder<List<ListValue>?>(
                  future: autoCompleteService.getCountries(),
                  onLoading: DropDownTextField(
                    labelText: "ប្រទេស",
                    controller: TextEditingController(),
                    listString: const [],
                    currentSelectedValue: null,
                    onChange: (value) {},
                  ),
                  onDataRetrieved: (context, snapshot, connectionState) {
                    final List<ListValue> countriesValue = snapshot ?? [];
                    final List<String> countries = [allKeyword];
                    countries.addAll(
                        snapshot?.map((e) => e.nameKh ?? "").toList() ?? []);

                    return DropdownTextFieldSearch(
                      labelText: "ប្រទេស",
                      listString: countries,
                      currentSelectedValue: selectedCountry,
                      onChange: (value) {
                        final index = countriesValue.indexWhere(
                            (element) => element.nameKh == value.toString());
                        setState(() {
                          if (value.toString() == allKeyword) {
                            selectedCountry = null;
                            selectedCountryCode = "";
                            return;
                          }
                          selectedCountry = value.toString();
                          selectedCountryCode =
                              countriesValue[index].lovCode ?? "";
                        });
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomFutureBuilder<List<ListValue>?>(
                  future: autoCompleteService.getSpecializes(),
                  onLoading: DropDownTextField(
                    labelText: "ជំនាញ",
                    controller: TextEditingController(),
                    listString: const [],
                    currentSelectedValue: null,
                    onChange: (value) {},
                  ),
                  onDataRetrieved: (context, snapshot, connectionState) {
                    final List<ListValue> specializedValue = snapshot ?? [];
                    final List<String> skills = [allKeyword];
                    skills.addAll(
                        snapshot?.map((e) => e.nameKh ?? "").toList() ?? []);

                    return DropdownTextFieldSearch(
                      labelText: "ជំនាញ",
                      listString: skills,
                      currentSelectedValue: selectedSkill,
                      onChange: (value) {
                        final index = specializedValue.indexWhere(
                            (element) => element.nameKh == value.toString());
                        setState(() {
                          if (value.toString() == allKeyword) {
                            selectedSkill = null;
                            selectedSkillCode = "";
                            return;
                          }
                          selectedSkill = value.toString();
                          selectedSkillCode =
                              specializedValue[index].lovCode ?? "";
                        });
                      },
                    );
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

class SkillByDegreePeopleDataGridSource extends DataGridSource {
  SkillByDegreePeopleDataGridSource({
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
            value: formatDateTimeForView(e.endDate),
          ),
        ],
      );
    }).toList(growable: false);
  }
}
