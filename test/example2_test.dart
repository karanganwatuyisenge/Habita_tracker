import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_habit/Help/nameList.dart';

void main() {
  testWidgets('NameList adds and displays a name', (WidgetTester tester) async {
    final initialNames=['John','Jane'];
    await tester.pumpWidget(
      MaterialApp(
        home: NameList(names: []),
      ),
    );
    expect(find.text('No data'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    expect(find.text('Johnan'), findsNothing);
    // expect(find.text('Jane'), findsOneWidget);

    // void main() {
    //   testWidgets('Nameist adds and displays a name', (WidgetTester tester) async {
    //     // Pass an initial list of names to the NameList widget
    //     final initialNames = ['John', 'Jane'];
    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: NameList(names: initialNames),
    //       ),
    //     );
    //     expect(find.text('John'), findsOneWidget);
    //     expect(find.text('Jane'), findsOneWidget);
    //     expect(find.text('No data'), findsNothing);
    //
    //     await tester.enterText(find.byType(TextFormField), 'Mary');
    //     await tester.tap(find.byType(ElevatedButton));
    //     await tester.pump();
    //
    //     expect(find.text('Mary'), findsOneWidget);
    //   });
    // }

    // await tester.enterText(find.byType(TextFormField), 'John');
    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pump();
    //
    // expect(find.text('John'), findsOneWidget);
  });

}
