import 'dart:convert';

List<SkillByDegreeStatistic> skillByDegreeStatisticFromMap(String str) =>
    List<SkillByDegreeStatistic>.from(
        json.decode(str).map((x) => SkillByDegreeStatistic.fromMap(x)));

String skillByDegreeStatisticToMap(List<SkillByDegreeStatistic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SkillByDegreeStatistic {
  SkillByDegreeStatistic({
    required this.categoryName,
    required this.categoryNameEn,
    required this.total,
  });

  final String categoryName;
  final String categoryNameEn;
  final int total;

  factory SkillByDegreeStatistic.fromMap(Map<String, dynamic> json) =>
      SkillByDegreeStatistic(
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
