import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:tracker_habit/constants/contstants.dart';
import 'package:tracker_habit/models/city.dart';
import 'package:tracker_habit/models/country.dart';
import 'package:tracker_habit/models/region.dart';

import '../translation/rootSetUp.dart';

void main() {
  late Widget root;
  setUp(() async {
    root = await rootSetUp(root: const SignUp(), local: const Locale('en', 'US'));
  });

  testWidgets("description", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(DropdownButtonFormField<City>), findsNWidgets(1));
      expect(find.byType(DropdownButtonFormField<Region>), findsNWidgets(1));
      expect(find.byType(DropdownButtonFormField<Country>), findsNWidgets(1));
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

    });
  });
}
