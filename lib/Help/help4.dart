// // // import 'package:flutter/material.dart';
// // //
// // // class Help4 extends StatefulWidget {
// // //   const Help4({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<Help4> createState() => _Help4State();
// // // }
// // //
// // // class _Help4State extends State<Help4> {
// // //   Map<String, Map<String, dynamic>> myMap = {
// // //     'January2023': {
// // //       'count': 5,
// // //       'dates': ['2023-01-02', '2023-01-04', '2023-01-07', '2023-01-09', '2023-01-11']
// // //     },
// // //     'February2023': {
// // //       'count': 3,
// // //       'dates': ['2023-02-02', '2023-02-04', '2023-02-07','2023-04-05']
// // //     },
// // //     'March2023': {
// // //       'count': 7,
// // //       'dates': ['2023-03-01', '2023-03-05', '2023-03-07', '2023-03-10', '2023-03-14', '2023-03-17', '2023-03-20']
// // //     }
// // //   };
// // //   Hashmap have another map insidewhich have the name of month,year we are in(which has one field called count that has a datatype of number and other field called dates have a datatype of an array and that array holds a string ) in flutter help me to implement it and how can i access dates field where dates is not equal to current dates
// // //   void printValidDates() {
// // //     String currentDate = DateTime.now().toString().substring(0, 10);
// // //     myMap.forEach((monthYear, monthData) {
// // //       List<String> validDates = [];
// // //       monthData['dates'].forEach((date) {
// // //         if (date != currentDate) {
// // //           validDates.add(date);
// // //         }
// // //       });
// // //       print('Month-Year: $monthYear');
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     printValidDates();
// // //     return const Placeholder();
// // //   }
// // // }
// //
// //
// // // DateTime startDate = habit['startDate']; // Assuming habit['startDate'] is a DateTime object
// // // int habitFrequency = habit['habitFrequency']; // Assuming habit['habitFrequency'] is an int representing the number of days between habit repetitions
// // //
// // // // Calculate the target completion date based on the start date and habit frequency
// // // DateTime targetCompletionDate = startDate.add(Duration(days: habitFrequency * 7)); // Assuming habit is repeated weekly
// // //
// // // // Calculate the number of remaining days until the target completion date
// // // int remainingDays = targetCompletionDate.difference(DateTime.now()).inDays;
// // //
// // // // Display the remaining days in the UI
// // // const TextStyle textStyle = TextStyle(
// // //   color: Color(0xFF2F2F2F),
// // //   fontSize: 20,
// // // );
// // // const EdgeInsets contentPadding = EdgeInsets.symmetric(vertical: 0);
// // // return Padding(
// // // padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
// // // child: Container(
// // // decoration: BoxDecoration(
// // // borderRadius: BorderRadius.circular(5),
// // // color: const Color(0xFFFBFBFB),
// // // ),
// // // child: Padding(
// // // padding: const EdgeInsets.only(left: 8.0, right: 8.0),
// // // child: Column(
// // // children: [
// // // ListTile(
// // // contentPadding: const EdgeInsets.symmetric(vertical: 0),
// // // title: Text(
// // // "${habit['habitName']}",
// // // style: const TextStyle(color: Color(0xFF2F2F2F), fontSize: 25),
// // // ),
// // // trailing: IconButton(
// // // onPressed: () {
// // // Navigator.push(
// // // context,
// // // MaterialPageRoute(builder: (context) => HabitReport(habitName: habit['habitName'])),
// // // );
// // // },
// // // icon: const Icon(Icons.info_outline_rounded),
// // // ),
// // // ),
// // // const ListTile(
// // // contentPadding: contentPadding,
// // // title: LinearProgressIndicator(
// // // minHeight: 15,
// // // value: 0.5,
// // // backgroundColor: Colors.grey,
// // // valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
// // // ),
// // // ),
// // // ListTile(
// // // contentPadding: contentPadding,
// // // title: Text(
// // // '${remainingDays.toString()} from ${((DateTime.now().difference(startDate).inDays / habitFrequency) * 7).toStringAsFixed(0)} days target',
// // // style: textStyle,
// // // ),
// // // ),
// // // ],
// // // ),
// // // ),
// // // ),
// // // );
// //
// // // Import the necessary packages
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // // Get the current date
// // DateTime currentDate = DateTime.now();
// //
// // // Create a reference to the Firestore collection
// // CollectionReference habitsCollection =
// // FirebaseFirestore.instance.collection('habits');
// //
// // // Create a query to filter the documents based on the completed dates
// // Query query = habitsCollection.where('completed.habitPeriod.${currentDate.toString().substring(0, 10)}', isNull: true);
// //
// // // Retrieve the documents that match the query
// // QuerySnapshot querySnapshot = await query.get();
// //
// // // Loop through the documents and print the habit names
// // querySnapshot.docs.forEach((doc) {
// // print(doc.data()['habitName']);
// // });
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:tracker_habit/screen/Goal/seeAllGoal.dart';
// // import 'package:tracker_habit/screen/habit/dailyHabit.dart';
// // import 'package:tracker_habit/screen/habit/habitReport.dart';
// // import 'package:intl/intl.dart';
// // import 'package:tracker_habit/screen/habit/monthlyHabit.dart';
// // import 'package:tracker_habit/screen/habit/weeklyHabit.dart';
// //
// // import '../../homepage.dart';
// //
// // class HabitScreen extends StatefulWidget {
// //   HabitScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HabitScreen> createState() => _HabitScreen();
// // }
// //
// // class _HabitScreen extends State<HabitScreen> {
// //
// //   @override
// //   Widget build(BuildContext context){
// //     return Scaffold();
// //   }
//
//
//
//
// // bool showvalue = false;
// // User user = FirebaseAuth.instance.currentUser!;
// // String? habitPeriod;
// // DateTime currentDate = DateTime.now();
// // var todays = DateTime.now().toString().substring(0, 10);
// //
// // @override
// // Widget build(BuildContext context) {
// // return DefaultTabController(
// // length: 3, // The number of tabs
// // child: Scaffold(
// // body: TabBarView(
// // children: [
// // Container(
// // child: Center(
// // child: Text('Daily'),
// // ),
// // ),
// // Container(
// // child: Center(
// // child: Text('Weekly'),
// // ),
// // ),
// // Container(
// // child: Center(
// // child: Text('Monthly'),
// // ),
// // ),
// // ],
// // ),
// // ),
// // );
// // }}
//
//
//
// //
// // callCompleted() async {
// //   var complete=await FirebaseFirestore.instance
// //       .collection('users').doc(user.uid)
// //       .collection('habits').where('completed.habitPeriod.$currentDate.toString()').get();
// //   // var complete = await FirebaseFirestore.instance
// //   //     .collection('users')
// //   //     .doc(user.uid)
// //   //     .collection('habits')
// //   //     .get();
// //   // print("Here's the type: ${complete.docs[0]["completed"].runtimeType}");
// //   // for(var comp in complete.docs){
// //   //   print("${comp.runtimeType}");
// //   // }
// //   // print("${complete.toList().then((value) => Text("${value.length}"))}");
// // }
//
// // @override
// // Widget build(BuildContext context) {
// //   String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
// //   //callCompleted();
// //   return Padding(
// //     padding: const EdgeInsets.only(left: 18, right: 18),
// //     child: Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(5),
// //         color: const Color(0xFFFFFFFF),
// //       ),
// //       child: Column(
// //         children: [
// //           // callCompleted(),
// //           ListTile(
// //             title: const Text(
// //               'Your Habits',
// //               style: TextStyle(
// //                 color: Color(0xff4c505b),
// //                 fontSize: 20,
// //               ),
// //             ),
// //             trailing: TextButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => const SeeAllGoal()));
// //               },
// //               child: const Text(
// //                 'See all',
// //                 style: TextStyle(color: Colors.deepOrangeAccent),
// //               ),
// //             ),
// //           ),
// //           StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
// //             stream: FirebaseFirestore.instance
// //                 .collection('users')
// //                 .doc(user.uid)
// //                 .collection('habits')
// //                 .snapshots(),
// //             builder: (context, streamSnapshot) {
// //               //print("This is the index: $index");
// //               if (streamSnapshot.connectionState == ConnectionState.waiting) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }
// //               if (streamSnapshot.hasError) {
// //                 print(streamSnapshot.error);
// //                 return Center(
// //                     child:
// //                         Text("There is an error: ${streamSnapshot.error}"));
// //               } else if (streamSnapshot.hasData) {
// //                 var habits = streamSnapshot.data!.docs;
// //                 // for (var habit in habits) {
// //                 //   // print("Completed here: ${habits[habits.indexOf(habit)]["completed"]["Apr-2023-4"]["dates"]}");
// //                 //   var completed = habits[habits.indexOf(habit)]["completed"];
// //                 //   for (var habitPeriod in completed.entries) {
// //                 //     var dates = habitPeriod.value["dates"];
// //                 //     for (var date in dates) {
// //                 //       print(
// //                 //           "Here is single date subString: ${date.substring(0, 10)}");
// //                 //     }
// //                 //   }
// //                 //   // print("Habit ${habits.indexOf(habit)}: ${habit["habitType"]}");
// //                 // }
// //
// //                 return habits.isEmpty
// //                     ? const Center(child: Text("No habits yet"))
// //                     : Column(
// //                         children: habits.map((habit) {
// //                         // int indexes = habits.indexOf(habit);
// //                         return Padding(
// //                           padding: const EdgeInsets.only(
// //                               top: 12, left: 15, right: 15),
// //                           child: Container(
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(5),
// //                               color: const Color(0xFFFBFBFB),
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.only(
// //                                   left: 8.0, right: 8.0),
// //                               child: Column(
// //                                 children: [
// //                                   ListTile(
// //                                     contentPadding:
// //                                         const EdgeInsets.symmetric(
// //                                             vertical: 0),
// //                                     title: Text(
// //                                       "${habit['habitName']}",
// //                                       style: const TextStyle(
// //                                           color: Color(0xFF2F2F2F),
// //                                           fontSize: 25),
// //                                     ),
// //                                     trailing: IconButton(
// //                                       onPressed: () {
// //                                         Navigator.push(
// //                                             context,
// //                                             MaterialPageRoute(
// //                                                 builder: (context) =>
// //                                                     HabitReport(
// //                                                         habitName: habit[
// //                                                             'habitName'])));
// //                                       },
// //                                       icon: const Icon(
// //                                           Icons.info_outline_rounded),
// //                                     ),
// //                                   ),
// //                                   const ListTile(
// //                                     contentPadding:
// //                                         EdgeInsets.symmetric(vertical: 0),
// //                                     title: LinearProgressIndicator(
// //                                         minHeight: 15,
// //                                         value: 0.5,
// //                                         backgroundColor: Colors.grey,
// //                                         valueColor:
// //                                             AlwaysStoppedAnimation<Color>(
// //                                                 Colors.deepOrangeAccent)),
// //                                   ),
// //                                   const ListTile(
// //                                     contentPadding:
// //                                         EdgeInsets.symmetric(vertical: 0),
// //                                     title: Text('5 from 7 days target',
// //                                         style: TextStyle(
// //                                             color: Color(0xFF2F2F2F),
// //                                             fontSize: 20)),
// //                                   ),
// //                                   ListTile(
// //                                       contentPadding:
// //                                           const EdgeInsets.symmetric(
// //                                               vertical: 0),
// //                                       title: const Text(
// //                                         'Everyday',
// //                                         style: TextStyle(
// //                                             color: Color(0xFFFF5C00),
// //                                             fontSize: 20),
// //                                       ),
// //                                       trailing: Checkbox(
// //                                         value: false,
// //                                         onChanged: (bool? newValue) async {
// //                                           final docRef = FirebaseFirestore
// //                                               .instance
// //                                               .collection("users")
// //                                               .doc(user.uid)
// //                                               .collection("habits")
// //                                               .doc(habit.id);
// //                                           final currentDate = DateTime.now();
// //                                           DateTime dateTime = DateTime.now();
// //                                           String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
// //                                           if (habit['habitType'] ==
// //                                               "Weekly") {
// //                                             DateTime now = DateTime.now();
// //                                             int currentWeekDayOfMonth =
// //                                                 now.weekday;
// //                                             habitPeriod =
// //                                                 '${DateFormat('MMM-yyyy').format(DateTime.now())}-$currentWeekDayOfMonth';
// //                                             try {
// //                                               await docRef.update({
// //                                                 "completed.$habitPeriod.dates":
// //                                                     FieldValue.arrayUnion([
// //                                                   formattedDate.toString()
// //                                                 ]),
// //                                                 "completed.$habitPeriod.count":
// //                                                     newValue == true
// //                                                         ? FieldValue
// //                                                             .increment(1)
// //                                                         : FieldValue
// //                                                             .increment(-1),
// //                                               });
// //                                               //print("Update successful");
// //                                             } catch (e) {
// //                                               print(
// //                                                   "Error updating document: $e");
// //                                             }
// //                                           } else if (habit['habitType'] ==
// //                                               "Monthly") {
// //                                             final yearMonth =
// //                                                 DateFormat('MMM-yyyy')
// //                                                     .format(currentDate);
// //                                             //print("yearMonth: $yearMonth");
// //                                             try {
// //                                               await docRef.update({
// //                                                 "completed.$yearMonth.dates":
// //                                                     FieldValue.arrayUnion([
// //                                                   formattedDate.toString()
// //                                                 ]),
// //                                                 "completed.$yearMonth.count":
// //                                                     newValue == true
// //                                                         ? FieldValue
// //                                                             .increment(1)
// //                                                         : FieldValue
// //                                                             .increment(-1),
// //                                               });
// //                                               //print("Update successful");
// //                                             } catch (e) {
// //                                               print(
// //                                                   "Error updating document: $e");
// //                                             }
// //                                           }
// //                                         },
// //                                       )),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                       }).toList());
// //               } else {
// //                 return const CircularProgressIndicator();
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
// //}
//
// import 'package:flutter/material.dart';
// import 'package:tracker_habit/screen/habit/dailyHabit.dart';
// import 'package:tracker_habit/screen/habit/monthlyHabit.dart';
// import 'package:tracker_habit/screen/habit/weeklyHabit.dart';
//
// import '../../homepage.dart';
// import '../Goal/completedGoals.dart';
// import '../Goal/inCompleteGoals.dart';
//
// class HabitScreen extends StatefulWidget {
//   const HabitScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HabitScreen> createState() => _HabitScreenState();
// }
//
// class _HabitScreenState extends State<HabitScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: NestedScrollView(
//         controller: _scrollController,
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverPersistentHeader(
//               delegate: _SliverAppBarDelegate(
//                 TabBar(
//                   tabs: [
//                     Tab(
//                         child: Text('Daily',
//                             style: TextStyle(fontSize: 18))),
//                     Tab(
//                         child: Text('Weekly',
//                             style: TextStyle(fontSize: 18))),
//                     Tab(
//                         child: Text('Monthly',
//                             style: TextStyle(fontSize: 18))),
//                   ],
//                 ),
//               ),
//               pinned: true,
//             ),
//           ];
//         },
//         body: TabBarView(
//           children: [
//             DailyHabit(),
//             WeeklyHabit(),
//             MonthlyHabit(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar _tabBar;
//
//   _SliverAppBarDelegate(this._tabBar);
//
//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: _tabBar,
//     );
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await tz.initializeTimeZones();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Habit Reminder',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Habit Reminder'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             child: Text('Set Reminder'),
//             onPressed: () {
//               _scheduleNotification();
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _scheduleNotification() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     var androidDetails = AndroidNotificationDetails(
//         'channelId', 'channelName', 'channelDescription',
//         priority: Priority.high,
//         importance: Importance.high,
//         ticker: 'ticker');
//     var iOSDetails = IOSNotificationDetails();
//     var notificationDetails =
//     NotificationDetails(android: androidDetails, iOS: iOSDetails);
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Complete Your Habit',
//         'Don\'t forget to complete your habit today!',
//         _nextInstanceOfTenAM(),
//         notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//   }
//
//   tz.TZDateTime _nextInstanceOfTenAM() {
//     tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local);
//     if (scheduledDate.hour >= 10) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return tz.TZDateTime(tz.local, scheduledDate.year, scheduledDate.month,
//         scheduledDate.day, 10);
//   }
// }


// ure, I'd be happy to help! Based on the code you provided, it looks like you're using the flutter_local_notifications package to show a notification. Here are a few things you can try to troubleshoot the issue:
//
// Check if the showNotification function is being called
// One thing you can try is to add a print statement at the beginning of the showNotification function to check if it's being called:
//
// csharp
// Copy code
// Future<void> showNotification() async {
//   print('showNotification called');
//   // Rest of the code
// }
// If you see the message "showNotification called" in the console, then the function is being called properly.
//
// Check if the notification channel is set up correctly
// Make sure that the notification channel is set up correctly by checking the AndroidNotificationChannel instance that you're using. You can add a print statement to see if the channel is being created successfully:
//
// arduino
// Copy code
// AndroidNotificationChannel channel = const AndroidNotificationChannel(
// 'high channel',
// 'Very important notification!!',
// description: 'the first notification',
// importance: Importance.max,
// );
// print('Channel created successfully: ${await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
// AndroidFlutterLocalNotificationsPlugin>()
//     ?.getNotificationChannel(channel.id)}');
// This will print out the details of the notification channel that you've created. Make sure that the channel ID that you're using in the AndroidNotificationDetails instance matches the ID of the notification channel.
//
// Check if the notification is being triggered
// You can add a print statement at the end of the showNotification function to check if the notification is being triggered:
//
// php
// Copy code
// await flutterLocalNotificationsPlugin.show(
// 0,
// 'Incomplete Habits',
// message,
// const NotificationDetails(
// android: AndroidNotificationDetails(
// 'incomplete habits channel id',
// 'Incomplete Habits',
// importance: Importance.max,
// priority: Priority.high,
// showWhen: false,
// ),
// ),
// );
// print('Notification shown');
// If you see the message "Notification shown" in the console, then the notification is being triggered properly.
//
// Check if the AndroidAlarmManager is set up correctly
// Make sure that the AndroidAlarmManager is set up correctly by checking the showNotification method is called properly using Android AlarmManager service.
//
// To verify that the AndroidAlarmManager is set up correctly, you can add a print statement at the beginning of the showNotification method to see if it's being called:
//
// csharp
// Copy code
// Future<void> showNotification() async {
// print('showNotification called');
// // Rest of the code
// }
// If you see the message "showNotification called" in the console periodically (every minute, in this case), then the AndroidAlarmManager is set up correctly.
//
// I hope this helps you troubleshoot the issue! If you have any more questions or if these steps don't resolve the issue, feel free to ask.