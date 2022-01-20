import 'dart:convert';

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
