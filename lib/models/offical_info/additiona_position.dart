import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/models/utils/ministry.dart';
import 'package:xiaoming/models/utils/organization.dart';

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

  int id;
  Ministry ministry;
  DateTime startDate;
  bool isStartDateYear;
  DateTime endDate;
  bool isEndDateYear;
  bool ongoing;
  List<Organization> organization;
  ListValue workStatus;
  String position;
  ListValue positionEqual;
  String remark;
  List<dynamic> attachmentList;

  factory AdditionalPosition.fromMap(Map<String, dynamic> json) =>
      AdditionalPosition(
        id: json["id"],
        ministry: Ministry.fromMap(json["ministry"]),
        startDate: DateTime.parse(json["startDate"]),
        isStartDateYear: json["isStartDateYear"],
        endDate: DateTime.parse(json["endDate"]),
        isEndDateYear: json["isEndDateYear"],
        ongoing: json["ongoing"],
        organization: List<Organization>.from(
            json["organization"].map((x) => Organization.fromMap(x))),
        workStatus: ListValue.fromMap(json["workStatus"]),
        position: json["position"],
        positionEqual: ListValue.fromMap(json["positionEqual"]),
        remark: json["remark"],
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministry": ministry.toMap(),
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "isStartDateYear": isStartDateYear,
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "isEndDateYear": isEndDateYear,
        "ongoing": ongoing,
        "organization": List<dynamic>.from(organization.map((x) => x.toMap())),
        "workStatus": workStatus.toMap(),
        "position": position,
        "positionEqual": positionEqual.toMap(),
        "remark": remark,
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
      };
}
