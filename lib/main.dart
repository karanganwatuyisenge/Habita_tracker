import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/screen/fetchData.dart';
import 'package:tracker_habit/screen/habit/dailyHabit.dart';
import 'package:tracker_habit/screen/habit/habitScreen.dart';
import 'package:tracker_habit/showNotification.dart';
import 'Help/help3.dart';
import 'geolocation.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;


Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',

    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
    ),
    routes: {
      'geolocation':(context) => Location(),
      'login':(context) => MyLogin(),
      'signup':(context) => SignUp(),
      'home':(context) => HomePage(),
      'habitScreen':(context) => HabitScreen(),
      'fetchData':(context) => FetchData(),
      'help':(context) => Display(),
      'daily':(context) =>DailyHabit(),
      'notification':(context) => ShowNotification(),

      // background: linear-gradient(89.76deg, #37C871 4.24%, #5FE394 69.76%);
      // background: linear-gradient(48.62deg, #FFA450 11.85%, #FF5C00 66.77%);
    },
  ));
}