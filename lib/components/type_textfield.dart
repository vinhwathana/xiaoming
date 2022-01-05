import 'package:flutter/material.dart';
import 'package:xiaoming/utils/constant.dart';

class TypeTextField extends StatelessWidget {
  const TypeTextField({
    Key? key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.iconData,
    this.keyboardType,
    required this.controller,
    this.autofillHints,
  }) : super(key: key);
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? iconData;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final TextEditingController controller;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: '$hintText',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: Icon(iconData),
      ),
      keyboardType: keyboardType ?? TextInputType.name,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Empty field";
            } else {
              return null;
            }
          },
      onSaved: onSaved,
    );
  }
}
