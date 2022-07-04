// To parse this JSON data, do
//
//     final personalRequestLeaveList = personalRequestLeaveListFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/utils/constant.dart';

PersonalRequestLeaveList personalRequestLeaveListFromJson(String str) =>
    PersonalRequestLeaveList.fromJson(json.decode(str));

String personalRequestLeaveListToJson(PersonalRequestLeaveList data) =>
    json.encode(data.toJson());

class PersonalRequestLeaveList {
  PersonalRequestLeaveList({
    this.data,
    this.totalFilteredRecord,
  });

  List<RequestLeaveData>? data;
  int? totalFilteredRecord;

  factory PersonalRequestLeaveList.fromJson(Map<String, dynamic> json) =>
      PersonalRequestLeaveList(
        data: List<RequestLeaveData>.from(
            json["data"].map((x) => RequestLeaveData.fromJson(x))),
        totalFilteredRecord: json["totalFilteredRecord"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
        "totalFilteredRecord": totalFilteredRecord,
      };
}

class RequestLeaveData {
  RequestLeaveData({
    this.id,
    this.firstNameEn,
    this.lastNameEn,
    this.firstNameKh,
    this.lastNameKh,
    this.leaveType,
    this.leaveTypeKh,
    this.leaveSubType,
    this.dateFrom,
    this.dateTo,
    this.days,
    this.reasons,
    this.status,
    this.ministry,
    this.employeeId,
    this.gender,
    this.am,
    this.pm,
    this.contactPhone,
    this.department,
    this.position,
    this.office,
    this.createdAt,
    this.attachmentList,
    this.requestLeaveProcess,
  });

  int? id;
  String? firstNameEn;
  String? lastNameEn;
  String? firstNameKh;
  String? lastNameKh;
  String? leaveType;
  String? leaveTypeKh;
  String? leaveSubType;
  String? dateFrom;
  String? dateTo;
  String? days;
  String? reasons;
  String? status;
  dynamic ministry;
  int? employeeId;
  dynamic gender;
  bool? am;
  bool? pm;
  dynamic contactPhone;
  dynamic department;
  dynamic position;
  dynamic office;
  String? createdAt;
  List<Attachment>? attachmentList;
  dynamic requestLeaveProcess;

  String get getStatus {
    if (status == "A") {
      return "អនុម័ត";
    }
    if (status == "R") {
      return "បដិសេធ";
    }
    return "កំពុងរង់ចាំ";
  }

  Color get getColor {
    if (status == "A") {
      return Colors.green;
    }
    if (status == "R") {
      return CompanyColors.red;
    }
    return CompanyColors.yellow;
  }

  final dateTimeFormat = DateFormat('dd-MM-yyyy hh:mm:ss');
  final dateFormat = DateFormat('MM-dd-yyyy');

  String formatDateTime(String? date) {
    if (date == null) {
      return "";
    }
    final parsedDate = dateTimeFormat.parse(date);

    return formatDateTimeForView(parsedDate);
  }

  String formatDate(String? date) {
    if (date == null) {
      return "";
    }
    final parsedDate = dateFormat.parse(date);

    return formatDateForView(parsedDate);
  }

  String getDateFrom() {
    return formatDate(dateFrom);
  }

  String getDateTo() {
    return formatDate(dateTo);
  }

  String getDateCreated() {
    return formatDateTime(createdAt);
  }

  static String? removeSlashToDash(String? date) {
    return date?.replaceAll("/", "-");
  }

  factory RequestLeaveData.fromJson(Map<String, dynamic> json) {
    return RequestLeaveData(
      id: json["id"],
      firstNameEn: json["firstNameEN"],
      lastNameEn: json["lastNameEN"],
      firstNameKh: json["firstNameKH"],
      lastNameKh: json["lastNameKH"],
      leaveType: json["leaveType"],
      leaveTypeKh: json["leaveTypeKH"],
      leaveSubType: json["leaveSubType"],
      dateFrom: removeSlashToDash(json["dateFrom"]),
      dateTo: removeSlashToDash(json["dateTo"]),
      days: json["days"],
      reasons: json["reasons"],
      status: json["status"],
      ministry: json["ministry"],
      employeeId: json["employeeID"],
      gender: json["gender"],
      am: json["am"],
      pm: json["pm"],
      contactPhone: json["contactPhone"],
      department: json["department"],
      position: json["position"],
      office: json["office"],
      createdAt: json["createdAt"],
      attachmentList: List<Attachment>.from(
        json["attachmentList"].map((x) => Attachment.fromMap(x)),
      ),
      requestLeaveProcess: json["requestLeaveProcess"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstNameEN": firstNameEn,
        "lastNameEN": lastNameEn,
        "firstNameKH": firstNameKh,
        "lastNameKH": lastNameKh,
        "leaveType": leaveType,
        "leaveTypeKH": leaveTypeKh,
        "leaveSubType": leaveSubType,
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "days": days,
        "reasons": reasons,
        "status": status,
        "ministry": ministry,
        "employeeID": employeeId,
        "gender": gender,
        "am": am,
        "pm": pm,
        "contactPhone": contactPhone,
        "department": department,
        "position": position,
        "office": office,
        "createdAt": createdAt,
        "attachmentList":
            List<dynamic>.from(attachmentList?.map((x) => x.toJson()) ?? []),
        "requestLeaveProcess": requestLeaveProcess,
      };
}
