class CalismaSuresi {
  final int dakika;
  final DateTime creationDate;

  CalismaSuresi({required this.dakika, required this.creationDate});

  factory CalismaSuresi.fromJson(Map<String, dynamic> json) => CalismaSuresi(
    dakika: json["dakika"],
    creationDate: DateTime.parse(json["creationDate"]),
  );

  Map<String, dynamic> toJson() => {
    "dakika": dakika,
    "creationDate":
        "${creationDate.year.toString().padLeft(4, '0')}-${creationDate.month.toString().padLeft(2, '0')}-${creationDate.day.toString().padLeft(2, '0')}",
  };
}
