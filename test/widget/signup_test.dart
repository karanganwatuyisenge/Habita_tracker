import 'dart:io';

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
  setUpAll(() => HttpOverrides.global = null);
  late Widget root;
  setUp(() async {
    root =
        await rootSetUp(root: const SignUp(), local: const Locale('en', 'US'));
  });

  testWidgets("description", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('nameField')), 'Rosine');
      expect(find.text('Rosine'), findsOneWidget);

      await tester.enterText(find.byKey(Key('passwordField')), 'rosine12345');
      expect(find.text('rosine12345'), findsOneWidget);

      await tester.enterText(find.byKey(Key('nameField')), 'Rosine');
      await tester.pump();

      await tester.enterText(find.byKey(Key('emailField')), 'rosine@gmail.com');
      await tester.pump();
      await tester.enterText(find.byKey(Key('passwordField')), 'rosine123');
      expect(find.text("rosine123"), findsOneWidget);
      await tester.enterText(find.byKey(Key('confirmField')), 'rosine123');
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
