import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';

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
  DateTime? startDate;
  bool? isStartDateYear;
  DateTime? endDate;
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
        startDate: DateTime.parse(json["startDate"]),
        isStartDateYear: json["isStartDateYear"],
        endDate: DateTime.parse(json["endDate"]),
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
        "startDate":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "isStartDateYear": isStartDateYear,
        "endDate":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
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
