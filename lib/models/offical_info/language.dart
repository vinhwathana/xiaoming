import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/models/utils/list_value.dart';

class Language {
  Language({
    required this.id,
    required this.languageName,
    required this.reading,
    required this.listening,
    required this.writing,
    required this.speaking,
    required this.attachmentList,
  });

  int id;
  ListValue languageName;
  ListValue reading;
  ListValue listening;
  ListValue writing;
  ListValue speaking;
  List<Attachment> attachmentList;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        id: json["id"],
        languageName: ListValue.fromMap(json["languageName"]),
        reading: ListValue.fromMap(json["reading"]),
        listening: ListValue.fromMap(json["listening"]),
        writing: ListValue.fromMap(json["writing"]),
        speaking: ListValue.fromMap(json["speaking"]),
        attachmentList: List<Attachment>.from(
            json["attachmentList"].map((x) => Attachment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "languageName": languageName.toMap(),
        "reading": reading.toMap(),
        "listening": listening.toMap(),
        "writing": writing.toMap(),
        "speaking": speaking.toMap(),
        "attachmentList":
            List<dynamic>.from(attachmentList.map((x) => x.toMap())),
      };
}
