import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/utils/constant.dart';

class Education {
  Education({
    required this.id,
    required this.startDate,
    required this.isStartDateYear,
    required this.endDate,
    required this.isEndDateYear,
    required this.educationType,
    required this.educationLevel,
    required this.certificationType,
    required this.specialize,
    required this.schoolName,
    required this.isAbroad,
    required this.country,
    required this.city,
    required this.attachmentList,
    required this.remark,
  });

  int? id;
  String? startDate;
  bool? isStartDateYear;
  String? endDate;
  bool? isEndDateYear;
  ListValue? educationType;
  ListValue? educationLevel;
  ListValue? certificationType;
  ListValue? specialize;
  String? schoolName;
  bool? isAbroad;
  ListValue? country;
  String? city;
  List<Attachment?>? attachmentList;
  String? remark;

  factory Education.fromMap(Map<String, dynamic> json) => Education(
        id: json["id"],
        startDate: json["startDate"],
        isStartDateYear: json["isStartDateYear"],
        endDate: json["endDate"],
        isEndDateYear: json["isEndDateYear"],
        educationType: ListValue.fromMap(json["educationType"]),
        educationLevel: ListValue.fromMap(json["educationLevel"]),
        certificationType: ListValue.fromMap(json["certificationType"]),
        specialize: ListValue.fromMap(json["specialize"]),
        schoolName: json["schoolName"],
        isAbroad: json["isAbroad"],
        country: ListValue.fromMap(json["country"]),
        city: json["city"],
        attachmentList: List<Attachment?>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
        remark: json["remark"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "startDate": formatStringForApi(startDate),
        "isStartDateYear": isStartDateYear,
        "endDate": formatStringForApi(endDate),
        "isEndDateYear": isEndDateYear,
        "educationType": educationType?.toMap(),
        "educationLevel": educationLevel?.toMap(),
        "certificationType": certificationType?.toMap(),
        "specialize": specialize?.toMap(),
        "schoolName": schoolName,
        "isAbroad": isAbroad,
        "country": country?.toMap(),
        "city": city,
        "attachmentList":
            List<Attachment>.from(attachmentList?.map((x) => x?.toMap()) ?? []),
        "remark": remark,
      };
}
