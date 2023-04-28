import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:tracker_habit/settings/account.dart';

void main() {
  group('Account widget', () {
    late MockFirebaseAuth auth;
    late FakeFirebaseFirestore firestore;
    late Account accountWidget;

    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      auth = MockFirebaseAuth();
      firestore = FakeFirebaseFirestore();
      accountWidget = Account();
    });

    testWidgets('should update account', (WidgetTester tester) async {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: 'class@gmail.com', password: 'class123');
      final user = userCredential.user!;
      await firestore.collection('users').doc(user.uid).set({'name': 'Test'});

      await tester.pumpWidget(accountWidget);

      final nameField = find.byKey(ValueKey('name_field'));
      await tester.enterText(nameField, 'New Name');
      final emailField = find.byKey(ValueKey('email_field'));
      await tester.enterText(emailField, 'newemail@gmail.com');
      final passwordField = find.byKey(ValueKey('password_field'));
      await tester.enterText(passwordField, 'newpassword');
      final confirmPasswordField = find.byKey(ValueKey('confirm_password_field'));
      await tester.enterText(confirmPasswordField, 'newpassword');
      final updateButton = find.byKey(ValueKey('update_button'));
      await tester.tap(updateButton);
      await tester.pumpAndSettle();

      final updatedUser = auth.currentUser!;
      expect(updatedUser.email, 'newemail@gmail.com');
      expect(updatedUser.displayName, 'New Name');

      final userDoc = await firestore.collection('users').doc(updatedUser.uid).get();
      final userData = userDoc.data();
      expect(userData!['name'], 'New Name');
      expect(userData['email'], 'newemail@gmail.com');
    });
  });
}
