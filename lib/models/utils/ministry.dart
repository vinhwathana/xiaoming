class Ministry {
  Ministry({
    required this.code,
    required this.nameKh,
    required this.nameEn,
    required this.description,
  });

  String code;
  String nameKh;
  String nameEn;
  String description;

  factory Ministry.fromMap(Map<String, dynamic> json) => Ministry(
        code: json["code"],
        nameKh: json["nameKH"],
        nameEn: json["nameEN"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "nameKH": nameKh,
        "nameEN": nameEn,
        "description": description,
      };
}
