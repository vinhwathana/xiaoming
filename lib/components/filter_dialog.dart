import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';
import 'package:xiaoming/controllers/filter_dialog_controller.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    Key? key,
    this.onChange,
  }) : super(key: key);

  final Function()? onChange;

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> slideAnimation;
  final departmentTextCon = TextEditingController(),
      organizationTextCon = TextEditingController();
  final filterDialogController = Get.put(FilterDialogController());

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    slideAnimation = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  void popBack() {
    controller.reverse();
    Get.back();
    controller.dispose();
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
            onTap: () {
              ;
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              // height: Get.height / 2.7,
              width: Get.width,
              decoration: BoxDecoration(color: Colors.white),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filter Data"),
                          RawMaterialButton(
                            onPressed: () {
                              // Get.back();
                            },
                            child: Icon(
                              Icons.check,
                              size: 28,
                            ),
                            padding: EdgeInsets.all(0),
                            shape: CircleBorder(),
                          )
                        ],
                      ),
                      //3 Radio Buttons
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
                          // controller.selectedOrganization = value.toString();
                          controller
                              .updateSelectedOrganization(value.toString());
                        },
                        controller: organizationTextCon,
                      ),

                      SizedBox(
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
                      SizedBox(
                        height: 20,
                      ),
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
                      SizedBox(
                        height: 20,
                      )
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
