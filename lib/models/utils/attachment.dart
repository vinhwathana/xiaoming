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

  factory Attachment.fromMap(Map<String, dynamic> json) => Attachment(
        id: json["id"] == null ? null : json["id"],
        attachmentType:
            json["attachmentType"] == null ? null : json["attachmentType"],
        entityId: json["entityId"] == null ? null : json["entityId"],
        fileName: json["fileName"] == null ? null : json["fileName"],
        extension: json["extension"] == null ? null : json["extension"],
        filePath: json["filePath"] == null ? null : json["filePath"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "attachmentType": attachmentType == null ? null : attachmentType,
        "entityId": entityId == null ? null : entityId,
        "fileName": fileName == null ? null : fileName,
        "extension": extension == null ? null : extension,
        "filePath": filePath == null ? null : filePath,
      };

  @override
  String toString() {
    return 'Attachment{id: $id, attachmentType: $attachmentType, entityId: $entityId, fileName: $fileName, extension: $extension, filePath: $filePath}';
  }
}
