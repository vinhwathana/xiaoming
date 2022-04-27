// To parse this JSON data, do
//
//     final certificatePeopleStatResponse = certificatePeopleStatResponseFromJson(jsonString);

import 'dart:convert';

import 'package:xiaoming/models/statistic/people/certificate_skill_people_stat.dart';

CertificateSkillPeopleStatResponse certificateSkillPeopleStatResponseFromJson(
        String str) =>
    CertificateSkillPeopleStatResponse.fromJson(json.decode(str));

String certificateSkillPeopleStatResponseToJson(
        CertificateSkillPeopleStatResponse data) =>
    json.encode(data.toJson());

class CertificateSkillPeopleStatResponse {
  CertificateSkillPeopleStatResponse({
    required this.data,
    required this.totalFilteredRecord,
  });

  List<CertificateSkillPeopleStat> data;
  int totalFilteredRecord;

  factory CertificateSkillPeopleStatResponse.fromJson(Map<String, dynamic> json) {
    return CertificateSkillPeopleStatResponse(
      data: List<CertificateSkillPeopleStat>.from(
        json["data"].map((x) {
          try {
            return CertificateSkillPeopleStat.fromJson(x);
          } catch (e) {
            print(e.toString());
          }
        }),
      ),
      totalFilteredRecord: json["totalFilteredRecord"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalFilteredRecord": totalFilteredRecord,
      };
}
