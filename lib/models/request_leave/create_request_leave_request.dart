// To parse this JSON data, do
//
//     final createRequestLeaveRequest = createRequestLeaveRequestFromJson(jsonString);

import 'dart:convert';

import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/utils/constant.dart';

CreateRequestLeaveRequest createRequestLeaveRequestFromJson(String str) =>
    CreateRequestLeaveRequest.fromJson(json.decode(str));

String createRequestLeaveRequestToJson(CreateRequestLeaveRequest data) =>
    json.encode(data.toJson());

class CreateRequestLeaveRequest {
  CreateRequestLeaveRequest({
    required this.leaveType,
    this.leaveSubType,
    required this.ministry,
    required this.employeeId,
    required this.dateFrom,
    required this.dateTo,
    required this.days,
    required this.reasons,
    required this.am,
    required this.pm,
    required this.attachmentList,
  });

  String leaveType;
  String? leaveSubType;
  int ministry;
  int employeeId;
  DateTime dateFrom;
  DateTime dateTo;
  int days;
  String reasons;
  bool am;
  bool pm;
  List<Attachment> attachmentList;

  factory CreateRequestLeaveRequest.fromJson(Map<String, dynamic> json) =>
      CreateRequestLeaveRequest(
        leaveType: json["LeaveType"],
        leaveSubType: json["LeaveSubType"],
        ministry: json["Ministry"],
        employeeId: json["EmployeeID"],
        dateFrom: json["DateFrom"],
        dateTo: DateTime.parse(json["DateTo"]),
        days: json["Days"],
        reasons: json["Reasons"],
        am: json["AM"],
        pm: json["PM"],
        attachmentList: List<Attachment>.from(
            json["attachmentList"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "LeaveType": leaveType,
        "LeaveSubType": leaveSubType,
        "Ministry": ministry,
        "EmployeeID": employeeId,
        "DateFrom": formatDateTimeForApi(dateFrom),
        "DateTo": formatDateTimeForApi(dateTo),
        "Days": days,
        "Reasons": reasons,
        "AM": am,
        "PM": pm,
        "attachmentList":
            List<dynamic>.from(attachmentList.map((x) => x.toJson())),
      };
}

// class AttachmentList {
//   AttachmentList({
//     required this.id,
//     required this.attachmentType,
//     required this.entityId,
//     required this.fileName,
//     required this.extension,
//     required this.filePath,
//   });
//
//   int id;
//   String attachmentType;
//   int entityId;
//   String fileName;
//   String extension;
//   String filePath;
//
//   factory AttachmentList.fromJson(Map<String, dynamic> json) => AttachmentList(
//         id: json["Id"],
//         attachmentType: json["AttachmentType"],
//         entityId: json["EntityId"],
//         fileName: json["FileName"],
//         extension: json["Extension"],
//         filePath: json["FilePath"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "AttachmentType": attachmentType,
//         "EntityId": entityId,
//         "FileName": fileName,
//         "Extension": extension,
//         "FilePath": filePath,
//       };
// }
