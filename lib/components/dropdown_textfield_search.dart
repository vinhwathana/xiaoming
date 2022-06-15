import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/utils/constant.dart';

class DropdownTextFieldSearch extends StatefulWidget {
  const DropdownTextFieldSearch({
    Key? key,
    required this.labelText,
    this.controller,
    this.icon,
    this.prefixText,
    this.onPrefixIconClicked,
    this.inputType,
    this.currentSelectedValue,
    required this.listString,
    this.onClickTextField,
    required this.onChange,
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final IconData? icon;
  final String? prefixText;
  final TextInputType? inputType;
  final Function()? onPrefixIconClicked;
  final String? currentSelectedValue;
  final List<String> listString;
  final Function()? onClickTextField;
  final Function(Object? value) onChange;

  @override
  State<DropdownTextFieldSearch> createState() =>
      _DropdownTextFieldSearchState();
}

class _DropdownTextFieldSearchState extends State<DropdownTextFieldSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: CompanyColors.blue),
      ),
      child: SearchChoices.single(
        isExpanded: true,
        underline: Container(),
        hint: widget.labelText,
        closeButton: "បិទ",
        onClear: () {
          widget.onChange(allKeyword);
        },
        value: widget.currentSelectedValue,
        selectedValueWidgetFn: (item) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              item,
              textAlign: TextAlign.start,
            ),
          );
        },
        items: widget.listString.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                color: Colors.black,
                height: 1.5,
              ),
            ),
          );
        }).toList(),
        onChanged: widget.onChange,
      ),
    );
  }
}
