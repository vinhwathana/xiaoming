import 'dart:convert';

List<MeritStatistic> meritStatisticFromMap(String str) =>
    List<MeritStatistic>.from(
        json.decode(str).map((x) => MeritStatistic.fromMap(x)));

String meritStatisticToMap(List<MeritStatistic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MeritStatistic {
  MeritStatistic({
    required this.meritCode,
    required this.shortcut,
    required this.meritKh,
    required this.count,
  });

  final String meritCode;
  final String shortcut;
  final String meritKh;
  final String count;

  factory MeritStatistic.fromMap(Map<String, dynamic> json) => MeritStatistic(
        meritCode: json["merit_code"],
        shortcut: json["shortcut"],
        meritKh: json["merit_kh"],
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "merit_code": meritCode,
        "shortcut": shortcut,
        "merit_kh": meritKh,
        "count": count,
      };
}
