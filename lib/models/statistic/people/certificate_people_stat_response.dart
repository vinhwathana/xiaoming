// To parse this JSON data, do
//
//     final certificatePeopleStatResponse = certificatePeopleStatResponseFromJson(jsonString);

import 'dart:convert';

import 'package:xiaoming/models/statistic/people/certificate_people_stat.dart';

CertificatePeopleStatResponse certificatePeopleStatResponseFromJson(
        String str) =>
    CertificatePeopleStatResponse.fromJson(json.decode(str));

String certificatePeopleStatResponseToJson(
        CertificatePeopleStatResponse data) =>
    json.encode(data.toJson());

class CertificatePeopleStatResponse {
  CertificatePeopleStatResponse({
    required this.data,
    required this.totalFilteredRecord,
  });

  List<CertificatePeopleStat> data;
  int totalFilteredRecord;

  factory CertificatePeopleStatResponse.fromJson(Map<String, dynamic> json) {
    return CertificatePeopleStatResponse(
      data: List<CertificatePeopleStat>.from(
        json["data"].map((x) {
          try {
            return CertificatePeopleStat.fromJson(x);
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
