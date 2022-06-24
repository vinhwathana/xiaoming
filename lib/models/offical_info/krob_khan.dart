import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/utils/constant.dart';

class KrobKhan {
  KrobKhan({
    required this.id,
    required this.officialType,
    required this.startDate,
    required this.endDate,
    required this.ongoing,
    required this.krobKhanType,
    required this.level,
    required this.rank,
    required this.upgradedBy,
    required this.attachmentList,
  });

  int? id;
  ListValue? officialType;
  String? startDate;
  String? endDate;
  bool? ongoing;
  ListValue? krobKhanType;
  ListValue? level;
  ListValue? rank;
  ListValue? upgradedBy;
  List<Attachment?>? attachmentList;

  factory KrobKhan.fromMap(Map<String, dynamic> json) => KrobKhan(
        id: json["id"],
        officialType: ListValue.fromMap(json["officialType"]),
        startDate: json["startDate"],
        endDate: json["endDate"],
        ongoing: json["ongoing"],
        krobKhanType: ListValue.fromMap(json["krobKhanType"]),
        level: ListValue.fromMap(json["level"]),
        rank: ListValue.fromMap(json["rank"]),
        upgradedBy: ListValue.fromMap(json["upgradedBy"]),
        attachmentList: List<Attachment?>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "officialType": officialType?.toMap(),
        "startDate": formatStringForApi(startDate),
        "endDate": formatStringForApi(endDate),
        "ongoing": ongoing,
        "krobKhanType": krobKhanType?.toMap(),
        "level": level?.toMap(),
        "rank": rank?.toMap(),
        "upgradedBy": upgradedBy?.toMap(),
        "attachmentList":
            List<Attachment>.from(attachmentList?.map((x) => x?.toMap()) ?? []),
      };
}
