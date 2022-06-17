import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors/company_colors.dart';

class CustomTypeTextField extends StatefulWidget {
  const CustomTypeTextField({
    Key? key,
    required this.labelText,
    this.maxLength,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.inputType,
    this.validator,
    this.obscureText,
    this.autoFillHints,
    this.buildCounter,
    this.hint,
    this.onEditingComplete,
    this.maxLines,
    this.textInputAction,
  }) : super(key: key);

  final TextInputType? inputType;
  final String labelText;
  final int? maxLength;
  final String? prefix;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool? obscureText;
  final Iterable<String>? autoFillHints;
  final InputCounterWidgetBuilder? buildCounter;
  final String? hint;
  final Function()? onEditingComplete;
  final int? maxLines;
  final TextInputAction? textInputAction;

  @override
  _CustomTypeTextFieldState createState() => _CustomTypeTextFieldState();
}

class _CustomTypeTextFieldState extends State<CustomTypeTextField> {
  final FocusNode _focus = FocusNode();
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
    return TextFormField(
      autofillHints: widget.autoFillHints,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      textAlign: TextAlign.start,
      focusNode: _focus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      buildCounter: widget.buildCounter,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.inputType ?? TextInputType.name,
      cursorHeight: 24,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: Get.locale == const Locale('en', 'US') ? 23 : 15,
          horizontal: 16,
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          color: decideColor(),
        ),
        labelText: widget.labelText,
        prefixText: widget.prefix,
        prefixStyle: const TextStyle(
          fontSize: 16,
          letterSpacing: 2,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: CompanyColors.blue,
            width: 1.0,
          ),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        counterStyle: const TextStyle(
          fontSize: 12,
          height: 1,
        ),
        hintText: widget.hint,
      ),
      validator: widget.validator ??
          (value) {
            if (value != null && value.isEmpty) {
              return 'Empty Field';
            }
            return null;
          },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onEditingComplete;
      },
      textInputAction: widget.textInputAction,
    );
  }
}
