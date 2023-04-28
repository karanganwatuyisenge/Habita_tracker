import 'package:flutter/material.dart';
import '../provider/myThemes.dart';

class Brightness extends StatefulWidget {
  const Brightness({Key? key}) : super(key: key);

  @override
  State<Brightness> createState() => _BrightnessState();
}

class _BrightnessState extends State<Brightness> {
  static const String _title = "Habit Tracker";
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ],
        ),
        body: Text('Hello'),
      ),
    );
  }
}
