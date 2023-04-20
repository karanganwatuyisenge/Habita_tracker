import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/screen/fetchData.dart';
import 'package:tracker_habit/screen/habit/dailyHabit.dart';
import 'package:tracker_habit/screen/habit/habitScreen.dart';
import 'Help/help3.dart';
import 'geolocation.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
       // Locale('rw', 'RW'),

        //Locale('Kinyarwanda', 'rw', 'RW'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        routes: {
          'geolocation': (context) => const Location(),
          'login': (context) => const MyLogin(),
          'signup': (context) => const SignUp(),
          'home': (context) => HomePage(),
          'habitScreen': (context) => const HabitScreen(),
          'fetchData': (context) => FetchData(),
          'help': (context) => const Display(),
          'daily': (context) => const DailyHabit(),
        },
        //home: MyHomePage()
    );
  }
}








