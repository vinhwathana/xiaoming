import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'dart:convert';

import 'package:xiaoming/models/utils/ministry.dart';
import 'package:xiaoming/models/utils/organization.dart';

AttachmentList attachmentListFromMap(String str) =>
    AttachmentList.fromMap(json.decode(str));

String attachmentListToMap(AttachmentList data) => json.encode(data.toMap());

class AttachmentList {
  AttachmentList({
    required this.additionalPositions,
  });

  List<AdditionalPosition> additionalPositions;

  factory AttachmentList.fromMap(Map<String, dynamic> json) => AttachmentList(
        additionalPositions: List<AdditionalPosition>.from(
          json["additionalPositions"].map((x) => AdditionalPosition.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
        "additionalPositions":
            List<dynamic>.from(additionalPositions.map((x) => x.toMap())),
      };
}

class AdditionalPosition {
  AdditionalPosition({
    required this.id,
    required this.ministry,
    required this.startDate,
    required this.isStartDateYear,
    required this.endDate,
    required this.isEndDateYear,
    required this.ongoing,
    required this.organization,
    required this.workStatus,
    required this.position,
    required this.positionEqual,
    required this.remark,
    required this.attachmentList,
  });

  int? id;
  Ministry? ministry;
  String? startDate;
  bool? isStartDateYear;
  String? endDate;
  bool? isEndDateYear;
  bool? ongoing;
  List<Organization>? organization;
  ListValue? workStatus;
  String? position;
  ListValue? positionEqual;
  String? remark;
  List<Attachment?>? attachmentList;

  factory AdditionalPosition.fromMap(Map<String, dynamic> json) =>
      AdditionalPosition(
        id: json["id"],
        ministry: Ministry.fromMap(json["ministry"]),
        startDate: json["startDate"],
        isStartDateYear: json["isStartDateYear"],
        endDate: json["endDate"],
        isEndDateYear: json["isEndDateYear"],
        ongoing: json["ongoing"],
        organization: List<Organization>.from(
            json["organization"].map((x) => Organization.fromMap(x))),
        workStatus: ListValue.fromMap(json["workStatus"]),
        position: json["position"],
        positionEqual: ListValue.fromMap(json["positionEqual"]),
        remark: json["remark"],
        attachmentList: List<Attachment>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministry": ministry?.toMap(),
        "startDate": startDate,
        "isStartDateYear": isStartDateYear,
        "endDate": endDate,
        "isEndDateYear": isEndDateYear,
        "ongoing": ongoing,
        "organization":
            List<dynamic>.from(organization?.map((x) => x.toMap()) ?? []),
        "workStatus": workStatus?.toMap(),
        "position": position,
        "positionEqual": positionEqual?.toMap(),
        "remark": remark,
        "attachmentList":
            List<Attachment>.from(attachmentList?.map((x) => x?.toMap()) ?? []),
      };
}

class AttachmentListElement {
  AttachmentListElement({
    required this.id,
    required this.attachmentType,
    required this.entityId,
    required this.fileName,
    required this.extension,
    required this.filePath,
  });

  int id;
  String attachmentType;
  int entityId;
  String fileName;
  String extension;
  String filePath;
}
