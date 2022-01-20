import 'dart:convert';

import 'package:xiaoming/models/offical_info/offical_info.dart';

import 'offical_info/additiona_position.dart';
import 'offical_info/education.dart';
import 'offical_info/family_info.dart';
import 'offical_info/krob_khan.dart';
import 'offical_info/language.dart';
import 'offical_info/merit.dart';
import 'offical_info/work_history.dart';

class User {
  User({
    this.employeeId,
    this.officialInfo,
    this.familyInfos,
    this.workHistories,
    required this.additionalPositions,
    required this.educations,
    required this.languages,
    required this.krobKhans,
    required this.merits,
  });

  int? employeeId;
  OfficialInfo? officialInfo;
  List<FamilyInfo>? familyInfos;
  List<WorkHistory>? workHistories;
  List<AdditionalPosition>? additionalPositions;
  List<Education>? educations;
  List<Language>? languages;
  List<KrobKhan>? krobKhans;
  List<Merit>? merits;

  factory User.fromMap(Map<String, dynamic> json) => User(
        employeeId: json["employeeId"],
        officialInfo: OfficialInfo.fromMap(json["officialInfo"]),
        familyInfos: List<FamilyInfo>.from(
            json["familyInfos"].map((x) => FamilyInfo.fromMap(x))),
        workHistories: List<WorkHistory>.from(
            json["workHistories"].map((x) => WorkHistory.fromMap(x))),
        additionalPositions: List<AdditionalPosition>.from(
            json["additionalPositions"]
                .map((x) => AdditionalPosition.fromMap(x))),
        educations: List<Education>.from(
            json["educations"].map((x) => Education.fromMap(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromMap(x))),
        krobKhans: List<KrobKhan>.from(
            json["krobKhans"].map((x) => KrobKhan.fromMap(x))),
        merits: List<Merit>.from(json["merits"].map((x) => Merit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId,
        "officialInfo": officialInfo!.toMap(),
        "familyInfos": List<dynamic>.from(familyInfos!.map((x) => x.toMap())),
        "workHistories":
            List<dynamic>.from(workHistories!.map((x) => x.toMap())),
        "additionalPositions":
            List<dynamic>.from(additionalPositions!.map((x) => x.toMap())),
        "educations": List<dynamic>.from(educations!.map((x) => x.toMap())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toMap())),
        "krobKhans": List<dynamic>.from(krobKhans!.map((x) => x.toMap())),
        "merits": List<dynamic>.from(merits!.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'User{employeeId: $employeeId, officialInfo: $officialInfo, familyInfos: $familyInfos, workHistories: $workHistories, additionalPositions: $additionalPositions, educations: $educations, languages: $languages, krobKhans: $krobKhans, merits: $merits}';
  }
}
