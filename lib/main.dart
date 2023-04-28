import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/Help/brightness.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:tracker_habit/firebase_options.dart';
import 'package:tracker_habit/geolocation.dart';
import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/provider/myThemes.dart';
import 'package:tracker_habit/provider/themeProvider.dart';
import 'package:tracker_habit/screen/fetchData.dart';
import 'package:tracker_habit/screen/habit/dailyHabit.dart';
import 'package:tracker_habit/screen/habit/habitScreen.dart';
import 'package:tracker_habit/Help/help3.dart';
import 'package:tracker_habit/Help/nameList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tracker_habit/settings/setting.dart';

import 'authentication/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init(); // Initialize NotificationService
  await NotificationService().scheduleNotification(); // Schedule notification
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
       // Locale('rw', 'RW'),
        //Locale('Kinyarwanda','rw', 'RW'),
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return EasyLocalization(
                  supportedLocales: const [
                  Locale('en', 'US'),
              Locale('fr', 'FR'),
              // Locale('rw', 'RW'),
              // Locale('Kinyarwanda','rw', 'RW'),
              ],
              path: 'assets/translations',
              fallbackLocale: const Locale('en', 'US'),
              child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              initialRoute: 'login',
              theme: themeProvider.themeData,
              routes: {
              'geolocation': (context) => const Location(),
              'login': (context) => const MyLogin(),
              'signup': (context) => const SignUp(),
              'home': (context) => HomePage(),
              'habitScreen': (context) => const HabitScreen(),
              'fetchData': (context) => FetchData(),
              'help': (context) => const Display(),
              'daily': (context) => const DailyHabit(),
              'testWidget': (context) => NameList(names: [],),
              'brightness': (context) => Brightness(),
              'setting':(context) => Setting()
              },
              home: HomePage(),
              ));
            }));
  }
}
