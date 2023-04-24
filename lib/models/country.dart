class Country {
  String name;
  String wikiDataId;


  Country({
    required this.name,
    required this.wikiDataId,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(
          name: json["name"],
          wikiDataId: json["wikiDataId"]);
}


