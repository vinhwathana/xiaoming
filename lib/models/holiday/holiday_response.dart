import 'dart:convert';

import 'package:xiaoming/utils/constant.dart';

HolidayResponse holidayResponseFromJson(String str) =>
    HolidayResponse.fromJson(json.decode(str));

String holidayResponseToJson(HolidayResponse data) =>
    json.encode(data.toJson());

class HolidayResponse {
  HolidayResponse({
    this.data,
    this.totalFilteredRecord = 0,
  });

  List<Holiday>? data;
  int totalFilteredRecord;

  factory HolidayResponse.fromJson(Map<String, dynamic> json) =>
      HolidayResponse(
        data: List<Holiday>.from(json["data"].map((x) => Holiday.fromJson(x))),
        totalFilteredRecord: json["totalFilteredRecord"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
        "totalFilteredRecord": totalFilteredRecord,
      };
}

class Holiday {
  Holiday({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.deletedBy,
    this.deletedAt,
    this.ministryCode,
  });

  int? id;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? status;
  dynamic createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  dynamic deletedBy;
  DateTime? deletedAt;
  String? ministryCode;

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        status: json["status"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedBy: json["updatedBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedBy: json["deletedBy"],
        deletedAt: DateTime.parse(json["deletedAt"]),
        ministryCode: json["ministryCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startDate": formatDateTimeForApi(startDate),
        "endDate": formatDateTimeForApi(endDate),
        "status": status,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedBy": deletedBy,
        "deletedAt": deletedAt?.toIso8601String(),
        "ministryCode": ministryCode,
      };
}
