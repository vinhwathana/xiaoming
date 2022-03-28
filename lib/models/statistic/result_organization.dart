import 'dart:convert';

ResultOrganization resultOrganizationFromMap(String str) =>
    ResultOrganization.fromMap(json.decode(str));

String resultOrganizationToMap(ResultOrganization data) =>
    json.encode(data.toMap());

class ResultOrganization {
  ResultOrganization({
    required this.totalFilteredRecord,
    required this.data,
  });

  int totalFilteredRecord;
  List<Datum> data;

  factory ResultOrganization.fromMap(Map<String, dynamic> json) =>
      ResultOrganization(
        totalFilteredRecord: json["totalFilteredRecord"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalFilteredRecord": totalFilteredRecord,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.displayText,
  });

  final int id;
  final String displayText;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        displayText: json["displayText"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "displayText": displayText,
      };
}
