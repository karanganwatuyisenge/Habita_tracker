import 'package:flutter/material.dart';
class MyThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    // Add more theme properties as necessary
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    // Add more theme properties as necessary
  );
}

// class MyThemes {
//   static final darkTheme=ThemeData(
//     scaffoldBackgroundColor: Colors.grey.shade900
//   );
//   static final lightTheme=ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//         primarySwatch: Colors.deepOrange,
//   );
// }
// theme: ThemeData(
//   primarySwatch: Colors.deepOrange,
// ),