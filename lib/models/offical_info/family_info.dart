import 'dart:convert';

import 'package:xiaoming/models/utils/address.dart';
import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';

class FamilyInfo {
  FamilyInfo({
    this.id,
    this.relation,
    this.job,
    this.workPlace,
    this.isGovernmentOfficial,
    this.attachmentList,
    this.nationalId,
    this.firstNameKh,
    this.lastNameKh,
    this.firstNameEn,
    this.lastNameEn,
    this.dateOfBirth,
    this.status,
    this.gender,
    this.maritalStatus,
    this.race,
    this.nationality,
    this.currentAddressProvince,
    this.currentAddressDistrict,
    this.currentAddressCommune,
    this.currentAddressVillage,
    this.currentAddressDetail,
    this.contactPhone,
    this.contactEmail,
  });

  int? id;
  ListValue? relation;
  ListValue? job;
  String? workPlace;
  bool? isGovernmentOfficial;
  List<Attachment?>? attachmentList;
  String? nationalId;
  String? firstNameKh;
  String? lastNameKh;
  String? firstNameEn;
  String? lastNameEn;
  DateTime? dateOfBirth;
  String? status;
  String? gender;
  ListValue? maritalStatus;
  ListValue? race;
  ListValue? nationality;
  Address? currentAddressProvince;
  Address? currentAddressDistrict;
  Address? currentAddressCommune;
  Address? currentAddressVillage;
  String? currentAddressDetail;
  String? contactPhone;
  String? contactEmail;

  factory FamilyInfo.fromJson(String str) =>
      FamilyInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FamilyInfo.fromMap(Map<String, dynamic> json) => FamilyInfo(
        id: json["id"] == null ? null : json["id"],
        relation: json["relation"] == null
            ? null
            : ListValue.fromMap(json["relation"]),
        job: json["job"] == null ? null : ListValue.fromMap(json["job"]),
        workPlace: json["workPlace"] == null ? null : json["workPlace"],
        isGovernmentOfficial: json["isGovermentOfficial"] == null
            ? null
            : json["isGovermentOfficial"],
        attachmentList: json["attachmentList"] == null
            ? null
            : List<Attachment?>.from(json["attachmentList"].map((x) {
                print(x == null);
                return Attachment.fromMap(x);
              })),
        nationalId: json["nationalId"] == null ? null : json["nationalId"],
        firstNameKh: json["firstNameKH"] == null ? null : json["firstNameKH"],
        lastNameKh: json["lastNameKH"] == null ? null : json["lastNameKH"],
        firstNameEn: json["firstNameEN"] == null ? null : json["firstNameEN"],
        lastNameEn: json["lastNameEN"] == null ? null : json["lastNameEN"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        status: json["status"] == null ? null : json["status"],
        gender: json["gender"] == null ? null : json["gender"],
        maritalStatus: json["maritalStatus"] == null
            ? null
            : ListValue.fromMap(json["maritalStatus"]),
        race: json["race"] == null ? null : ListValue.fromMap(json["race"]),
        nationality: json["nationality"] == null
            ? null
            : ListValue.fromMap(json["nationality"]),
        currentAddressProvince: json["currentAddressProvince"] == null
            ? null
            : Address.fromMap(json["currentAddressProvince"]),
        currentAddressDistrict: json["currentAddressDistrict"] == null
            ? null
            : Address.fromMap(json["currentAddressDistrict"]),
        currentAddressCommune: json["currentAddressCommune"] == null
            ? null
            : Address.fromMap(json["currentAddressCommune"]),
        currentAddressVillage: json["currentAddressVillage"] == null
            ? null
            : Address.fromMap(json["currentAddressVillage"]),
        currentAddressDetail: json["currentAddressDetail"] == null
            ? null
            : json["currentAddressDetail"],
        contactPhone:
            json["contactPhone"] == null ? null : json["contactPhone"],
        contactEmail:
            json["contactEmail"] == null ? null : json["contactEmail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "relation": relation == null ? null : relation!.toMap(),
        "job": job == null ? null : job!.toMap(),
        "workPlace": workPlace == null ? null : workPlace,
        "isGovermentOfficial":
            isGovernmentOfficial == null ? null : isGovernmentOfficial,
        "attachmentList": attachmentList == null
            ? null
            : List<dynamic>.from(attachmentList!.map((x) => x)),
        "nationalId": nationalId == null ? null : nationalId,
        "firstNameKH": firstNameKh == null ? null : firstNameKh,
        "lastNameKH": lastNameKh == null ? null : lastNameKh,
        "firstNameEN": firstNameEn == null ? null : firstNameEn,
        "lastNameEN": lastNameEn == null ? null : lastNameEn,
        "dateOfBirth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "gender": gender == null ? null : gender,
        "maritalStatus": maritalStatus == null ? null : maritalStatus!.toMap(),
        "race": race == null ? null : race!.toMap(),
        "nationality": nationality == null ? null : nationality!.toMap(),
        "currentAddressProvince": currentAddressProvince == null
            ? null
            : currentAddressProvince!.toMap(),
        "currentAddressDistrict": currentAddressDistrict == null
            ? null
            : currentAddressDistrict!.toMap(),
        "currentAddressCommune": currentAddressCommune == null
            ? null
            : currentAddressCommune!.toMap(),
        "currentAddressVillage": currentAddressVillage == null
            ? null
            : currentAddressVillage!.toMap(),
        "currentAddressDetail":
            currentAddressDetail == null ? null : currentAddressDetail,
        "contactPhone": contactPhone == null ? null : contactPhone,
        "contactEmail": contactEmail == null ? null : contactEmail,
      };

  @override
  String toString() {
    return 'FamilyInfo{id: $id, relation: $relation, job: $job, workPlace: $workPlace, isGovernmentOfficial: $isGovernmentOfficial, attachmentList: $attachmentList, nationalId: $nationalId, firstNameKh: $firstNameKh, lastNameKh: $lastNameKh, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, dateOfBirth: $dateOfBirth, status: $status, gender: $gender, maritalStatus: $maritalStatus, race: $race, nationality: $nationality, currentAddressProvince: $currentAddressProvince, currentAddressDistrict: $currentAddressDistrict, currentAddressCommune: $currentAddressCommune, currentAddressVillage: $currentAddressVillage, currentAddressDetail: $currentAddressDetail, contactPhone: $contactPhone, contactEmail: $contactEmail}';
  }
}
