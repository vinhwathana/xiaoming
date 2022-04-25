import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';

class FilterDropdownTextField extends StatefulWidget {
  const FilterDropdownTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.icon,
    this.prefixText,
    this.onPrefixIconClicked,
    this.inputType,
    this.currentSelectedValue,
    required this.listString,
    this.onClickTextField,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
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
  final Function(Object? value)? onChange;
  final AutovalidateMode autoValidateMode;

  @override
  _FilterDropdownTextFieldState createState() =>
      _FilterDropdownTextFieldState();
}

class _FilterDropdownTextFieldState extends State<FilterDropdownTextField> {
  final FocusNode _focus = AlwaysDisabledFocusNode();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocus = _focus.hasFocus;
    });
  }

  Color decideColor() {
    if (isFocus || widget.controller!.text.isNotEmpty) {
      return CompanyColors.yellow;
    } else {
      return CompanyColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField(
        autovalidateMode: widget.autoValidateMode,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        focusNode: _focus,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 16,
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            color: CompanyColors.yellow,
            height: 2,
          ),
          labelText:
              (widget.currentSelectedValue != null) ? widget.labelText : "",
          prefixText: widget.prefixText,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CompanyColors.blue,
              width: 1.0,
            ),
          ),
          prefixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  color: CompanyColors.yellow,
                ),
          counterStyle: const TextStyle(
            fontSize: 12,
            height: 1,
          ),
        ),
        isExpanded: true,
        hint: Text(
          widget.labelText,
          style: TextStyle(
            fontSize: 16,
            color: decideColor(),
            height: 1,
          ),
        ),
        value: widget.currentSelectedValue,
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
        validator: (value) {
          if (value == null || value.toString().isEmpty) {
            return 'emptyField'.tr;
          }
          return null;
        },
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
