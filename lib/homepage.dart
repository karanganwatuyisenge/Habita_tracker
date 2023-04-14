import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/Goal/goalScreens.dart';
import 'package:tracker_habit/screen/createAchievement.dart';
import 'package:tracker_habit/screen/fetchData.dart';
import 'package:tracker_habit/screen/goalScreen.dart';
import 'package:tracker_habit/screen/habit/habitScreen.dart';
import 'progressess/progressess.dart';
import 'settings/setting.dart';
import 'package:intl/intl.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;


void showNotification() async {
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

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user=FirebaseAuth.instance.currentUser!;
  DateTime? currentDate;
  String? formattedDate;
  String _userName = '';
  List<String> _data = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  int habitCount=0;
  int totalCompletedHabit=0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    completedToday();
    getHabitCount();
    tz.initializeTimeZones();
    //showNotification();
scheduleTimer();
  }

  scheduleTimer() async {
   var s=await AndroidAlarmManager.periodic(
        const Duration(minutes: 1), 0, showNotification,allowWhileIdle: true );
print("Timer scheduled: $s");
  }
  Future<void> getHabitCount() async {
    CollectionReference habitsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits');
    QuerySnapshot querySnapshot = await habitsRef.get();
    setState(() {
      habitCount = querySnapshot.size;
    });
  }

  Future<void> completedToday() async {
    DateTime today = DateTime.now();
    String formattedDateMonthly = DateFormat('yyyy-MM').format(today);
    String formattedDateDaily = DateFormat('yyyy-MM-dd').format(today);
    DateTime now = DateTime.now();
    int currentWeekDayOfMonth = now.weekday;
    String formattedDateWeekly =
        '${DateFormat('yyyy-MM').format(DateTime.now())}-$currentWeekDayOfMonth';

    num completedCountMonthly = 0;
    num completedCountWeekly = 0;
    num completedCountDaily = 0;

    await Future.wait([
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .where('completed.$formattedDateMonthly.dates', arrayContains: formattedDateDaily)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> completedMap = doc['completed'][formattedDateMonthly];
          if (completedMap != null && completedMap['count'] != null) {
            completedCountMonthly += completedMap['count'];
          }
        });
      }),
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .where('completed.$formattedDateWeekly.dates', arrayContains: formattedDateDaily)
          .get()
          .then((querySnapshotWeekly) {
        querySnapshotWeekly.docs.forEach((doc) {
          Map<String, dynamic> completeMap = doc['completed'][formattedDateWeekly];
          if (completeMap != null && completeMap['count'] != null) {
            completedCountWeekly += completeMap['count'];
          }
        });
      }),
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .where('completed.$formattedDateDaily.dates', arrayContains: formattedDateDaily)
          .get()
          .then((querySnapshot1) {
        querySnapshot1.docs.forEach((doc) {
          Map<String, dynamic> completedMap = doc['completed'][formattedDateDaily];
          if (completedMap != null && completedMap['count'] != null) {
            completedCountDaily += completedMap['count'];
          }
        });
      })
    ]);

    setState(() {
      totalCompletedHabit =
          completedCountMonthly.toInt() + completedCountDaily.toInt() + completedCountWeekly.toInt();
    });

  }

  void getCurrentUser() async {
    User user = auth.currentUser!;
    String userId = user.uid;
    DocumentSnapshot snapshot = await _firestore.collection('users')
        .doc(userId)
        .get();

    setState(() {
      _userName = snapshot.get('name');
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _data = ['Item 1', 'Item 2', 'Item 3'];
    });
  }

  Future <void> _dialogBuilder(BuildContext context) {
    // Navigator.of(context).pushNamed('fetchData');
    //
    // return Future.value();
    FetchData();
    return showDialog <void>(
        context: context,
        builder: (BuildContext context) {
          return NewAchievement();
        });
  }

  @override
  Widget build(BuildContext context) {
    //showNotification();
    //completedToday();
    currentDate = DateTime.now();
    formattedDate = DateFormat('E, d MMMM yyyy').format(currentDate!);
    double value = 0;
    double percentage = 0;

    if (habitCount != 0) {
      value = totalCompletedHabit / habitCount;
      percentage = value * 100;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarOpacity: 1.0,
        // bottomOpacity: 1.0,
        elevation: 0,
        title: Text('$formattedDate',
          style: TextStyle(color: Color(0xff4c505b),),
        ),
      ),
            body:NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, right: 210.0),
                      child: RichText(
                        text:  TextSpan(
                          style: TextStyle(fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: 'Hello,'),
                            TextSpan(text: '$_userName !',
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.deepOrangeAccent)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 18.0, right: 18.0),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        alignment: Alignment.center,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.deepOrange,
                              Colors.orangeAccent,
                            ],

                          ),
                          // color: Colors.orange,
                        ),
                        child: Stack(
                          children: [
                            //double value = totalCompletedHabit / habitCount;
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                     SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 15,
                                        backgroundColor: Colors.white60,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white70),
                                      ),
                                    ),
                                    Text('${percentage.toStringAsFixed(0)}%',
                                      style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('$totalCompletedHabit of $habitCount habits', style: TextStyle(
                                        fontSize: 20, color: Colors.white),),
                                    const Text('completed today!', style: TextStyle(
                                        fontSize: 20, color: Colors.white),),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: -10,
                              right: 0,
                              child: Image.asset('assets/images/calendar.png',
                                width: 120,
                                alignment: Alignment.bottomRight,
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: GoalScreens(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )];
            },
              body: Padding(
                padding: const EdgeInsets.only(left:18.0,right: 18.0),
                child: HabitScreen(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          onPressed:() => _dialogBuilder(context)
      ),
      bottomNavigationBar: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home, color: Colors.orangeAccent,),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Progress()));
                  },
                  icon: const Icon(Icons.show_chart),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const Setting()));
                  },
                  icon: const Icon(Icons.settings),
                ),

              ]
          )
      ),
          );


  }
}
// body: Builder(
//   builder: (BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () {
//         if (mounted) {
//           return _refreshData();
//         }
//         else {
//           return Future.value();
//         }
//       },