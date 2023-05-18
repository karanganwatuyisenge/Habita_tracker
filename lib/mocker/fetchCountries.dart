import 'package:tracker_habit/models/country.dart';

Future<List<Country>> fetchCountriesMock() async {
  // Create a list of mocked countries
  List<Country> countries = [
    Country(name: 'Algeria', wikiDataId: '1'),
    Country(name: 'Albania', wikiDataId: '2'),
    Country(name: 'Angola', wikiDataId: '3'),
  ];

  return countries;
}