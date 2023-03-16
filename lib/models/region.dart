import 'package:tracker_habit/models/country.dart';

class Region {
  String name;
  String isoCode;
  String countryCode;

  Region({
    required this.name,
    required this.isoCode,
    required this.countryCode,

  });

  factory Region.fromJson(Map<String, dynamic> json) =>
      Region(
          name: json["name"],
          isoCode: json["isoCode"],
        countryCode: json['countryCode'],
      );
}
