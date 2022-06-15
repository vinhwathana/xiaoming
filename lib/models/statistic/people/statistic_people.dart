class StatisticPeople {
  StatisticPeople(
      {this.id,
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
      this.org,
      this.dept,
      this.meritName,
      this.recievedDate,
      this.krobKhanTypeName});

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
  String? krobKhanTypeName;
  String? org;
  String? dept;
  String? meritName;
  String? recievedDate;

  factory StatisticPeople.fromJson(Map<String, dynamic> json) {
    return StatisticPeople(
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
      dept: json["dept"],
      org: json["org"],
      meritName: json["meritName"],
      recievedDate: json["recievedDate"],
      krobKhanTypeName: json["krobKhanTypeName"],
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
        "org": org,
        "dept": dept,
        "meritName": meritName,
        "recievedDate": recievedDate,
        "krobKhanTypeName": krobKhanTypeName,
      };
}
