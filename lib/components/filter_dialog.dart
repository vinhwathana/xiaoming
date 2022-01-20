import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/dropdown_textfield.dart';

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({
    Key? key,
    this.onChange,
  }) : super(key: key);

  final Function()? onChange;

  @override
  _FiltersDialogState createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  final departmentTextCon = TextEditingController();

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

  RadioValue selectedValue = RadioValue.all;
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

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(20.0),
            // height: Get.height / 2.7,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Filter Data"),
                //     RawMaterialButton(
                //       onPressed: () {
                //         // Get.back();
                //       },
                //       child: Icon(
                //         Icons.check,
                //         size: 28,
                //       ),
                //       padding: EdgeInsets.all(0),
                //       shape: CircleBorder(),
                //     )
                //   ],
                // ),
                Row(
                    children: List.generate(
                  radioValues.length,
                  (index) {
                    return Row(
                      children: [
                        Radio<RadioValue>(
                          activeColor: CompanyColors.yellow,
                          value: radioValues[index],
                          groupValue: selectedValue,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        Text(radioText[index]),
                      ],
                    );
                  },
                )

                    // [

                    // Radio<RadioValue>(
                    //   activeColor: CompanyColors.yellow,
                    //   value: RadioValue.all,
                    //   groupValue: selectedValue,
                    //   onChanged: (value) {
                    //     if(value == null){
                    //       return;
                    //     }
                    //     setState(() {
                    //       selectedValue = value;
                    //     });
                    //   },
                    // ),
                    // Radio<RadioValue>(
                    //   value: RadioValue.nation,
                    //   groupValue: selectedValue,
                    //   onChanged: (value) {
                    //     if(value == null){
                    //       return;
                    //     }
                    //     setState(() {
                    //       selectedValue = value;
                    //     });
                    //   },
                    // ),
                    // Radio<RadioValue>(
                    //   value: RadioValue.underNation,
                    //   groupValue: selectedValue,
                    //   onChanged: (value) {
                    //     if(value == null){
                    //       return;
                    //     }
                    //     setState(() {
                    //       selectedValue = value;
                    //     });
                    //   },
                    // ),
                    // ],
                    ),
                Column(
                  children: [
                    DropdownTextField(
                      labelText: "lae",
                      listString: ["1", "2", "3"],
                      onChange: (value) {},
                      controller: departmentTextCon,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownTextField(
                      labelText: "lae",
                      listString: ["1", "2", "3"],
                      onChange: (value) {},
                      controller: departmentTextCon,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownTextField(
                      labelText: "lae",
                      listString: ["1", "2", "3"],
                      onChange: (value) {},
                      controller: departmentTextCon,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
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
