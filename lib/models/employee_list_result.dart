// To parse this JSON data, do
//
//     final employeeListResult = employeeListResultFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class EmployeeListResult {
  EmployeeListResult({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory EmployeeListResult.fromJson(String str) =>
      EmployeeListResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeListResult.fromMap(Map<String, dynamic> json) =>
      EmployeeListResult(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.employeeId,
    this.officialInfo,
  });

  int? employeeId;
  OfficialInfo? officialInfo;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        employeeId: json["employeeId"] == null ? null : json["employeeId"],
        officialInfo: json["officialInfo"] == null
            ? null
            : OfficialInfo.fromMap(json["officialInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId == null ? null : employeeId,
        "officialInfo": officialInfo == null ? null : officialInfo!.toMap(),
      };
}

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
  DateTime? internshipDate;
  DateTime? officialWorkingDate;
  EnumValue? physicalStatus;
  String? physicalStatusRemark;
  String? profile;
  String? imageBase64;
  List<AttachmentList>? attachmentList;
  String? nationalId;
  String? firstNameKh;
  String? lastNameKh;
  String? firstNameEn;
  String? lastNameEn;
  DateTime? dateOfBirth;
  String? status;
  String? gender;
  EnumValue? maritalStatus;
  EnumValue? race;
  EnumValue? nationality;
  Address? currentAddressProvince;
  Address? currentAddressDistrict;
  Address? currentAddressCommune;
  Address? currentAddressVillage;
  String? currentAddressDetail;
  String? contactPhone;
  String? contactEmail;

  factory OfficialInfo.fromJson(String str) =>
      OfficialInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfficialInfo.fromMap(Map<String, dynamic> json) => OfficialInfo(
        officialId: json["officialId"] == null ? null : json["officialId"],
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
        birthAddressDetail: json["birthAddressDetail"] == null
            ? null
            : json["birthAddressDetail"],
        maleSibling: json["maleSibling"] == null ? null : json["maleSibling"],
        femaleSibling:
            json["femaleSibling"] == null ? null : json["femaleSibling"],
        internshipDate: json["internshipDate"] == null
            ? null
            : DateTime.parse(json["internshipDate"]),
        officialWorkingDate: json["officialWorkingDate"] == null
            ? null
            : DateTime.parse(json["officialWorkingDate"]),
        physicalStatus: json["physicalStatus"] == null
            ? null
            : EnumValue.fromMap(json["physicalStatus"]),
        physicalStatusRemark: json["physicalStatusRemark"] == null
            ? null
            : json["physicalStatusRemark"],
        profile: json["profile"] == null ? null : json["profile"],
        imageBase64: json["imageBase64"],
        attachmentList: json["attachmentList"] == null
            ? null
            : List<AttachmentList>.from(
                json["attachmentList"].map((x) => AttachmentList.fromMap(x))),
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
            : EnumValue.fromMap(json["maritalStatus"]),
        race: json["race"] == null ? null : EnumValue.fromMap(json["race"]),
        nationality: json["nationality"] == null
            ? null
            : EnumValue.fromMap(json["nationality"]),
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
        "officialId": officialId == null ? null : officialId,
        "birthAddressProvince":
            birthAddressProvince == null ? null : birthAddressProvince!.toMap(),
        "birthAddressDistrict":
            birthAddressDistrict == null ? null : birthAddressDistrict!.toMap(),
        "birthAddressCommune":
            birthAddressCommune == null ? null : birthAddressCommune!.toMap(),
        "birthAddressVillage":
            birthAddressVillage == null ? null : birthAddressVillage!.toMap(),
        "birthAddressDetail":
            birthAddressDetail == null ? null : birthAddressDetail,
        "maleSibling": maleSibling == null ? null : maleSibling,
        "femaleSibling": femaleSibling == null ? null : femaleSibling,
        "internshipDate": internshipDate == null
            ? null
            : "${internshipDate!.year.toString().padLeft(4, '0')}-${internshipDate!.month.toString().padLeft(2, '0')}-${internshipDate!.day.toString().padLeft(2, '0')}",
        "officialWorkingDate": officialWorkingDate == null
            ? null
            : "${officialWorkingDate!.year.toString().padLeft(4, '0')}-${officialWorkingDate!.month.toString().padLeft(2, '0')}-${officialWorkingDate!.day.toString().padLeft(2, '0')}",
        "physicalStatus":
            physicalStatus == null ? null : physicalStatus!.toMap(),
        "physicalStatusRemark":
            physicalStatusRemark == null ? null : physicalStatusRemark,
        "profile": profile == null ? null : profile,
        "imageBase64": imageBase64,
        "attachmentList": attachmentList == null
            ? null
            : List<dynamic>.from(attachmentList!.map((x) => x.toMap())),
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
}

class AttachmentList {
  AttachmentList({
    this.id,
    this.attachmentType,
    this.entityId,
    this.fileName,
    this.extension,
    this.filePath,
  });

  int? id;
  String? attachmentType;
  int? entityId;
  String? fileName;
  String? extension;
  String? filePath;

  factory AttachmentList.fromJson(String str) =>
      AttachmentList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttachmentList.fromMap(Map<String, dynamic> json) => AttachmentList(
        id: json["id"] == null ? null : json["id"],
        attachmentType:
            json["attachmentType"] == null ? null : json["attachmentType"],
        entityId: json["entityId"] == null ? null : json["entityId"],
        fileName: json["fileName"] == null ? null : json["fileName"],
        extension: json["extension"] == null ? null : json["extension"],
        filePath: json["filePath"] == null ? null : json["filePath"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "attachmentType": attachmentType == null ? null : attachmentType,
        "entityId": entityId == null ? null : entityId,
        "fileName": fileName == null ? null : fileName,
        "extension": extension == null ? null : extension,
        "filePath": filePath == null ? null : filePath,
      };
}

class Address {
  Address({
    this.parentsCode,
    this.addressCode,
    this.addressNameKh,
    this.addressNameEn,
  });

  String? parentsCode;
  String? addressCode;
  String? addressNameKh;
  String? addressNameEn;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        parentsCode: json["parentsCode"] == null ? null : json["parentsCode"],
        addressCode: json["addressCode"] == null ? null : json["addressCode"],
        addressNameKh:
            json["addressNameKH"] == null ? null : json["addressNameKH"],
        addressNameEn:
            json["addressNameEN"] == null ? null : json["addressNameEN"],
      );

  Map<String, dynamic> toMap() => {
        "parentsCode": parentsCode == null ? null : parentsCode,
        "addressCode": addressCode == null ? null : addressCode,
        "addressNameKH": addressNameKh == null ? null : addressNameKh,
        "addressNameEN": addressNameEn == null ? null : addressNameEn,
      };
}

class EnumValue {
  EnumValue({
    this.parentLov,
    this.lovCode,
    this.lovType,
    this.nameKh,
    this.nameEn,
  });

  String? parentLov;
  String? lovCode;
  String? lovType;
  String? nameKh;
  String? nameEn;

  factory EnumValue.fromJson(String str) => EnumValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EnumValue.fromMap(Map<String, dynamic> json) => EnumValue(
        parentLov: json["parentLov"],
        lovCode: json["lovCode"] == null ? null : json["lovCode"],
        lovType: json["lovType"] == null ? null : json["lovType"],
        nameKh: json["nameKH"] == null ? null : json["nameKH"],
        nameEn: json["nameEN"] == null ? null : json["nameEN"],
      );

  Map<String, dynamic> toMap() => {
        "parentLov": parentLov,
        "lovCode": lovCode == null ? null : lovCode,
        "lovType": lovType == null ? null : lovType,
        "nameKH": nameKh == null ? null : nameKh,
        "nameEN": nameEn == null ? null : nameEn,
      };
}
