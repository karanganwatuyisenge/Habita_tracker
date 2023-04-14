import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class ShowNotification extends StatefulWidget {
  const ShowNotification({Key? key}) : super(key: key);

  @override
  State<ShowNotification> createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  @override
  void initState() {
    super.initState();

    // Initialize time zones
    tz.initializeTimeZones();
    showNotification();

    // Schedule the background task to run every minute
    AndroidAlarmManager.periodic(
        const Duration(seconds: 10), 0, showNotification);
  }

  // This function runs in the background
  Future<void> showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high channel',
      'Very important notification!!',
      description: 'the first notification',
      importance: Importance.max,
    );

    // Get the list of incomplete habits of today
    List<String> incompleteHabits = ["Habit 1", "Habit 2"];

    if (incompleteHabits.isNotEmpty) {
      // Construct the message for the notification
      String message =
          "You have ${incompleteHabits.length} incomplete habit(s) for today: ";
      for (String habit in incompleteHabits) {
        message += "$habit, ";
      }
      message = message.substring(0, message.length - 2);

      // Show the notification
      await flutterLocalNotificationsPlugin.show(
        0,
        'Incomplete Habits',
        message,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'incomplete habits channel id',
            'Incomplete Habits',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
        ),
      );
    }
    print('showNotification called');

    try {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // Rest of the code

    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification example'),
      ),
      body: const Center(
        child: Text('Notification will be triggered automatically'),
      ),
    );
  }
}
