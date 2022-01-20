import 'dart:convert';

class User {
  User({
    this.employeeId,
    this.officialInfo,
    this.familyInfos,
    this.workHistories,
    required this.additionalPositions,
    required this.educations,
    required this.languages,
    required this.krobKhans,
    required this.merits,
  });

  int? employeeId;
  OfficialInfo? officialInfo;
  List<FamilyInfo>? familyInfos;
  List<WorkHistory>? workHistories;
  List<AdditionalPosition>? additionalPositions;
  List<Education>? educations;
  List<Language>? languages;
  List<KrobKhan>? krobKhans;
  List<Merit>? merits;

  factory User.fromMap(Map<String, dynamic> json) => User(
        employeeId: json["employeeId"],
        officialInfo: OfficialInfo.fromMap(json["officialInfo"]),
        familyInfos: List<FamilyInfo>.from(
            json["familyInfos"].map((x) => FamilyInfo.fromMap(x))),
        workHistories: List<WorkHistory>.from(
            json["workHistories"].map((x) => WorkHistory.fromMap(x))),
        additionalPositions: List<AdditionalPosition>.from(
            json["additionalPositions"]
                .map((x) => AdditionalPosition.fromMap(x))),
        educations: List<Education>.from(
            json["educations"].map((x) => Education.fromMap(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromMap(x))),
        krobKhans: List<KrobKhan>.from(
            json["krobKhans"].map((x) => KrobKhan.fromMap(x))),
        merits: List<Merit>.from(json["merits"].map((x) => Merit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId,
        "officialInfo": officialInfo!.toMap(),
        "familyInfos": List<dynamic>.from(familyInfos!.map((x) => x.toMap())),
        "workHistories":
            List<dynamic>.from(workHistories!.map((x) => x.toMap())),
        "additionalPositions":
            List<dynamic>.from(additionalPositions!.map((x) => x.toMap())),
        "educations": List<dynamic>.from(educations!.map((x) => x.toMap())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toMap())),
        "krobKhans": List<dynamic>.from(krobKhans!.map((x) => x.toMap())),
        "merits": List<dynamic>.from(merits!.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'User{employeeId: $employeeId, officialInfo: $officialInfo, familyInfos: $familyInfos, workHistories: $workHistories, additionalPositions: $additionalPositions, educations: $educations, languages: $languages, krobKhans: $krobKhans, merits: $merits}';
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
              print(x==null);
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

class Ministry {
  Ministry({
    required this.code,
    required this.nameKh,
    required this.nameEn,
    required this.description,
  });

  String code;
  String nameKh;
  String nameEn;
  String description;

  factory Ministry.fromMap(Map<String, dynamic> json) => Ministry(
        code: json["code"],
        nameKh: json["nameKH"],
        nameEn: json["nameEN"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "nameKH": nameKh,
        "nameEN": nameEn,
        "description": description,
      };
}

class Organization {
  Organization({
    required this.id,
    required this.parent,
    required this.ministry,
    required this.organizationType,
    required this.region,
    required this.nameKh,
    required this.nameEn,
    required this.description,
  });

  int? id;
  Organization? parent;
  Ministry? ministry;
  ListValue organizationType;
  ListValue region;
  String nameKh;
  String nameEn;
  String description;

  factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        id: json["id"],
        parent: json["parent"] == null
            ? null
            : Organization.fromMap(json["parent"]),
        ministry: json["ministry"] == null ? null : json["ministry"],
        organizationType: ListValue.fromMap(json["organizationType"]),
        region: ListValue.fromMap(json["region"]),
        nameKh: json["nameKH"],
        nameEn: json["nameEN"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parent": parent == null ? null : parent!.toMap(),
        "ministry": ministry,
        "organizationType": organizationType.toMap(),
        "region": region.toMap(),
        "nameKH": nameKh,
        "nameEN": nameEn,
        "description": description,
      };
}

// class MaritalStatus {
//   MaritalStatus({
//     required this.parentLov,
//     required this.lovCode,
//     required this.lovType,
//     required this.nameKh,
//     required this.nameEn,
//   });
//
//   dynamic parentLov;
//   String lovCode;
//   String lovType;
//   String nameKh;
//   String nameEn;
//
//   factory MaritalStatus.fromMap(Map<String, dynamic> json) => MaritalStatus(
//         parentLov: json["parentLov"],
//         lovCode: json["lovCode"],
//         lovType: json["lovType"],
//         nameKh: json["nameKH"],
//         nameEn: json["nameEN"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "parentLov": parentLov,
//         "lovCode": lovCode,
//         "lovType": lovType,
//         "nameKH": nameKh,
//         "nameEN": nameEn,
//       };
// }

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

  int id;
  DateTime startDate;
  bool isStartDateYear;
  DateTime endDate;
  bool isEndDateYear;
  ListValue educationType;
  ListValue educationLevel;
  ListValue certificationType;
  ListValue specialize;
  String schoolName;
  bool isAbroad;
  ListValue country;
  String city;
  List<dynamic> attachmentList;
  String remark;

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
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
        remark: json["remark"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "isStartDateYear": isStartDateYear,
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "isEndDateYear": isEndDateYear,
        "educationType": educationType.toMap(),
        "educationLevel": educationLevel.toMap(),
        "certificationType": certificationType.toMap(),
        "specialize": specialize.toMap(),
        "schoolName": schoolName,
        "isAbroad": isAbroad,
        "country": country.toMap(),
        "city": city,
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
        "remark": remark,
      };
}

class KrobKhan {
  KrobKhan({
    required this.id,
    required this.officialType,
    required this.startDate,
    required this.endDate,
    required this.ongoing,
    required this.krobKhanType,
    required this.level,
    required this.rank,
    required this.upgradedBy,
    required this.attachmentList,
  });

  int id;
  ListValue officialType;
  DateTime startDate;
  DateTime endDate;
  bool ongoing;
  ListValue krobKhanType;
  ListValue level;
  ListValue rank;
  ListValue upgradedBy;
  List<dynamic> attachmentList;

  factory KrobKhan.fromMap(Map<String, dynamic> json) => KrobKhan(
        id: json["id"],
        officialType: ListValue.fromMap(json["officialType"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        ongoing: json["ongoing"],
        krobKhanType: ListValue.fromMap(json["krobKhanType"]),
        level: ListValue.fromMap(json["level"]),
        rank: ListValue.fromMap(json["rank"]),
        upgradedBy: ListValue.fromMap(json["upgradedBy"]),
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "officialType": officialType.toMap(),
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "ongoing": ongoing,
        "krobKhanType": krobKhanType.toMap(),
        "level": level.toMap(),
        "rank": rank.toMap(),
        "upgradedBy": upgradedBy.toMap(),
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
      };
}

class Language {
  Language({
    required this.id,
    required this.languageName,
    required this.reading,
    required this.listening,
    required this.writing,
    required this.speaking,
    required this.attachmentList,
  });

  int id;
  ListValue languageName;
  ListValue reading;
  ListValue listening;
  ListValue writing;
  ListValue speaking;
  List<Attachment> attachmentList;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        id: json["id"],
        languageName: ListValue.fromMap(json["languageName"]),
        reading: ListValue.fromMap(json["reading"]),
        listening: ListValue.fromMap(json["listening"]),
        writing: ListValue.fromMap(json["writing"]),
        speaking: ListValue.fromMap(json["speaking"]),
        attachmentList: List<Attachment>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "languageName": languageName.toMap(),
        "reading": reading.toMap(),
        "listening": listening.toMap(),
        "writing": writing.toMap(),
        "speaking": speaking.toMap(),
        "attachmentList":
            List<dynamic>.from(attachmentList.map((x) => x.toMap())),
      };
}

class Merit {
  Merit({
    required this.id,
    required this.meritType,
    required this.medalType,
    required this.rank,
    required this.recievedDate,
    required this.remark,
    required this.attachmentList,
  });

  int id;
  ListValue meritType;
  ListValue medalType;
  ListValue rank;
  DateTime recievedDate;
  String remark;
  List<dynamic> attachmentList;

  factory Merit.fromMap(Map<String, dynamic> json) => Merit(
        id: json["id"],
        meritType: ListValue.fromMap(json["meritType"]),
        medalType: ListValue.fromMap(json["medalType"]),
        rank: ListValue.fromMap(json["rank"]),
        recievedDate: DateTime.parse(json["recievedDate"]),
        remark: json["remark"],
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "meritType": meritType.toMap(),
        "medalType": medalType.toMap(),
        "rank": rank.toMap(),
        "recievedDate":
            "${recievedDate.year.toString().padLeft(4, '0')}-${recievedDate.month.toString().padLeft(2, '0')}-${recievedDate.day.toString().padLeft(2, '0')}",
        "remark": remark,
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
      };
}

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
  List<dynamic> attachmentList;

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
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
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
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
      };
}

class Position {
  Position({
    required this.id,
    required this.ministryCode,
    required this.upperPositionId,
    required this.title,
    required this.levelOrder,
    required this.description,
    required this.status,
  });

  int id;
  String ministryCode;
  int upperPositionId;
  String title;
  int levelOrder;
  String description;
  String status;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        id: json["id"],
        ministryCode: json["ministryCode"],
        upperPositionId: json["upperPositionId"],
        title: json["title"],
        levelOrder: json["levelOrder"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministryCode": ministryCode,
        "upperPositionId": upperPositionId,
        "title": title,
        "levelOrder": levelOrder,
        "description": description,
        "status": status,
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

  @override
  String toString() {
    return 'Attachment{id: $id, attachmentType: $attachmentType, entityId: $entityId, fileName: $fileName, extension: $extension, filePath: $filePath}';
  }
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
