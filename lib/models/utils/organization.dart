import 'package:xiaoming/models/utils/list_value.dart';
import 'package:xiaoming/models/utils/ministry.dart';

class Organization {
  Organization({
    required this.id,
    required this.parent,
    required this.ministry,
    required this.organizationType,
    required this.region,
    required this.nameKh,
    required this.nameEn,
    required this.description,
  });

  int? id;
  Organization? parent;
  Ministry? ministry;
  ListValue? organizationType;
  ListValue? region;
  String? nameKh;
  String? nameEn;
  String? description;

  factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        id: json["id"],
        parent: json["parent"] == null
            ? null
            : Organization.fromMap(json["parent"]),
        ministry: json["ministry"],
        organizationType: ListValue.fromMap(json["organizationType"]),
        region: ListValue.fromMap(json["region"]),
        nameKh: json["nameKH"],
        nameEn: json["nameEN"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parent": parent == null ? null : parent!.toMap(),
        "ministry": ministry,
        "organizationType": organizationType?.toMap(),
        "region": region?.toMap(),
        "nameKH": nameKh,
        "nameEN": nameEn,
        "description": description,
      };
}
