import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/models/region.dart';

void main(){
  group('Region test', () {
    test('Region.fromJson returns a valid region', () async {
      final Map<String,dynamic> json={
        "name":"California",
        "isoCode":"CA",
        "countryCode":"Us"
      };
      final Region region=Region.fromJson(json);
      var name = json["name"];
      var isoCode=json["isoCode"];
      var countryCode=json["countryCode"];
      expect(name, region.name);
      expect(isoCode,region.isoCode);
      expect(countryCode, region.countryCode);

    });
  });
}

