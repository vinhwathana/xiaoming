import 'dart:convert';

List<ListValue> listValueFromMap(String str) =>
    List<ListValue>.from(json.decode(str).map((x) => ListValue.fromMap(x)));

String listValueToMap(List<ListValue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ListValue {
  ListValue({
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

  factory ListValue.fromJson(String str) => ListValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListValue.fromMap(Map<String, dynamic>? json) => ListValue(
        parentLov: json?["parentLov"],
        lovCode: json?["lovCode"],
        lovType: json?["lovType"],
        nameKh: json?["nameKH"],
        nameEn: json?["nameEN"],
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
