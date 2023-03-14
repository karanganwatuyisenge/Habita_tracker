class Region {
  String name;
  String isoCode;

  Region({
    required this.name,
    required this.isoCode,

  });

  factory Region.fromJson(Map<String, dynamic> json) =>
      Region(
          name: json["name"],
          isoCode: json["isoCode"]);
}
