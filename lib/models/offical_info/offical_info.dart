import 'dart:convert';

import 'package:xiaoming/models/utils/address.dart';
import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/utils/constant.dart';

class OfficialInfo {
  OfficialInfo({
    this.officialId,
    this.birthAddressProvince,
    this.birthAddressDistrict,
    this.birthAddressCommune,
    this.birthAddressVillage,
    this.birthAddressDetail,
    this.maleSibling,
    this.femaleSibling,
    this.internshipDate,
    this.officialWorkingDate,
    this.physicalStatus,
    this.physicalStatusRemark,
    this.profile,
    this.imageBase64,
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

  String? officialId;
  Address? birthAddressProvince;
  Address? birthAddressDistrict;
  Address? birthAddressCommune;
  Address? birthAddressVillage;
  String? birthAddressDetail;
  int? maleSibling;
  int? femaleSibling;
  String? internshipDate;
  String? officialWorkingDate;
  ListValue? physicalStatus;
  String? physicalStatusRemark;
  String? profile;
  String? imageBase64;
  List<Attachment>? attachmentList;
  String? nationalId;
  String? firstNameKh;
  String? lastNameKh;
  String? firstNameEn;
  String? lastNameEn;
  String? dateOfBirth;
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

  String getFullNameEn() {
    return "$firstNameEn $lastNameEn";
  }

  String getFullNameKh() {
    return "$firstNameKh $lastNameKh";
  }

  factory OfficialInfo.fromJson(String str) =>
      OfficialInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfficialInfo.fromMap(Map<String, dynamic> json) => OfficialInfo(
        officialId: json["officialId"],
        birthAddressProvince: json["birthAddressProvince"] == null
            ? null
            : Address.fromMap(json["birthAddressProvince"]),
        birthAddressDistrict: json["birthAddressDistrict"] == null
            ? null
            : Address.fromMap(json["birthAddressDistrict"]),
        birthAddressCommune: json["birthAddressCommune"] == null
            ? null
            : Address.fromMap(json["birthAddressCommune"]),
        birthAddressVillage: json["birthAddressVillage"] == null
            ? null
            : Address.fromMap(json["birthAddressVillage"]),
        birthAddressDetail: json["birthAddressDetail"],
        maleSibling: json["maleSibling"],
        femaleSibling: json["femaleSibling"],
        internshipDate: json["internshipDate"],
        officialWorkingDate: json["officialWorkingDate"],
        physicalStatus: json["physicalStatus"] == null
            ? null
            : ListValue.fromMap(json["physicalStatus"]),
        physicalStatusRemark: json["physicalStatusRemark"],
        profile: json["profile"],
        imageBase64: json["imageBase64"],
        attachmentList: json["attachmentList"] == null
            ? null
            : List<Attachment>.from(
                json["attachmentList"].map((x) => Attachment.fromMap(x))),
        nationalId: json["nationalId"],
        firstNameKh: json["firstNameKH"],
        lastNameKh: json["lastNameKH"],
        firstNameEn: json["firstNameEN"],
        lastNameEn: json["lastNameEN"],
        dateOfBirth: json["dateOfBirth"],
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
        contactPhone: json["contactPhone"],
        contactEmail: json["contactEmail"],
      );

  Map<String, dynamic> toMap() => {
        "officialId": officialId,
        "birthAddressProvince":
            birthAddressProvince == null ? null : birthAddressProvince!.toMap(),
        "birthAddressDistrict":
            birthAddressDistrict == null ? null : birthAddressDistrict!.toMap(),
        "birthAddressCommune":
            birthAddressCommune == null ? null : birthAddressCommune!.toMap(),
        "birthAddressVillage":
            birthAddressVillage == null ? null : birthAddressVillage!.toMap(),
        "birthAddressDetail": birthAddressDetail,
        "maleSibling": maleSibling,
        "femaleSibling": femaleSibling,
        "internshipDate": formatStringForApi(internshipDate),
        "officialWorkingDate": formatStringForApi(officialWorkingDate),
        "physicalStatus":
            physicalStatus == null ? null : physicalStatus!.toMap(),
        "physicalStatusRemark": physicalStatusRemark,
        "profile": profile,
        "imageBase64": imageBase64,
        "attachmentList": attachmentList == null
            ? null
            : List<dynamic>.from(attachmentList!.map((x) => x.toMap())),
        "nationalId": nationalId,
        "firstNameKH": firstNameKh,
        "lastNameKH": lastNameKh,
        "firstNameEN": firstNameEn,
        "lastNameEN": lastNameEn,
        "dateOfBirth": formatStringForApi(dateOfBirth),
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
        "currentAddressDetail": currentAddressDetail,
        "contactPhone": contactPhone,
        "contactEmail": contactEmail,
      };

  @override
  String toString() {
    return 'OfficialInfo{officialId: $officialId, birthAddressProvince: $birthAddressProvince, birthAddressDistrict: $birthAddressDistrict, birthAddressCommune: $birthAddressCommune, birthAddressVillage: $birthAddressVillage, birthAddressDetail: $birthAddressDetail, maleSibling: $maleSibling, femaleSibling: $femaleSibling, internshipDate: $internshipDate, officialWorkingDate: $officialWorkingDate, physicalStatus: $physicalStatus, physicalStatusRemark: $physicalStatusRemark, profile: $profile, imageBase64: $imageBase64, attachmentList: $attachmentList, nationalId: $nationalId, firstNameKh: $firstNameKh, lastNameKh: $lastNameKh, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, dateOfBirth: $dateOfBirth, status: $status, gender: $gender, maritalStatus: $maritalStatus, race: $race, nationality: $nationality, currentAddressProvince: $currentAddressProvince, currentAddressDistrict: $currentAddressDistrict, currentAddressCommune: $currentAddressCommune, currentAddressVillage: $currentAddressVillage, currentAddressDetail: $currentAddressDetail, contactPhone: $contactPhone, contactEmail: $contactEmail}';
  }
}
