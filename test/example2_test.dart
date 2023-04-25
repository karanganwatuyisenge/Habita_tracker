import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/Help/nameList.dart';

void main() {
  testWidgets('NameList adds and displays a name with validator', (WidgetTester tester) async {
    final initialNames = ['John', 'Jane'];
    await tester.pumpWidget(
      MaterialApp(
        home: NameList(names: initialNames),
      ),
    );
    expect(find.text('bvcfg'), findsNothing);
    expect(find.text('kloi'), findsNothing);
    expect(find.text('No data'), findsOneWidget);

    // await tester.enterText(find.byType(TextFormField), '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please enter your name'), findsNWidgets(2));

    await tester.enterText(find.byType(TextFormField), 'asdw');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
  });

  // testWidgets('NameList adds and displays a name', (WidgetTester tester) async {
  //   final initialNames=['John','Jane'];
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: NameList(names: []),
  //     ),
  //   );
  //   expect(find.text('No data'), findsOneWidget);
  //   await tester.tap(find.byType(ElevatedButton));
  //   //expect(find.text('Johnan'), findsNothing);
  //   //expect(find.text('abcd'),findsNothing);
  //   await tester.enterText(find.byType(TextFormField), 'Johnan');
  //   await tester.enterText(find.byType(TextFormField), 'abcd');
  //   // expect(find.text('Jane'), findsOneWidget);
  //
  //   // void main() {
  //   //   testWidgets('Nameist adds and displays a name', (WidgetTester tester) async {
  //   //     // Pass an initial list of names to the NameList widget
  //   //     final initialNames = ['John', 'Jane'];
  //   //     await tester.pumpWidget(
  //   //       MaterialApp(
  //   //         home: NameList(names: initialNames),
  //   //       ),
  //   //     );
  //   //     expect(find.text('John'), findsOneWidget);
  //   //     expect(find.text('Jane'), findsOneWidget);
  //   //     expect(find.text('No data'), findsNothing);
  //   //
  //   //     await tester.enterText(find.byType(TextFormField), 'Mary');
  //   //     await tester.tap(find.byType(ElevatedButton));
  //   //     await tester.pump();
  //   //
  //   //     expect(find.text('Mary'), findsOneWidget);
  //   //   });
  //   // }
  //
  //   // await tester.enterText(find.byType(TextFormField), 'John');
  //   // await tester.tap(find.byType(ElevatedButton));
  //   // await tester.pump();
  //   //
  //   // expect(find.text('John'), findsOneWidget);
  // });

}
