import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyHabit extends StatefulWidget {
  const WeeklyHabit({Key? key}) : super(key: key);

  @override
  State<WeeklyHabit> createState() => _WeeklyHabitState();
}

class _WeeklyHabitState extends State<WeeklyHabit> {
  User user = FirebaseAuth.instance.currentUser!;
  String? habitPeriod;
  @override
  Widget build(BuildContext context) {
    //String formattedDate = DateFormat('yyyy-MM').format(DateTime.now());
    String formattedNow=DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('habits')
            .where('habitType', isEqualTo: 'Weekly')
        //.where('completed.$formattedDate.dates', arrayContains: formattedNow)
            .snapshots(),
        builder: (context, streamSnapshot) {
          //print("This is the index: $index");
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (streamSnapshot.hasError) {
            print(streamSnapshot.error);
            return Center(
                child:
                Text("ThereIsAnError: ${streamSnapshot.error}".tr()));
          }
          else if (streamSnapshot.hasData) {
            var habits = streamSnapshot.data!.docs;

            return habits.isEmpty
                ?Center(child: Text("NoHabitsYet".tr()))
                : SingleChildScrollView(
              child: Column(
                  children: habits.map((habit) {
                    // int indexes = habits.indexOf(habit);
                    int frequency=habit['habitFrequency'];
                    int count=habit['completed.$formattedNow.count'];
                    int remaining=frequency-count;
                    double percentage = frequency == 0 || count == 0 ? 0.0 : count / frequency;
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 15, right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFFBFBFB),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    vertical: 0),
                                title: Text(
                                  "${habit['habitName']}",
                                  style: const TextStyle(
                                      color: Color(0xFF2F2F2F),
                                      fontSize: 25),
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 0),
                                title:LinearProgressIndicator(
                                    minHeight: 15,
                                    value: percentage,
                                    backgroundColor: Colors.grey,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        Colors.deepOrangeAccent)),
                              ),
                              ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 0),
                                title: Text('$count From $frequency DaysTarget'.tr(),
                                  style: TextStyle(
                                    color: Color(0xFF2F2F2F),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 0),
                                title: Text('Remaining $remaining days',
                                    style: TextStyle(
                                        color: Color(0xFF2F2F2F),
                                        fontSize: 20)),
                              ),
                              ListTile(
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 0),
                                  title: Text(
                                    'Everyday'.tr(),
                                    style: TextStyle(
                                        color: Color(0xFFFF5C00),
                                        fontSize: 20),
                                  ),
                                  trailing: Checkbox(
                                    value: false,
                                    onChanged: (bool? newValue) async {
                                      final docRef = FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(user.uid)
                                          .collection("habits")
                                          .doc(habit.id);
                                      final currentDate = DateTime.now();
                                      DateTime dateTime = DateTime.now();
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                                      if (habit['habitType'] ==
                                          "Weekly") {
                                        DateTime now = DateTime.now();
                                        int currentWeekDayOfMonth =
                                            now.weekday;
                                        habitPeriod =
                                        '${DateFormat('yyyy-MM').format(DateTime.now())}-$currentWeekDayOfMonth';
                                        try {
                                          await docRef.update({
                                            "completed.$habitPeriod.dates":
                                            FieldValue.arrayUnion([
                                              formattedDate.toString()
                                            ]),
                                            "completed.$habitPeriod.count":
                                            newValue == true
                                                ? FieldValue
                                                .increment(1)
                                                : FieldValue
                                                .increment(-1),
                                          });
                                          //print("Update successful");
                                        } catch (e) {
                                          print(
                                              "Error updating document: $e");
                                        }
                                      }
                                      else if (habit['habitType'] ==
                                          "Monthly") {
                                        final yearMonth =
                                        DateFormat('yyyy-MM').format(DateTime.now());
                                        //print("yearMonth: $yearMonth");
                                        try {
                                          await docRef.update({
                                            "completed.$yearMonth.dates":
                                            FieldValue.arrayUnion([
                                              formattedDate.toString()
                                            ]),
                                            "completed.$yearMonth.count":
                                            newValue == true
                                                ? FieldValue
                                                .increment(1)
                                                : FieldValue
                                                .increment(-1),
                                          });
                                          //print("Update successful");
                                        } catch (e) {
                                          print(
                                              "Error updating document: $e");
                                        }
                                      }
                                      else if (habit['habitType'] ==
                                          "Daily") {
                                        final yearDaily =
                                        DateFormat('yyyy-MM-dd')
                                            .format(currentDate);
                                        //print("yearMonth: $yearMonth");
                                        try {
                                          await docRef.update({
                                            "completed.$yearDaily.dates":
                                            FieldValue.arrayUnion([
                                              formattedDate.toString()
                                            ]),
                                            "completed.$yearDaily.count":
                                            newValue == true
                                                ? FieldValue
                                                .increment(1)
                                                : FieldValue
                                                .increment(-1),
                                          });
                                          //print("Update successful");
                                        } catch (e) {
                                          print(
                                              "Error updating document: $e");
                                        }
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()
              ),
            );

          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
  }

//
//   Future<List<DocumentSnapshot<Object?>>> showWeeklyHabit() async {
//     DateTime now = DateTime.now();
//     int currentWeekDayOfMonth = now.weekday;
//     String formattedDateWeekly = '${DateFormat('yyyy-MM').format(
//         DateTime.now())}-$currentWeekDayOfMonth';
//     String formattedDaily = DateFormat('yyyy-MM-dd').format(DateTime.now());
//
//     QuerySnapshot weeklySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .collection('habits')
//         .where('habitType', isEqualTo: 'Weekly')
//         .get();
//
//     List<DocumentSnapshot> habits = [];
//
//     weeklySnapshot.docs.forEach((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       if (data.containsKey('completed')) {
//         Map<String, dynamic> completed = data['completed'];
//         if (completed.containsKey(formattedDateWeekly)) {
//           List<dynamic> dates = completed[formattedDateWeekly]['dates'];
//           if (dates != null &&
//               !dates.contains(now.toString().substring(0, 10))) {
//             habits.add(doc);
//           }
//         } else {
//           habits.add(doc);
//         }
//       }
//     });
//     return habits;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now();
//     int currentWeekDayOfMonth = now.weekday;
//     String formattedDate = '${DateFormat('yyyy-MM').format(
//         DateTime.now())}-$currentWeekDayOfMonth';
//     return FutureBuilder<List<DocumentSnapshot<Object?>>>(
//         future: showWeeklyHabit(),
//     builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//     return Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasData) {
//     List<DocumentSnapshot<Object?>> habits = snapshot.data!;
//     if (habits.isEmpty) {
//     print('No habits found.');
//     return Center(child: Text('NoHabitsYet').tr());
//     }
//     return ListView.builder(
//     itemCount: habits.length,
//     itemBuilder: (context, index) {
//     DocumentSnapshot<Object?> habitSnapshot = habits[index];
//     Map<String, dynamic> data = habitSnapshot.data() as Map<String, dynamic>;
//     String habitId = habitSnapshot.id;
//     int frequency = data.containsKey('habitFrequency') ? data['habitFrequency'] as int : 0;
//     int count = data.containsKey('completed.$formattedDate.count') ? data['completed.$formattedDate.count'] as int : 0;
//     int remaining=frequency != null && count != null ? frequency-count : 0;
//     double percentage = frequency == 0 || count == 0 ? 0.0 : count / frequency;
//     return Column(
//     children: [
//     ListTile(
//     title: Text(data['habitName']),
//     ),
//     ListTile(
//     contentPadding: EdgeInsets.symmetric(vertical: 0),
//     title: LinearProgressIndicator(
//     minHeight: 15,
//     value: percentage,
//     backgroundColor: Colors.grey,
//     valueColor: AlwaysStoppedAnimation<Color>(
//     Colors.deepOrangeAccent,
//     ),
//     ),
//     ),
//     ListTile(
//     contentPadding:
//     EdgeInsets.symmetric(vertical: 0),
//     title: Text('$count From $frequency DaysTarget'.tr(),
//     style: TextStyle(
//     color: Color(0xFF2F2F2F),
//     fontSize: 20,
//     ),
//     ),
//     ),
//     ListTile(
//     contentPadding:
//     EdgeInsets.symmetric(vertical: 0),
//     title: Text('Remaining $remaining days',
//     style: TextStyle(
//     color: Color(0xFF2F2F2F),
//     fontSize: 20)),
//     ),
//     ListTile(
//     contentPadding:
//     const EdgeInsets.symmetric(
//     vertical: 0),
//     title: Text(
//     'Everyday'.tr(),
//     style: TextStyle(
//     color: Color(0xFFFF5C00),
//     fontSize: 20),
//     ),
//     trailing: Checkbox(
//     value: false,
//     onChanged: (bool? newValue) async {
//     final docRef = FirebaseFirestore
//         .instance
//         .collection("users")
//         .doc(user.uid)
//         .collection("habits")
//         .doc(habitId);
//     final currentDate = DateTime.now();
//     DateTime dateTime = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
//     if (data['habitType'] ==
//     "Weekly") {
//     DateTime now = DateTime.now();
//     int currentWeekDayOfMonth =
//     now.weekday;
//     habitPeriod =
//     '${DateFormat('yyyy-MM').format(DateTime.now())}-$currentWeekDayOfMonth';
//     try {
//     await docRef.update({
//  "completed.$habitPeriod.dates":
//                                 FieldValue.arrayUnion([
//                                   formattedDate.toString()
//                                 ]),
//                                 "completed.$habitPeriod.count":
//                                 newValue == true
//                                     ? FieldValue
//                                     .increment(1)
//                                     : FieldValue
//                                     .increment(-1),
//                               });
//                               //print("Update successful");
//                             } catch (e) {
//                               print(
//                                   "Error updating document: $e");
//                             }
//                           }
//                         },
//                       )),
//                 ],
//               );
//             },
//           );
//
//         } else if (snapshot.hasError) {
//           print('Error: ${snapshot.error}');
//           return Center(child: Text('${snapshot.error}'));
//         } else {
//           print('No data found.');
//           return Center(child: Text('No data found.'));
//         }
//       },
//     );
//   }
// }
