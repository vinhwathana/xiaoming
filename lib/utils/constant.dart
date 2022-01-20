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

final dummyFamilyInfo = FamilyInfo(
  relation: ListValue(
    lovCode: "005002",
    lovType: "RELATION",
    nameKh: "កូន",
    nameEn: "Son",
  ),
  firstNameEn: "Sann",
  lastNameEn: "Chesda",
  firstNameKh: "សាន់",
  lastNameKh: "ចេស្តា",
  dateOfBirth: DateTime.now(),
  gender: "M",
  maritalStatus: ListValue(
    lovCode: "005002",
    lovType: "RELATION",
    nameKh: "កូន",
    nameEn: "Son",
  ),
  status: "AL",
  race: ListValue(
    lovCode: "002001",
    lovType: "RACE",
    nameKh: "ខ្មែរ",
    nameEn: "Khmer",
  ),
  nationality: ListValue(
    lovCode: "003001",
    lovType: "NATIONALITY",
    nameKh: "ខ្មែរ",
    nameEn: "Khmer",
  ),
  job: ListValue(
    lovCode: "006007",
    lovType: "JOB",
    nameKh: "ពាណិជ្ជករ",
    nameEn: "",
  ),
  currentAddressProvince: Address(
    parentsCode: "",
    addressCode: "05",
    addressNameKh: "ខេត្តកំពង់ស្ពឺ",
    addressNameEn: "Kampong Speu Province",
  ),
  currentAddressDistrict: Address(
    parentsCode: "",
    addressCode: "05",
    addressNameKh: "ខេត្តកំពង់ស្ពឺ",
    addressNameEn: "Kampong Speu Province",
  ),
  currentAddressCommune: Address(
    parentsCode: "",
    addressCode: "05",
    addressNameKh: "ខេត្តកំពង់ស្ពឺ",
    addressNameEn: "Kampong Speu Province",
  ),
  currentAddressVillage: Address(
    parentsCode: "",
    addressCode: "05",
    addressNameKh: "ខេត្តកំពង់ស្ពឺ",
    addressNameEn: "Kampong Speu Province",
  ),
);

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

Future<void> storeToken(String token) async {
  final controller = Get.put(AuthenticationController());
  controller.accessToken = token;
  final storage = FlutterSecureStorage();
  return await storage.write(key: "$tokenKeyName", value: token);
}

String formatDateTime(DateTime? date) {
  if (date == null) {
    return "";
  }
  final intToMonth = DateFormat('dd-MM-yyyy');
  final formattedDate = intToMonth.format(date);
  return formattedDate;
  // if (Get.locale == Locale('en', 'US')) {
  //   return formattedDate;
  // }
  // return KhmerDate.khmerNumber(formattedDate);
}

String generateAddress({
  required Address? province,
  required Address? commune,
  required Address? district,
  required Address? village,
}) {
  // Correct Format : Village , Commune , District , Province
  if (Get.locale == Locale('en', 'US')) {
    return "${village?.addressNameEn ?? ""} ${commune?.addressNameEn ?? ""} ${district?.addressNameEn ?? ""} ${province?.addressNameEn ?? ""}";
  }
  return "${village?.addressNameKh ?? ""} ${commune?.addressNameKh ?? ""} ${district?.addressNameKh ?? ""} ${province?.addressNameKh ?? ""}";
}

String decideEnumValue(ListValue? value) {
  if (value == null) {
    return "";
  }
  if (Get.locale == Locale('en', 'US')) {
    return value.nameEn;
  }
  return value.nameKh;
}

String formatPhoneNumber(String? phoneNumber) {
  if (phoneNumber == null) {
    return "";
  }
  if (Get.locale == Locale('en', 'US')) {
    return addSpacePerThreeChar(phoneNumber);
  }
  return KhmerDate.khmerNumber(
    addSpacePerThreeChar(phoneNumber),
  );
}

String addSpacePerThreeChar(String value) {
  // const int perChar = 4;
  if (value.length < 9) {
    return value;
  }
  return value.replaceAllMapped(
      RegExp(r".{3}"), (match) => "${match.group(0)} ");
}
