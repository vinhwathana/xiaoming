// To parse this JSON data, do
//
//     final idCardInfo = idCardInfoFromJson(jsonString);

import 'dart:convert';

IdCardInfo idCardInfoFromJson(String str) =>
    IdCardInfo.fromJson(json.decode(str));

String idCardInfoToJson(IdCardInfo data) => json.encode(data.toJson());

class IdCardInfo {
  IdCardInfo({
    this.employeeId,
    this.officialId,
    this.firstNameKh,
    this.lastNameKh,
    this.firstNameEn,
    this.lastNameEn,
    this.positionKh,
    this.positionEn,
    this.unitTitle,
    this.unitTitleEn,
    this.qrCode,
    this.photo,
    this.cardId,
    this.dateOfBirth,
    this.gender,
    this.verifyCode,
    this.cardType,
  });

  String? employeeId;
  String? officialId;
  String? firstNameKh;
  String? lastNameKh;
  String? firstNameEn;
  String? lastNameEn;
  String? positionKh;
  String? positionEn;
  String? unitTitle;
  String? unitTitleEn;
  String? qrCode;
  String? photo;
  String? cardId;
  String? dateOfBirth;
  String? gender;
  String? verifyCode;
  String? cardType;

  String get fullNameKh {
    return "${firstNameKh ?? ""} ${lastNameKh ?? ""}";
  }
  String get fullNameEn {
    return "${firstNameEn ?? ""} ${lastNameEn ?? ""}";
  }

  String get getPhoto {
    return photo?.replaceFirst("data:image/png;base64,", "") ?? "";
  }
  String get getQrCode {
    return qrCode?.replaceFirst("data:image/png;base64,", "") ?? "";
  }


  factory IdCardInfo.fromJson(Map<String, dynamic> json) => IdCardInfo(
        employeeId: json["employeeId"],
        officialId: json["officialId"],
        firstNameKh: json["firstNameKH"],
        lastNameKh: json["lastNameKH"],
        firstNameEn: json["firstNameEN"],
        lastNameEn: json["lastNameEN"],
        positionKh: json["positionKH"],
        positionEn: json["positionEN"],
        unitTitle: json["unitTitle"],
        unitTitleEn: json["unitTitleEN"],
        qrCode: json["qrCode"],
        photo: json["photo"],
        cardId: json["cardId"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        verifyCode: json["verifyCode"],
        cardType: json["cardType"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "officialId": officialId,
        "firstNameKH": firstNameKh,
        "lastNameKH": lastNameKh,
        "firstNameEN": firstNameEn,
        "lastNameEN": lastNameEn,
        "positionKH": positionKh,
        "positionEN": positionEn,
        "unitTitle": unitTitle,
        "unitTitleEN": unitTitleEn,
        "qrCode": qrCode,
        "photo": photo,
        "cardId": cardId,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "verifyCode": verifyCode,
        "cardType": cardType,
      };

  @override
  String toString() {
    return 'IdCardInfo{employeeId: $employeeId, officialId: $officialId, firstNameKh: $firstNameKh, lastNameKh: $lastNameKh, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, positionKh: $positionKh, positionEn: $positionEn, unitTitle: $unitTitle, unitTitleEn: $unitTitleEn, qrCode: $qrCode, photo: $photo, cardId: $cardId, dateOfBirth: $dateOfBirth, gender: $gender, verifyCode: $verifyCode, cardType: $cardType}';
  }
}
