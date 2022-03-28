class Position {
  Position({
    required this.id,
    required this.ministryCode,
    required this.upperPositionId,
    required this.title,
    required this.levelOrder,
    required this.description,
    required this.status,
  });

  int id;
  String ministryCode;
  int upperPositionId;
  String title;
  int levelOrder;
  String description;
  String status;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        id: json["id"],
        ministryCode: json["ministryCode"],
        upperPositionId: json["upperPositionId"],
        title: json["title"],
        levelOrder: json["levelOrder"],
        description: json["description"],
        status: json["status"],
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
