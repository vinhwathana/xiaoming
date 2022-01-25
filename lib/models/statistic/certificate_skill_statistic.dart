import 'dart:convert';

List<CertificateSkillStatistic> certificateSkillStatisticFromMap(String str) =>
    List<CertificateSkillStatistic>.from(
        json.decode(str).map((x) => CertificateSkillStatistic.fromMap(x)));

String certificateSkillStatisticToMap(List<CertificateSkillStatistic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CertificateSkillStatistic {
  CertificateSkillStatistic({
    required this.categoryName,
    required this.categoryNameEn,
    required this.total,
  });

  final String categoryName;
  final String categoryNameEn;
  final int total;

  factory CertificateSkillStatistic.fromMap(Map<String, dynamic> json) =>
      CertificateSkillStatistic(
        categoryName: json["category_name"],
        categoryNameEn: json["category_name_en"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "category_name": categoryName,
        "category_name_en": categoryNameEn,
        "total": total,
      };
}
