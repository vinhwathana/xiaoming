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
        id: json["id"],
        relation: json["relation"] == null
            ? null
            : ListValue.fromMap(json["relation"]),
        job: json["job"] == null ? null : ListValue.fromMap(json["job"]),
        workPlace: json["workPlace"],
        isGovernmentOfficial: json["isGovermentOfficial"],
        attachmentList: List<Attachment?>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
        nationalId: json["nationalId"],
        firstNameKh: json["firstNameKH"],
        lastNameKh: json["lastNameKH"],
        firstNameEn: json["firstNameEN"],
        lastNameEn: json["lastNameEN"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        status: json["status"],
        gender: json["gender"],
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
        currentAddressDetail: json["currentAddressDetail"],
        contactPhone:
            json["contactPhone"],
        contactEmail:
            json["contactEmail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "relation": relation == null ? null : relation!.toMap(),
        "job": job == null ? null : job!.toMap(),
        "workPlace": workPlace,
        "isGovermentOfficial":
            isGovernmentOfficial,
        "attachmentList": List<Attachment>.from(attachmentList?.map((x) => x?.toMap()) ?? []),
        "nationalId": nationalId,
        "firstNameKH": firstNameKh,
        "lastNameKH": lastNameKh,
        "firstNameEN": firstNameEn,
        "lastNameEN": lastNameEn,
        "dateOfBirth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "status": status,
        "gender": gender,
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
            currentAddressDetail,
        "contactPhone": contactPhone,
        "contactEmail": contactEmail,
      };

  @override
  String toString() {
    return 'FamilyInfo{id: $id, relation: $relation, job: $job, workPlace: $workPlace, isGovernmentOfficial: $isGovernmentOfficial, attachmentList: $attachmentList, nationalId: $nationalId, firstNameKh: $firstNameKh, lastNameKh: $lastNameKh, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, dateOfBirth: $dateOfBirth, status: $status, gender: $gender, maritalStatus: $maritalStatus, race: $race, nationality: $nationality, currentAddressProvince: $currentAddressProvince, currentAddressDistrict: $currentAddressDistrict, currentAddressCommune: $currentAddressCommune, currentAddressVillage: $currentAddressVillage, currentAddressDetail: $currentAddressDetail, contactPhone: $contactPhone, contactEmail: $contactEmail}';
  }
}
