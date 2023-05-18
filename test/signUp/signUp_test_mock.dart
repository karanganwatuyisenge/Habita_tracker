import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:tracker_habit/mocker/fetchCountries.dart';

import '../translation/rootSetUp.dart';

void main() {
   setUpAll(() => HttpOverrides.global = null);
  late Widget root;
  setUp(() async {
    root =
        await rootSetUp(root: const SignUp(), local: const Locale('en', 'US'));
  });

  testWidgets("description", (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      var fetchCountries = fetchCountriesMock();
      // Populate the fake database.
      final firestore = FakeFirebaseFirestore();
      await firestore.collection('users').add({
        'name': 'rosine',
        'email': 'rosine@gmail.com',
      });

      // await tester.tap(find.byType(ElevatedButton));


      await tester.ensureVisible(find.widgetWithText(ElevatedButton, "Sign Up"));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Please Enter Your Name'), findsOneWidget);
      expect(find.text('Please Enter Your Email'), findsOneWidget);
      expect(find.text('Please Select Country'), findsOneWidget);

      
      await tester.enterText(find.byKey(Key('nameField')), 'Hi');
      await tester.enterText(find.byKey(Key('emailField')), 'Hi@gmail.com');
      expect(find.text('Algeria'), findsOneWidget);
      expect(find.text('Albania'), findsOneWidget);
      expect(find.text('Angola'), findsOneWidget);
      await tester.pumpAndSettle();

      
      
      
      
      

      // await tester.tap(find.byType(ElevatedButton));
      // await tester.pump();
      //
      // expect(find.text('Please Enter Your Name'), findsOneWidget);
      // expect(find.byType(ElevatedButton), findsOneWidget);

      // await tester.enterText(find.byKey(Key('nameField')), 'rosine');
      // await tester.pump();
      // expect(find.text('rosine'), findsOneWidget);
    });
  });
}

//
// await tester.tap(find.byKey(const Key('countryField')));
// await tester.pumpAndSettle();
//
// // Replace 'Algeria' with the actual value of the desired item in the dropdown
// await tester.tap(find.text('Algeria').last);
// await tester.pumpAndSettle();
