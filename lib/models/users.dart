import 'dart:convert';

class Users {
  Users({
    this.employeeId,
    this.officialInfo,
  });

  int? employeeId;
  OfficialInfo? officialInfo;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => jsonEncode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        employeeId: json["employeeId"] == null ? null : json["employeeId"],
        officialInfo: json["officialInfo"] == null
            ? null
            : OfficialInfo.fromMap(json["officialInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId == null ? null : employeeId,
        "officialInfo": officialInfo == null ? null : officialInfo!.toMap(),
      };

  @override
  String toString() {
    return 'Users{employeeId: $employeeId, officialInfo: $officialInfo}';
  }
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
            : ListValue.fromMap(json["physicalStatus"]),
        physicalStatusRemark: json["physicalStatusRemark"] == null
            ? null
            : json["physicalStatusRemark"],
        profile: json["profile"] == null ? null : json["profile"],
        imageBase64: json["imageBase64"],
        attachmentList: json["attachmentList"] == null
            ? null
            : List<Attachment>.from(
                json["attachmentList"].map((x) => Attachment.fromMap(x))),
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

  @override
  String toString() {
    return 'OfficialInfo{officialId: $officialId, birthAddressProvince: $birthAddressProvince, birthAddressDistrict: $birthAddressDistrict, birthAddressCommune: $birthAddressCommune, birthAddressVillage: $birthAddressVillage, birthAddressDetail: $birthAddressDetail, maleSibling: $maleSibling, femaleSibling: $femaleSibling, internshipDate: $internshipDate, officialWorkingDate: $officialWorkingDate, physicalStatus: $physicalStatus, physicalStatusRemark: $physicalStatusRemark, profile: $profile, imageBase64: $imageBase64, attachmentList: $attachmentList, nationalId: $nationalId, firstNameKh: $firstNameKh, lastNameKh: $lastNameKh, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, dateOfBirth: $dateOfBirth, status: $status, gender: $gender, maritalStatus: $maritalStatus, race: $race, nationality: $nationality, currentAddressProvince: $currentAddressProvince, currentAddressDistrict: $currentAddressDistrict, currentAddressCommune: $currentAddressCommune, currentAddressVillage: $currentAddressVillage, currentAddressDetail: $currentAddressDetail, contactPhone: $contactPhone, contactEmail: $contactEmail}';
  }
}

class FamilyInfos {
  FamilyInfos({
    this.familyInfos,
  });

  List<FamilyInfo>? familyInfos;

  factory FamilyInfos.fromJson(String str) =>
      FamilyInfos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FamilyInfos.fromMap(Map<String, dynamic> json) => FamilyInfos(
        familyInfos: json["familyInfos"] == null
            ? null
            : List<FamilyInfo>.from(
                json["familyInfos"].map((x) => FamilyInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "familyInfos": familyInfos == null
            ? null
            : List<dynamic>.from(familyInfos!.map((x) => x.toMap())),
      };
}

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
  List<Attachment>? attachmentList;
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
            : List<Attachment>.from(json["attachmentList"].map((x) => x)),
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
}

class Attachment {
  Attachment({
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

  factory Attachment.fromJson(String str) =>
      Attachment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attachment.fromMap(Map<String, dynamic> json) => Attachment(
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
  const Address({
    required this.parentsCode,
    required this.addressCode,
    required this.addressNameKh,
    required this.addressNameEn,
  });

  final String parentsCode;
  final String addressCode;
  final String addressNameKh;
  final String addressNameEn;

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
        "parentsCode": parentsCode,
        "addressCode": addressCode,
        "addressNameKH": addressNameKh,
        "addressNameEN": addressNameEn,
      };
}

class ListValue {
  ListValue({
    this.parentLov,
    required this.lovCode,
    required this.lovType,
    required this.nameKh,
    required this.nameEn,
  });

  String? parentLov;
  final String lovCode;
  final String lovType;
  final String nameKh;
  final String nameEn;

  factory ListValue.fromJson(String str) => ListValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListValue.fromMap(Map<String, dynamic> json) => ListValue(
        parentLov: json["parentLov"],
        lovCode: json["lovCode"] == null ? null : json["lovCode"],
        lovType: json["lovType"] == null ? null : json["lovType"],
        nameKh: json["nameKH"] == null ? null : json["nameKH"],
        nameEn: json["nameEN"] == null ? null : json["nameEN"],
      );

  Map<String, dynamic> toMap() {
    return {
      "parentLov": parentLov,
      "lovCode": lovCode,
      "lovType": lovType,
      "nameKH": nameKh,
      "nameEN": nameEn,
    };
  }

  @override
  String toString() {
    return '$nameKh / $nameEn';
  }
}
