import 'package:flutter/material.dart';
import 'package:xiaoming/colors/company_colors.dart';

class TypeTextField extends StatefulWidget {
  const TypeTextField({
    Key? key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.iconData,
    this.keyboardType,
    required this.controller,
    this.autofillHints,
    this.hasObscureText,
    this.labelText,
    this.onEditingComplete,
    this.maxLength,
    this.enableInteractiveSelection = true,
  }) : super(key: key);
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? iconData;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final TextEditingController controller;
  final Iterable<String>? autofillHints;
  final bool? hasObscureText;
  final String? labelText;
  final Function()? onEditingComplete;
  final int? maxLength;
  final bool enableInteractiveSelection;

  @override
  State<TypeTextField> createState() => _TypeTextFieldState();
}

class _TypeTextFieldState extends State<TypeTextField> {
  bool _secureText = false;

  bool obscureText() {
    if (widget.hasObscureText == null) {
      return false;
    } else {
      return !_secureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: widget.autofillHints,
      maxLength: widget.maxLength,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: '${widget.hintText}',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CompanyColors.blue),
        ),
        suffixIcon: widget.hasObscureText == null
            ? Icon(widget.iconData)
            : IconButton(
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
                icon: Icon(
                  _secureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                ),
              ),
      ),
      obscureText: obscureText(),
      keyboardType: widget.keyboardType ?? TextInputType.name,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "សូមបំពេញវាលនេះ";
            } else {
              return null;
            }
          },
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
