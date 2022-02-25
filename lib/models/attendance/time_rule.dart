class TimeRule {
  TimeRule({
    required this.id,
    required this.ministryCode,
    required this.effectiveDate,
    required this.timeCheckIn1From,
    required this.timeCheckIn1To,
    required this.timeCheckOut1From,
    required this.timeCheckOut1To,
    required this.timeCheckIn2From,
    required this.timeCheckIn2To,
    required this.timeCheckOut2From,
    required this.timeCheckOut2To,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.deletedAt,
    required this.deletedBy,
  });

  int id;
  String? ministryCode;
  String? effectiveDate;
  String? timeCheckIn1From;
  String? timeCheckIn1To;
  String? timeCheckOut1From;
  String? timeCheckOut1To;
  String? timeCheckIn2From;
  String? timeCheckIn2To;
  String? timeCheckOut2From;
  String? timeCheckOut2To;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? deletedAt;
  String? deletedBy;

  factory TimeRule.fromMap(Map<String, dynamic> json) => TimeRule(
        id: json["id"],
        ministryCode: json["ministryCode"],
        effectiveDate: json["effectiveDate"],
        timeCheckIn1From: json["timeCheckIn1From"],
        timeCheckIn1To: json["timeCheckIn1To"],
        timeCheckOut1From: json["timeCheckOut1From"],
        timeCheckOut1To: json["timeCheckOut1To"],
        timeCheckIn2From: json["timeCheckIn2From"],
        timeCheckIn2To: json["timeCheckIn2To"],
        timeCheckOut2From: json["timeCheckOut2From"],
        timeCheckOut2To: json["timeCheckOut2To"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
        updatedBy: json["updatedBy"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        deletedBy: json["deletedBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ministryCode": ministryCode,
        "effectiveDate": effectiveDate,
        "timeCheckIn1From": timeCheckIn1From,
        "timeCheckIn1To": timeCheckIn1To,
        "timeCheckOut1From": timeCheckOut1From,
        "timeCheckOut1To": timeCheckOut1To,
        "timeCheckIn2From": timeCheckIn2From,
        "timeCheckIn2To": timeCheckIn2To,
        "timeCheckOut2From": timeCheckOut2From,
        "timeCheckOut2To": timeCheckOut2To,
        "createdBy": createdBy,
        "createdAt": createdAt,
        "updatedBy": updatedBy,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "deletedBy": deletedBy,
      };
}
