// To parse this JSON data, do
//
//     final certificatePeopleStatResponse = certificatePeopleStatResponseFromJson(jsonString);

import 'dart:convert';

import 'package:xiaoming/models/statistic/people/statistic_people.dart';

StatisticPeopleResponse certificateSkillPeopleStatResponseFromJson(
        String str) =>
    StatisticPeopleResponse.fromJson(json.decode(str));

String certificateSkillPeopleStatResponseToJson(
        StatisticPeopleResponse data) =>
    json.encode(data.toJson());

class StatisticPeopleResponse {
  StatisticPeopleResponse({
    required this.data,
    required this.totalFilteredRecord,
  });

  List<StatisticPeople> data;
  int totalFilteredRecord;

  factory StatisticPeopleResponse.fromJson(Map<String, dynamic> json) {
    return StatisticPeopleResponse(
      data: List<StatisticPeople>.from(
        json["data"].map((x) {
          try {
            return StatisticPeople.fromJson(x);
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
