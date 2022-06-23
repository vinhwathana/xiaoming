import 'dart:convert';

TodayWorkPeriod todayWorkPeriodFromJson(String str) =>
    TodayWorkPeriod.fromJson(json.decode(str));

String todayWorkPeriodToJson(TodayWorkPeriod data) =>
    json.encode(data.toJson());

class TodayWorkPeriod {
  TodayWorkPeriod({
    this.lastScan,
    this.periodInHour = 0.0,
    this.logInfo,
  });

  dynamic lastScan;
  double? periodInHour;
  LogInfo? logInfo;

  factory TodayWorkPeriod.fromJson(Map<String, dynamic> json) =>
      TodayWorkPeriod(
        lastScan: json["lastScan"],
        periodInHour: json["periodInHour"],
        logInfo: LogInfo.fromJson(json["logInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "lastScan": lastScan,
        "periodInHour": periodInHour,
        "logInfo": logInfo?.toJson(),
      };

  @override
  String toString() {
    return 'TodayWorkPeriod{lastScan: $lastScan, periodInHour: $periodInHour, logInfo: $logInfo}';
  }
}

class LogInfo {
  LogInfo({
    this.timeRule,
    this.date,
    this.summary,
    this.logs,
  });

  TimeRule? timeRule;
  String? date;
  dynamic summary;
  List<dynamic>? logs;

  factory LogInfo.fromJson(Map<String, dynamic> json) => LogInfo(
        timeRule: TimeRule.fromJson(json["timeRule"]),
        date: json["date"],
        summary: json["summary"],
        logs: List<dynamic>.from(json["logs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "timeRule": timeRule?.toJson(),
        "date": date,
        "summary": summary,
        "logs": List<dynamic>.from(logs?.map((x) => x) ?? []),
      };
}

class TimeRule {
  TimeRule({
    this.id,
    this.ministryCode,
    this.effectiveDate,
    this.timeCheckIn1From,
    this.timeCheckIn1To,
    this.timeCheckOut1From,
    this.timeCheckOut1To,
    this.timeCheckIn2From,
    this.timeCheckIn2To,
    this.timeCheckOut2From,
    this.timeCheckOut2To,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.deletedAt,
    this.deletedBy,
  });

  int? id;
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
  dynamic deletedAt;
  dynamic deletedBy;

  factory TimeRule.fromJson(Map<String, dynamic> json) => TimeRule(
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

  Map<String, dynamic> toJson() => {
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
