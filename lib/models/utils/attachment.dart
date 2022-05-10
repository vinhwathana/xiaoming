import 'dart:convert';

class Attachment {
  Attachment({
    this.id,
    this.attachmentType,
    this.entityId,
    this.fileName,
    this.extension,
    this.filePath,
  });

  int? id;
  String? attachmentType;
  int? entityId;
  String? fileName;
  String? extension;
  String? filePath;

  factory Attachment.fromJson(String str) =>
      Attachment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attachment.fromMap(Map<String, dynamic>? json) => Attachment(
        id: json?["id"],
        attachmentType: json?["attachmentType"],
        entityId: json?["entityId"],
        fileName: json?["fileName"],
        extension: json?["extension"],
        filePath: json?["filePath"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "attachmentType": attachmentType,
        "entityId": entityId,
        "fileName": fileName,
        "extension": extension,
        "filePath": filePath,
      };

  @override
  String toString() {
    return 'Attachment{id: $id, attachmentType: $attachmentType, entityId: $entityId, fileName: $fileName, extension: $extension, filePath: $filePath}';
  }
}
