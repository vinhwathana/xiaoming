import 'package:xiaoming/models/utils/list_value.dart';

class Merit {
  Merit({
    required this.id,
    required this.meritType,
    required this.medalType,
    required this.rank,
    required this.recievedDate,
    required this.remark,
    required this.attachmentList,
  });

  int id;
  ListValue meritType;
  ListValue medalType;
  ListValue rank;
  DateTime recievedDate;
  String remark;
  List<dynamic> attachmentList;

  factory Merit.fromMap(Map<String, dynamic> json) => Merit(
        id: json["id"],
        meritType: ListValue.fromMap(json["meritType"]),
        medalType: ListValue.fromMap(json["medalType"]),
        rank: ListValue.fromMap(json["rank"]),
        recievedDate: DateTime.parse(json["recievedDate"]),
        remark: json["remark"],
        attachmentList:
            List<dynamic>.from(json["attachmentList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "meritType": meritType.toMap(),
        "medalType": medalType.toMap(),
        "rank": rank.toMap(),
        "recievedDate":
            "${recievedDate.year.toString().padLeft(4, '0')}-${recievedDate.month.toString().padLeft(2, '0')}-${recievedDate.day.toString().padLeft(2, '0')}",
        "remark": remark,
        "attachmentList": List<dynamic>.from(attachmentList.map((x) => x)),
      };
}
