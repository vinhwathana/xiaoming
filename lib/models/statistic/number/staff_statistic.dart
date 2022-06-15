import 'dart:convert';

StaffStatistic staffStatisticFromMap(String str) =>
    StaffStatistic.fromMap(json.decode(str));

String staffStatisticToMap(StaffStatistic data) => json.encode(data.toMap());

class StaffStatistic {
  StaffStatistic({
    required this.total,
    required this.female,
  });

  String total;
  String female;

  factory StaffStatistic.fromMap(Map<String, dynamic> json) => StaffStatistic(
        total: json["total"],
        female: json["female"],
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "female": female,
      };
}
