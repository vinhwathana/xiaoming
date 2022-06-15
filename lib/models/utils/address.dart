import 'dart:convert';

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

  factory Address.fromMap(Map<String, dynamic>? json) => Address(
        parentsCode: json?["parentsCode"],
        addressCode: json?["addressCode"],
        addressNameKh: json?["addressNameKH"],
        addressNameEn: json?["addressNameEN"],
      );

  Map<String, dynamic> toMap() => {
        "parentsCode": parentsCode,
        "addressCode": addressCode,
        "addressNameKH": addressNameKh,
        "addressNameEN": addressNameEn,
      };
}
