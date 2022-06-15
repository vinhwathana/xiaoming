class Ministry {
  Ministry({
    this.code,
    this.nameKh,
    this.nameEn,
    this.description,
  });

  String? code;
  String? nameKh;
  String? nameEn;
  String? description;

  factory Ministry.fromMap(Map<String, dynamic>? json) => Ministry(
        code: json?["code"],
        nameKh: json?["nameKH"],
        nameEn: json?["nameEN"],
        description: json?["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "nameKH": nameKh,
        "nameEN": nameEn,
        "description": description,
      };
}
