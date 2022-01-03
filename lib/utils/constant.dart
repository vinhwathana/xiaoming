import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaoming/colors/company_colors.dart';

const String tokenKeyName = "token";

String? validateEmail(String value) {
  if (value.isEmpty) {
    return "Empty field";
  }
  return (value.contains('@') && value.contains('.'))
      ? null
      : "Enter a valid email";
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return "Empty field";
  }
  return (value.length < 6) ? "Enter at least 6 char" : null;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 18,
    backgroundColor: CompanyColors.blue,
    textColor: CompanyColors.yellow,
  );
}

DateTime? currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    showToast("ចុចម្តងទៀតដើម្បីចាកចេញ");
    return Future.value(false);
  }
  return Future.value(true);
}

void requestFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
