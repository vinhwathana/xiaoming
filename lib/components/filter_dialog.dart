import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    Key? key,
    required this.onConfirm,
    this.showDegreeField = false,
  }) : super(key: key);

  final Function(String org, String dept, String degree) onConfirm;
  final bool showDegreeField;

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> slideAnimation;
  final departmentTextCon = TextEditingController(),
      organizationTextCon = TextEditingController();
  final filterDialogController = Get.find<FilterDialogController>();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -4.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.reverseDuration = const Duration(milliseconds: 200);
    controller.forward();
    super.initState();
  }

  Future<void> popBack() async {
    await controller.reverse();
    Get.back();
    controller.dispose();
  }

  void confirmData() {
    final selectedOrg = filterDialogController.getSelectedOrganizationId();
    final selectedDept = filterDialogController.getSelectedDepartmentId();
    final selectedDegree = filterDialogController.getSelectedDegreeKey();
    widget.onConfirm(selectedOrg ?? "00", selectedDept ?? "00", selectedDegree);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: GestureDetector(
        onTap: () {
          popBack();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12.0),
              width: Get.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: GetBuilder<FilterDialogController>(
                builder: (controller) {
                  final organizations = controller.organizations
                      .cast<Datum>()
                      .map((e) => e.displayText)
                      .toList()
                      .cast<String>();
                  final departments = controller.departments
                      .cast<Datum>()
                      .map((e) => e.displayText)
                      .toList()
                      .cast<String>();

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          controller.radioValues.length,
                          (index) {
                            return Row(
                              children: [
                                Radio<RadioValue>(
                                  activeColor: CompanyColors.yellow,
                                  value: controller.radioValues[index],
                                  groupValue: controller.selectedRadioValue,
                                  onChanged: (value) {
                                    if (value == null) {
                                      return;
                                    }
                                    controller.updateOrgRegion(value);
                                  },
                                ),
                                Text(controller.radioText[index]),
                              ],
                            );
                          },
                        ),
                      ),
                      DropdownTextField(
                        autoValidateMode: AutovalidateMode.disabled,
                        labelText: "អគ្គនាយកដ្ឋាន",
                        listString: organizations.cast(),
                        currentSelectedValue: controller.selectedOrganization,
                        onChange: (value) {
                          if (value == null) {
                            return;
                          }
                          controller
                              .updateSelectedOrganization(value.toString());
                        },
                        controller: organizationTextCon,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownTextField(
                        autoValidateMode: AutovalidateMode.disabled,
                        labelText: "នាយកដ្ឋាន",
                        currentSelectedValue: controller.selectedDepartment,
                        listString: departments.cast(),
                        onChange: (value) {
                          if (value == null) {
                            return;
                          }
                          controller.selectedDepartment = value.toString();
                        },
                        controller: departmentTextCon,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.showDegreeField)
                        Column(
                          children: [
                            DropdownTextField(
                              labelText: "ប្រភេទវិញ្ញាបនបត្រ",
                              listString: controller.degrees.keys.toList(),
                              onChange: (value) {
                                if (value == null) {
                                  return;
                                }
                                controller.selectedDegrees = value.toString();
                              },
                              currentSelectedValue: controller.selectedDegrees,
                              controller: departmentTextCon,
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            confirmData();
                            popBack();
                          },
                          child: const Text("ស្វែងរក"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum RadioValue {
  all,
  nation,
  underNation,
}
