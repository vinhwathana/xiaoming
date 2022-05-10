class Position {
  Position({
    this.id,
    this.ministryCode,
    this.upperPositionId,
    this.title,
    this.levelOrder,
    this.description,
    this.status,
  });

  int? id;
  String? ministryCode;
  int? upperPositionId;
  String? title;
  int? levelOrder;
  String? description;
  String? status;

  factory Position.fromMap(Map<String, dynamic>? json) => Position(
        id: json?["id"],
        ministryCode: json?["ministryCode"],
        upperPositionId: json?["upperPositionId"],
        title: json?["title"],
        levelOrder: json?["levelOrder"],
        description: json?["description"],
        status: json?["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministryCode": ministryCode,
        "upperPositionId": upperPositionId,
        "title": title,
        "levelOrder": levelOrder,
        "description": description,
        "status": status,
      };
}
