import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/authentication/signup.dart';

import '../translation/rootSetUp.dart';

void main() {
  late Widget widget;
  setUp(() async {
    widget = await rootSetUp(
        root: SignUp(),
        local: Locale('en', 'US'));
  });
  testWidgets("description", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await tester.idle();
      await tester.pump();
     expect(find.text('Email'),findsOneWidget);
    });
  });
}

// void main() {
//   testWidgets('SignUp form validation', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: SignUp()));
//     // var textFieldName = find.byKey(Key('nameField'));
//     // await tester.enterText(textFieldName, 'John');
//     // var textFieldEmail = find.byKey(Key('emailField'));
//     // await tester.enterText(textFieldEmail, 'John@gmail.com');
//     // var dropDownButtonCountry = find.byKey(Key('countryField'));
//     // await tester.tap(dropDownButtonCountry);
//     // await tester.pumpAndSettle();
//     // var dropDownButtonRegion = find.byKey(Key('regionField'));
//     // await tester.tap(dropDownButtonRegion);
//     // await tester.pumpAndSettle();
//     // var dropDownButtonCity = find.byKey(Key('cityField'));
//     // await tester.tap(dropDownButtonCity);
//     // await tester.pumpAndSettle();
//     // var textFieldPassword = find.byKey(Key('passwordField'));
//     // await tester.enterText(textFieldPassword, 'password123');
//     // var textFieldConfirm = find.byKey(Key('confirmField'));
//     // await tester.enterText(textFieldConfirm, 'password123');
//     // await tester.tap(find.text('SignUp'));
//     // await tester.pumpAndSettle();
//   });
// }

//testWidgets('Signup', (WidgetTester tester) async{
//   await tester.pumpWidget(MaterialApp(
//     home: SignUp(),
//   ));
//   var textField=find.byType(TextFormField);
//    expect(textField, findsNWidgets(4));
//
//
// });
// await tester.tap(find.byType(ElevatedButton));
// await tester.pump();

// void main() {
//
//     final Finder signUpButtonFinder = find.widgetWithText(ElevatedButton, 'SIGN UP');
//     expect(signUpButtonFinder, findsOneWidget);
//     await tester.tap(signUpButtonFinder);
//     await tester.pumpAndSettle();
//     // Add your assertions here
//   });
// }
