import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/Help/unitTesting.dart';

void main(){
  testWidgets('Reverse String widget test', (WidgetTester tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: UnitTesting(),
      ),
    );
    var textField=find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Hello');
    expect(find.text('Hello'), findsOneWidget);
    var button=find.text('Reverse');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(find.text('olleH'), findsOneWidget);
  });
}
