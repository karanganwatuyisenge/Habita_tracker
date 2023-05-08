import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/models/language.dart';

void main(){
  group('Language', () {
    test('Language.fromJson returns a valid language', () async{
      final Map<String,dynamic> json={
        "name":"English",
        "icon":"us.png"
      };
      final Language language=Language.fromJson(json);
      var names=json["name"];
      var icons=json["icon"];
      expect(names, language.name);
      expect(icons, language.icon);
    });
  });
}

