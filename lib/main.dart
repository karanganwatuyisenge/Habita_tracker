import 'geolocation.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //initialRoute: 'geolocation',
    initialRoute: 'signup',
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
    ),
    routes: {
      'geolocation':(context) => Location(),
      'login':(context) => MyLogin(),
      'signup':(context) => SignUp(),

      // background: linear-gradient(89.76deg, #37C871 4.24%, #5FE394 69.76%);
      // background: linear-gradient(48.62deg, #FFA450 11.85%, #FF5C00 66.77%);
    },
  ));
}