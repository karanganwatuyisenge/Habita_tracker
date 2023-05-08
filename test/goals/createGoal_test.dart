// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:tracker_habit/screen/Goal/createNewGoal.dart';
//
// void main(){
//   testWidgets('Save new Goal', (WidgetTester tester) async{
//     await tester.pumpWidget(NewGoal());
//     var textField=find.byType(TextFormField);
//     expect(textField, findsNWidgets(3));
//     await tester.enterText(textField, 'asdf');
//     expect(find.text('asdf'),findsOneWidget );
//     var button=find.text('CreateNew');
//     expect(button, findsOneWidget);
//     await tester.tap(button);
//     await tester.pump();
//
//   });
// }