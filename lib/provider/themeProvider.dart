import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  Future<void> initTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = value;
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }
}

// class ThemeProvider with ChangeNotifier {
//   bool _isDarkMode = false;
//
//   ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.deepOrange
//   );
//
//   ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//   );
//
//   ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;
//
//   bool get isDarkMode => _isDarkMode;
//
//   void setTheme(bool value) {
//     _isDarkMode = value;
//     notifyListeners();
//   }
// }




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
