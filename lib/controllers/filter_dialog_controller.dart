import 'package:get/get.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';
import 'package:xiaoming/services/statistic_service.dart';

class FilterDialogController extends GetxController {
  final List<Datum> organizations = [];
  final List<Datum> departments = [];
  final orgRegion = "00";
  final statService = StatisticService();
  late String selectedDegrees = degrees.keys.first;
  String? selectedOrganization;
  String? selectedDepartment;

  String selectedOrgRegion = "00";
  RadioValue selectedRadioValue = RadioValue.all;
  final List<RadioValue> radioValues = [
    RadioValue.all,
    RadioValue.nation,
    RadioValue.underNation,
  ];
  final List<String> radioText = [
    "ទាំងអស់",
    "ថ្នាក់ជាតិ",
    "ថ្នាក់ក្រោមជាតិ",
  ];
  final Map<String, String> degrees = {
    "បណ្ឌិត": "P",
    "អនុបណ្ឌិត": "M",
    "បរិញ្ញាបត្រ": "B",
    "បរិញ្ញាបត្ររង": "U",
  };

  String? getSelectedOrganizationId() {
    if (selectedOrganization == null) {
      return null;
    }
    return organizations
        .cast<Datum>()
        .firstWhere((element) => element.displayText == selectedOrganization)
        .id
        .toString();
  }

  String? getSelectedDepartmentId() {
    if (selectedDepartment == null) {
      return null;
    }
    return departments
        .cast<Datum>()
        .firstWhere((element) => element.displayText == selectedDepartment)
        .id
        .toString();
  }

  String getSelectedDegreeKey() {
    return degrees[selectedDegrees] ?? degrees.keys.first;
  }

  void updateOrgRegion(RadioValue value) {
    selectedRadioValue = value;
    selectedOrganization = null;
    selectedDepartment = null;
    organizations.clear();
    departments.clear();
    switch (value) {
      case RadioValue.all:
        selectedOrgRegion = "00";
        break;
      case RadioValue.nation:
        selectedOrgRegion = "025000";
        break;
      case RadioValue.underNation:
        selectedOrgRegion = "026000";
        break;
    }

    getOrganizations();
    update();
  }

  void updateSelectedOrganization(String selected) {
    selectedOrganization = selected;
    final int id = organizations
        .where((e) => e.displayText == selected)
        .toList()[0]
        .id;
    getDepartments(id.toString());
    update();
  }

  Future<void> getOrganizations() async {
    final result =
        await statService.getOrganization(orgRegion: selectedOrgRegion);
    selectedOrganization = null;
    organizations.clear();
    if (result != null && result.isNotEmpty) {
      organizations.addAll(result);
    }
    update();
  }

  Future<void> getDepartments(
    String selectedOrgId,
  ) async {
    final result = await statService.getDepartment(
      orgRegion: selectedOrgRegion,
      parentId: selectedOrgId,
    );
    selectedDepartment = null;
    departments.clear();
    if (result != null && result.isNotEmpty) {
      departments.addAll(result);
    }
    update();
  }
}
