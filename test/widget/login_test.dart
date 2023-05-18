import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/authentication/login.dart';
import '../translation/rootSetUp.dart';
import '../userRepository_test.dart';

void main() {
  late Widget root;
  final auth=MockFirebaseAuth();

  setUp(() async {
   TestWidgetsFlutterBinding.ensureInitialized();
    root = await rootSetUp(root: const MyLogin(),
        local: const Locale('en', 'US'));
  });

  testWidgets("Login test", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });
  });
}