import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential({required User user}) {
    when(this.user).thenReturn(user);
  }
}

void main() {
  group('Login widget test', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late Widget testWidget;

    setUpAll(() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      mockFirebaseAuth=MockFirebaseAuth();
      testWidget =MaterialApp(
        home: MyLogin(),
        routes: {
          'signup':(_) => SignUp(),
          'home':(_) => Container(),
        },
      );
    });

    testWidgets(
        'displays email and password text fields', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      final emailFieldFinder = find.byWidgetPredicate(
            (widget) =>
        widget is TextField && widget.decoration?.hintText == 'Email',
      );
      final passwordFieldFinder = find.byWidgetPredicate(
            (widget) =>
        widget is TextField && widget.decoration?.hintText == 'Password',
      );

      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
    });

    testWidgets('displays error message for wrong password', (
        WidgetTester tester) async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: 'wrongpassword',
      )).thenThrow(FirebaseAuthException(
          code: 'wrong-password', message: 'Invalid email or password'));


      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField), 'test@gmail.com');
      await tester.enterText(find.byType(TextField), 'wrongpassword');
      await tester.tap(find.text('LogIn').hitTestable());
      await tester.pumpAndSettle();

      expect(find.text('WrongPassword'), findsOneWidget);
    });

    testWidgets('navigates to home page on successful login', (
        WidgetTester tester) async {
      final mockUserCredential = MockUserCredential(
        user: MockUser(
            email: 'test@gmail.com',
            displayName: 'Test User'
        ),
      );
      when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@gmail.com',
          password: 'password'
      )).thenAnswer((realInvocation) => Future.value(mockUserCredential));

        await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'test@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'correctpassword');
      await tester.tap(find.text('LogIn').hitTestable());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
