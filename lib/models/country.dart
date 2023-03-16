class Country {
  String name;
  String wikiDataId;
  // List<String> callingCodes = [];
  // Flag flag;

  // bool independent;

  Country({
    required this.name,
    required this.wikiDataId,
    // required this.callingCodes,
    // required this.flag,
    // required this.independent,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      name: json["name"],
      wikiDataId: json["wikiDataId"]);
      // callingCodes: (List<String>.from(json["callingCodes"] )),
      // flag: Flag.fromJson(json["flags"]),
      // independent: json["independent"]);
}
//
// class Flag {
//   final String svg;
//   final String png;
//
//   Flag({
//     required this.svg,
//     required this.png,
//   });
//
//   factory Flag.fromJson(Map<String, dynamic> json) =>
//       Flag(svg: json["svg"], png: json["png"]);
// }


