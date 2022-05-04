import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
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

class SkillStatisticPage extends StatefulWidget {
  const SkillStatisticPage({
    Key? key,
    required this.chartTitle,
  }) : super(key: key);
  final String chartTitle;

  @override
  _SkillStatisticPageState createState() => _SkillStatisticPageState();
}

class _SkillStatisticPageState extends State<SkillStatisticPage>
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
            skillChart(org, dept),
            skillDataGrid(org, dept),
            skillPeopleDataGrid(org, dept),
          ],
        );
      },
    );
  }

  Widget skillChart(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getSkills(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? skillData = data;
        if (skillData == null || skillData.length == 0) {
          return const Center(child: Text("No Data Available"));
        }
        double max = skillData[0].amount;
        for (var element in skillData) {
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
            series: <CustomBarSeries<ChartModel, String>>[
              CustomBarSeries(
                dataSource: skillData,
                chartTitle: widget.chartTitle,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget skillDataGrid(String org, String dept) {
    return CustomFutureBuilder<List<ChartModel>?>(
      future: statService.getSkills(org, dept),
      onDataRetrieved: (context, data, connectionState) {
        final List<ChartModel>? skillData = data;

        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              sortIconColor: Colors.black,
            ),
            child: SfDataGrid(
              source: TwoColumnDataGridSource(
                tableData: skillData ?? [],
                firstColumnName: headerTitles[0],
                secondColumnName: headerTitles[1],
              ),
              // onQueryRowHeight: (details) {
              //   return details.getIntrinsicRowHeight(details.rowIndex);
              // },
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

  Widget skillPeopleDataGrid(String org, String dept) {
    return SkillPeopleDataGrid(org: org, dept: dept);
  }

  @override
  bool get wantKeepAlive => true;
}

class SkillPeopleDataGrid extends StatefulWidget {
  const SkillPeopleDataGrid({
    Key? key,
    required this.org,
    required this.dept,
  }) : super(key: key);

  final String dept;
  final String org;

  @override
  State<SkillPeopleDataGrid> createState() => _SkillPeopleDataGridState();
}

class _SkillPeopleDataGridState extends State<SkillPeopleDataGrid>
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
      future: statService.getSkillPeople(
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
        final List<StatisticPeople>? skillPeopleData = responseData?.data;

        return PeopleStatisticDataGrid(
          dataGridSource: SkillPeopleDataGridSource(
            tableData: skillPeopleData ?? [],
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

                    return DropDownTextField(
                      labelText: "ប្រទេស",
                      autoValidateMode: AutovalidateMode.disabled,
                      controller: TextEditingController(),
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

                    return DropDownTextField(
                      labelText: "ជំនាញ",
                      autoValidateMode: AutovalidateMode.disabled,
                      controller: TextEditingController(),
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
      // return const LoadingWidget();
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SkillPeopleDataGridSource extends DataGridSource {
  SkillPeopleDataGridSource({
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
