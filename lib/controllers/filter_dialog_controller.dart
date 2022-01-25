import 'package:get/get.dart';
import 'package:xiaoming/components/filter_dialog.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';
import 'package:xiaoming/models/utils/organization.dart';
import 'package:xiaoming/services/statistic_service.dart';

class FilterDialogController extends GetxController {
  final organizations = [].obs;
  final departments = [].obs;
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
    return departments
        .cast<Datum>()
        .firstWhere((element) => element.displayText == selectedDepartment)
        .id
        .toString();
  }

  String getSelectedDegreeKey() {
    return degrees["$selectedDegrees"] ?? degrees.keys.first;
  }

  void updateOrgRegion(RadioValue value) {
    selectedRadioValue = value;
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
    selectedDepartment = null;
    getOrganizations();
    update();
  }

  void updateSelectedOrganization(String selected) {
    selectedOrganization = selected;
    final int id = organizations
        .cast<Datum>()
        .where((e) => e.displayText == selected)
        .toList()[0]
        .id;
    getDepartments(id.toString());
    update();
  }

  void updateSelectedDepartment(String selected) {}

  Future<void> getOrganizations() async {
    final result =
        await statService.getOrganization(orgRegion: selectedOrgRegion);
    selectedOrganization = null;
    if (result != null && result.length > 0) {
      organizations.clear();
      organizations.addAll(result);
    } else {
      organizations.clear();
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
    if (result != null && result.length > 0) {
      departments.clear();
      departments.addAll(result);
    } else {
      departments.clear();
    }
    update();
  }
}
