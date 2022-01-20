import 'dart:convert';

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
