import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
class HabitNotification extends StatefulWidget {
  const HabitNotification({Key? key}) : super(key: key);

  @override
  State<HabitNotification> createState() => _HabitNotificationState();
}

class _HabitNotificationState extends State<HabitNotification> {

  User user = FirebaseAuth.instance.currentUser!;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onSelectNotification(String? payload) async {
    // Handle notification click event
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Notification Clicked'),
          content: Text('You have clicked the notification'),
        );
      },
    );
    await showNotification();
  }
  Future<void> completeHabit(DocumentSnapshot habit) async {
    String habitId = habit.id;
    String formattedDate = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    DocumentReference habitRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits')
        .doc(habitId);
    await habitRef.update({
      'completed.$formattedDate.dates': FieldValue.arrayUnion([formattedDate]),
    });
  }
  List<DocumentSnapshot<Object?>> habits = [];

  Future<List<DocumentSnapshot<Object?>>> showNotification() async {
    DateTime now = DateTime.now();
    int currentWeekDayOfMonth = now.weekday;
    String formattedDateWeekly = '${DateFormat('yyyy-MM').format(
        DateTime.now())}-$currentWeekDayOfMonth';
    String formattedDateDaily =DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedDateMonthly = DateFormat('yyyy-MM').format(DateTime.now());
    QuerySnapshot weeklySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits')
        .where('habitType', isEqualTo: 'Weekly')
        .get();

    QuerySnapshot monthlySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits')
        .where('habitType', isEqualTo: 'Monthly')
        .get();

    QuerySnapshot dailySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits')
        .where('habitType', isEqualTo: 'Daily')
        .get();

    List<DocumentSnapshot> habits = [];
    weeklySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('completed')) {
        Map<String, dynamic> completed = data['completed'];
        if (completed.containsKey(formattedDateWeekly)) {
          List<dynamic> dates = completed[formattedDateWeekly]['dates'];
          if (dates != null &&
              !dates.contains(now.toString().substring(0, 10))) {
            habits.add(doc);
          }
        } else {
          habits.add(doc);
        }
      }
    });

    monthlySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('completed')) {
        Map<String, dynamic> completed = data['completed'];
        if (completed.containsKey(formattedDateMonthly)) {
          List<dynamic> dates = completed[formattedDateMonthly]['dates'];
          if (dates != null &&
              !dates.contains(now.toString().substring(0, 10))) {
            habits.add(doc);
          }
        } else {
          habits.add(doc);
        }
      }
    });

    dailySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('completed')) {
        Map<String, dynamic> completed = data['completed'];
        if (completed.containsKey(formattedDateDaily)) {
          List<dynamic> dates = completed[formattedDateDaily]['dates'];
          if (dates != null &&
              !dates.contains(now.toString().substring(0, 10))) {
            habits.add(doc);
          }
        } else {
          habits.add(doc);
        }
      }
    });

    String notificationBody = '';
    if (habits.isNotEmpty) {
      notificationBody =
      'You have ${habits.length} habits to complete today:\n';
      habits.forEach((habit) {
        notificationBody += '- ${habit['habitName']}\n';
      });
    } else {
      notificationBody = 'You have completed all your habits for today!';
    }
    print('Notification body: $notificationBody');

    var androidDetails = AndroidNotificationDetails('channelId', 'channelName');
    var notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Habit Tracker', notificationBody, notificationDetails);

    return habits;
  }

  Future showNotifications() async {
    var notificationDetails = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    await showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            Text(
              'You have ${habits.length} habits to complete today:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: showNotification(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  List<DocumentSnapshot> habits = snapshot.data!;
                  if (habits.isEmpty) {
                    return Text(
                      'You have completed all your habits for today!',
                      textAlign: TextAlign.center,
                    );
                  }
                  return ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(habits[index]['habitName']),
                        subtitle: Text(habits[index]['habitType']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


