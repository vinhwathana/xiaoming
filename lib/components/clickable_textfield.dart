import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';

class ClickableTextField extends StatefulWidget {
  const ClickableTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.icon,
    this.prefix,
    this.suffixIcon,
    this.onPrefixIconClicked,
    this.inputType,
    required this.onClickTextField,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final IconData? icon;
  final Icon? suffixIcon;
  final String? prefix;
  final TextInputType? inputType;
  final Function()? onPrefixIconClicked;
  final Function() onClickTextField;

  @override
  _ClickableTextFieldState createState() => _ClickableTextFieldState();
}

class _ClickableTextFieldState extends State<ClickableTextField> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        enableInteractiveSelection: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: widget.onClickTextField,
        controller: widget.controller,
        focusNode: AlwaysDisabledFocusNode(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: Get.locale == const Locale('en', 'US') ? 23 : 15,
            horizontal: 16,
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            color: widget.controller.text.isEmpty
                ? CompanyColors.black.shade400
                : CompanyColors.yellow,
            // fontFamily: getFont(),
          ),
          labelText: widget.labelText,
          prefixText: widget.prefix,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CompanyColors.blue,
              width: 1.0,
            ),
          ),
          prefixIcon: (widget.icon == null)
              ? null
              : IconButton(
                  icon: Icon(widget.icon),
                  onPressed: (widget.onPrefixIconClicked == null)
                      ? () {}
                      : widget.onPrefixIconClicked,
                  color: CompanyColors.yellow,
                ),
          suffixIcon: widget.suffixIcon,
          counterStyle: const TextStyle(
            fontSize: 12,
            height: 1,
          ),
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
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
