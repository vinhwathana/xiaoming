

class CertificatePeopleStat {
  CertificatePeopleStat({
    this.id,
    this.eLvl,
    this.gender,
    this.position,
    this.education,
    this.skill,
    this.schoolName,
    this.country,
    this.startDate,
    this.endDate,
    this.firstNameKh,
    this.lastNameKh,
  });

  String? id;
  String? eLvl;
  String? gender;
  String? position;
  String? education;
  String? skill;
  String? schoolName;
  String? country;
  String? startDate;
  DateTime? endDate;
  String? firstNameKh;
  String? lastNameKh;

  factory CertificatePeopleStat.fromJson(Map<String, dynamic> json) {
    return CertificatePeopleStat(
      id: json["id"],
      eLvl: json["e_lvl"],
      gender: json["gender"],
      position: json["position"],
      education: json["education"],
      skill: json["skill"],
      schoolName: json["schoolName"] ?? "",
      country: json["country"],
      startDate: json["startDate"],
      endDate:
          (json["endDate"] == null) ? null : DateTime.parse(json["endDate"]),
      firstNameKh: json["firstNameKH"],
      lastNameKh: json["lastNameKH"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "e_lvl": eLvl,
        "gender": gender,
        "position": position,
        "education": education,
        "skill": skill,
        "schoolName": schoolName,
        "country": country,
        "startDate": startDate,
        "endDate":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "firstNameKH": firstNameKh,
        "lastNameKH": lastNameKh,
      };
}
