import 'myThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange
    // Add other light mode theme properties here
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Add other dark mode theme properties here
  );

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  void setTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}




// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'myThemes.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   bool _isDarkMode = false;
//
//   bool get isDarkMode => _isDarkMode;
//
//   void setTheme(bool value) {
//     _isDarkMode = value;
//     notifyListeners();
//   }
// }
// // class ThemeProvider extends ChangeNotifier {
// //   ThemeData _currentTheme = MyThemes.lightTheme;
// //
// //   ThemeData get currentTheme => _currentTheme;
// //
// //   void setTheme(bool isDarkMode) {
// //     _currentTheme = isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme;
// //     notifyListeners();
// //   }
// // }
//
