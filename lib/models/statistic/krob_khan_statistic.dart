import 'dart:convert';

KrobKhanStatistic krobKhanStatisticFromMap(String str) =>
    KrobKhanStatistic.fromMap(json.decode(str));

String krobKhanStatisticToMap(KrobKhanStatistic data) =>
    json.encode(data.toMap());

class KrobKhanStatistic {
  KrobKhanStatistic({
    required this.total,
    required this.a,
    required this.b,
    required this.c,
    required this.noKrobkhan,
    required this.retire,
  });

  final String total;
  final String a;
  final String b;
  final String c;
  final String noKrobkhan;
  final String retire;

  factory KrobKhanStatistic.fromMap(Map<String, dynamic> json) =>
      KrobKhanStatistic(
        total: json["total"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        noKrobkhan: json["no_Krobkhan"],
        retire: json["retire"],
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "a": a,
        "b": b,
        "c": c,
        "no_Krobkhan": noKrobkhan,
        "retire": retire,
      };
}
