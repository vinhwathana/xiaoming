import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaoming/colors/company_colors.dart';

const String tokenKeyName = "token";
const String expiredToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNhbm5jaGVzZGE4OTgxQGdtYWlsLmNvbSIsIlVzZXJJZCI6Ijg4NSIsIk1pbmlzdHJ5Q29kZSI6IjIwIiwiT2ZmaWNpYWxJZCI6IjAxMjM0NTY3ODAiLCJFbXBsb3llZUlkIjoiIiwiRW1wbG95ZWVJZF9OZXciOiIxNzMwIiwiRW1haWwiOiJzYW5uY2hlc2RhODk4MUBnbWFpbC5jb20iLCJDaGFuZ2VQYXNzd29yZCI6IlRydWUiLCJuYmYiOjE2NDEyMDA1ODksImV4cCI6MTY0MTIwNTk4OSwiaWF0IjoxNjQxMjAwNTg5fQ.o3EcOZtV5u-XO2PZD5BQ9zOBYF004n-WadypCGtFsSc";

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
