import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khmer_date/khmer_date.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/offical_info/family_info.dart';
import 'package:xiaoming/models/utils/address.dart';
import 'package:xiaoming/models/utils/list_value.dart';

const String tokenKeyName = "token";
const String expiredToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNhbm5jaGVzZGE4OTgxQGdtYWlsLmNvbSIsIlVzZXJJZCI6Ijg4NSIsIk1pbmlzdHJ5Q29kZSI6IjIwIiwiT2ZmaWNpYWxJZCI6IjAxMjM0NTY3ODAiLCJFbXBsb3llZUlkIjoiIiwiRW1wbG95ZWVJZF9OZXciOiIxNzMwIiwiRW1haWwiOiJzYW5uY2hlc2RhODk4MUBnbWFpbC5jb20iLCJDaGFuZ2VQYXNzd29yZCI6IlRydWUiLCJuYmYiOjE2NDEyMDA1ODksImV4cCI6MTY0MTIwNTk4OSwiaWF0IjoxNjQxMjAwNTg5fQ.o3EcOZtV5u-XO2PZD5BQ9zOBYF004n-WadypCGtFsSc";
const String changePasswordToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNhbm5jaGVzZGE4OTgxQGdtYWlsLmNvbSIsIlVzZXJJZCI6Ijg4NSIsIk1pbmlzdHJ5Q29kZSI6IjIwIiwiT2ZmaWNpYWxJZCI6IjAxMjM0NTY3ODAiLCJFbXBsb3llZUlkIjoiIiwiRW1wbG95ZWVJZF9OZXciOiIxNzMwIiwiRW1haWwiOiJzYW5uY2hlc2RhODk4MUBnbWFpbC5jb20iLCJDaGFuZ2VQYXNzd29yZCI6IlRydWUiLCJuYmYiOjE2NDE0NTE0OTIsImV4cCI6MTY0MTQ1Njg5MiwiaWF0IjoxNjQxNDUxNDkyfQ.X7AP9noqOB-CB07kDvtHEhNrcjsy0WQENDNuC2BHM2c";

const String dummyNetworkImage = "https://wallpaperaccess.com/full/1313700.jpg";

const String allKeyword = "(ទាំងអស់)";
const String khmerFont = "KhmerMPTC";
const String khmerFontBold = "KhmerMPTC";
const fontKhmerTextStyle = TextStyle(
  fontFamily: khmerFont,
);
const tableHeaderTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: khmerFont,
  fontWeight: FontWeight.bold,
);
const tableDataTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: khmerFont,
  height: 1.5,
);

const TextStyle columnHeaderTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: khmerFont,
  fontWeight: FontWeight.bold,
);

final List<int> typeOfEntries = [10, 25, 50, 100];

String? validateEmail(String value) {
  if (value.isEmpty) {
    return "emptyField".tr;
  }
  return (value.contains('@') && value.contains('.'))
      ? null
      : "enterValidEmail".tr;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return "emptyField".tr;
  }
  return (value.length < 6) ? "enterMoreThan6Char".tr : null;
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
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    showToast("ចុចម្តងទៀតដើម្បីចាកចេញ");
    return Future.value(false);
  }
  return Future.value(true);
}

void requestFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Future<void> storeToken(String token) async {
  final controller = Get.put(AuthenticationController());
  controller.accessToken = token;
  const storage = FlutterSecureStorage();
  return await storage.write(key: tokenKeyName, value: token);
}

final formatNameOfDate = DateFormat("EEEE", "en");

final dateMonthNameFormat = DateFormat('dd-MMMM-yyyy', "km");
final dateTimeMonthNameFormat = DateFormat('dd-MMMM-yyyy hh:mm:ss', "km");

String formatDateForView(dynamic date) {
  if (date == null) {
    return "";
  }
  if (date is String) {
    final convertedDate = DateTime.tryParse(date);
    if (convertedDate == null) {
      return date;
    }
    final formattedDate = dateMonthNameFormat.format(convertedDate);
    return formattedDate;
  }

  if (date is DateTime) {
    final formattedDate = dateMonthNameFormat.format(date);
    return formattedDate;
  }
  return date?.toString() ?? "";
}

String formatDateTimeForView(dynamic date) {
  if (date == null) {
    return "";
  }
  if (date is String) {
    final convertedDate = DateTime.tryParse(date);
    if (convertedDate == null) {
      return date;
    }
    final formattedDate = dateTimeMonthNameFormat.format(convertedDate);
    return formattedDate;
  }

  if (date is DateTime) {
    final formattedDate = dateTimeMonthNameFormat.format(date);
    return formattedDate;
  }
  return date?.toString() ?? "";
}

//For attendance
String formatDateTimeForApi(DateTime? date) {
  if (date == null) {
    return "";
  }
  final intToMonth = DateFormat('yyyy-MM-dd');
  final formattedDate = intToMonth.format(date);
  return formattedDate;
}

String formatStringForApi(String? date) {
  if (date == null) {
    return "";
  }
  final convertedDateTime = DateTime.tryParse(date);
  if (convertedDateTime == null) {
    return "";
  }

  final intToMonth = DateFormat('yyyy-MM-dd');
  final formattedDate = intToMonth.format(convertedDateTime);
  return formattedDate;
}

String generateAddress({
  required Address? province,
  required Address? commune,
  required Address? district,
  required Address? village,
}) {
  // Correct Format : Village , Commune , District , Province
  if (Get.locale == const Locale('en', 'US')) {
    return "${village?.addressNameEn ?? ""} ${commune?.addressNameEn ?? ""} ${district?.addressNameEn ?? ""} ${province?.addressNameEn ?? ""}";
  }
  return "${village?.addressNameKh ?? ""} ${commune?.addressNameKh ?? ""} ${district?.addressNameKh ?? ""} ${province?.addressNameKh ?? ""}";
}

String decideEnumValue(ListValue? value) {
  if (value == null) {
    return "";
  }
  if (Get.locale == const Locale('en', 'US')) {
    return value.nameEn ?? "";
  }
  return value.nameKh ?? "";
}

String formatPhoneNumber(String? phoneNumber) {
  if (phoneNumber == null) {
    return "";
  }
  if (Get.locale == const Locale('en', 'US')) {
    return addSpacePerThreeChar(phoneNumber);
  }
  return KhmerDate.khmerNumber(
    addSpacePerThreeChar(phoneNumber),
  );
}

String addSpacePerThreeChar(String value) {
  if (value.length < 9) {
    return value;
  }
  return value.replaceAllMapped(
      RegExp(r".{3}"), (match) => "${match.group(0)} ");
}

int? checkDynamicId(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is int) {
    return data;
  }
  if (data is String) {
    if (data.isEmpty) {
      return null;
    }
    return int.parse(data);
  }
  return null;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
