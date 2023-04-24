// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:tracker_habit/screen/Goal/goalScreens.dart';
//
// void main(){
//   group('NewGoal', () {
//     test('Test New Goal method', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home:Scaffold(
//           body: Form(
//             key: GlobalKey<FormState>(),
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: TextEditingController(text: 'New Goal'),
//                 ),
//                 TextFormField(
//                   controller: TextEditingController(text: '2023-04-30'),
//                 ),
//                 RaisedButton(
//                   onPressed: () =>SaveGoal(),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ));
//       await tester.enterText(findByType(TextFormField).at(0), 'New Goal');
//       await tester.enterText(findByType(TextFormField).at(1), '2023-04-30');
//       await tester.tap(findByType(RaisedButton));
//
//       await tester.pumpAndSettle();
//       expect(find.text('New Goal Saved Successfully'), findsOneWidget);
//       expect(find.text('New Goal'), findsNothing);
//       expect(find.text('2023-04-30'), findsNothing);
//     });
//   });
// }
