import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/models/country.dart';

void main(){
  group('Country test', () {
    test('Country.fromJson returns a valid country', () async {
      final Map<String,dynamic> json={
        "name":"United States",
          "wikiDataId":"Q30",
        };
      final Country country=Country.fromJson(json);
      var names = json["name"];
      var wikiIds= json["wikiDataId"];
      expect(names,country.name);
      expect(wikiIds,country.wikiDataId);
    });
  });
}

