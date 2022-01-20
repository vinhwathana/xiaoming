import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/models/utils/ministry.dart';
import 'package:xiaoming/models/utils/organization.dart';
import 'package:xiaoming/models/utils/position.dart';

class WorkHistory {
  WorkHistory({
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

  int id;
  Ministry ministry;
  DateTime startDate;
  bool isStartDateYear;
  String? endDate;
  bool isEndDateYear;
  bool ongoing;
  List<Organization> organization;
  ListValue workStatus;
  Position position;
  dynamic positionEqual;
  String remark;
  List<Attachment?>? attachmentList;

  factory WorkHistory.fromMap(Map<String, dynamic> json) => WorkHistory(
        id: json["id"],
        ministry: Ministry.fromMap(json["ministry"]),
        startDate: DateTime.parse(json["startDate"]),
        isStartDateYear: json["isStartDateYear"],
        endDate: json["endDate"],
        isEndDateYear: json["isEndDateYear"],
        ongoing: json["ongoing"],
        organization: List<Organization>.from(
            json["organization"].map((x) => Organization.fromMap(x))),
        workStatus: ListValue.fromMap(json["workStatus"]),
        position: Position.fromMap(json["position"]),
        positionEqual: json["positionEqual"],
        remark: json["remark"],
        attachmentList: List<Attachment>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministry": ministry.toMap(),
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "isStartDateYear": isStartDateYear,
        "endDate": endDate,
        "isEndDateYear": isEndDateYear,
        "ongoing": ongoing,
        "organization": List<dynamic>.from(organization.map((x) => x.toMap())),
        "workStatus": workStatus.toMap(),
        "position": position.toMap(),
        "positionEqual": positionEqual,
        "remark": remark,
        "attachmentList":
            List<Attachment>.from(attachmentList?.map((x) => x?.toMap()) ?? []),
      };
}
