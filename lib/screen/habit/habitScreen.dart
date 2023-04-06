import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/Goal/seeAllGoal.dart';
import 'package:tracker_habit/screen/habit/habitReport.dart';
import 'package:intl/intl.dart';

class HabitScreen extends StatefulWidget {
  HabitScreen({Key? key}) : super(key: key);

  @override
  State<HabitScreen> createState() => _HabitScreen();
}

class _HabitScreen extends State<HabitScreen> {
  bool showvalue = false;
  User user = FirebaseAuth.instance.currentUser!;
  String? habitPeriod;
  DateTime currentDate = DateTime.now();
  var todays = DateTime.now().toString().substring(0, 10);

  callCompleted() async {
    var complete = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('habits')
        .get();
    print("Here's the type: ${complete.docs[0]["completed"].runtimeType}");
    for(var comp in complete.docs){
      print("${comp.runtimeType}");
    }
    // print("${complete.toList().then((value) => Text("${value.length}"))}");
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    callCompleted();
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFFFFFFF),
        ),
        child: Column(
          children: [
            // callCompleted(),
            ListTile(
              title: const Text(
                'Your Habits',
                style: TextStyle(
                  color: Color(0xff4c505b),
                  fontSize: 20,
                ),
              ),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SeeAllGoal()));
                },
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('habits')
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
                          Text("There is an error: ${streamSnapshot.error}"));
                } else if (streamSnapshot.hasData) {
                  var habits = streamSnapshot.data!.docs;
                  // for (var habit in habits) {
                  //   // print("Completed here: ${habits[habits.indexOf(habit)]["completed"]["Apr-2023-4"]["dates"]}");
                  //   var completed = habits[habits.indexOf(habit)]["completed"];
                  //   for (var habitPeriod in completed.entries) {
                  //     var dates = habitPeriod.value["dates"];
                  //     for (var date in dates) {
                  //       print(
                  //           "Here is single date subString: ${date.substring(0, 10)}");
                  //     }
                  //   }
                  //   // print("Habit ${habits.indexOf(habit)}: ${habit["habitType"]}");
                  // }

                  return habits.isEmpty
                      ? const Center(child: Text("No habits yet"))
                      : Column(
                          children: habits.map((habit) {
                          // int indexes = habits.indexOf(habit);
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
                                      trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HabitReport(
                                                          habitName: habit[
                                                              'habitName'])));
                                        },
                                        icon: const Icon(
                                            Icons.info_outline_rounded),
                                      ),
                                    ),
                                    const ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      title: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: 0.5,
                                          backgroundColor: Colors.grey,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.deepOrangeAccent)),
                                    ),
                                    const ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      title: Text('5 from 7 days target',
                                          style: TextStyle(
                                              color: Color(0xFF2F2F2F),
                                              fontSize: 20)),
                                    ),
                                    ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0),
                                        title: const Text(
                                          'Everyday',
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
                                            if (habit['habitType'] ==
                                                "Weekly") {
                                              DateTime now = DateTime.now();
                                              int currentWeekDayOfMonth =
                                                  now.weekday;
                                              habitPeriod =
                                                  '${DateFormat('MMM-yyyy').format(DateTime.now())}-$currentWeekDayOfMonth';
                                              try {
                                                await docRef.update({
                                                  "completed.$habitPeriod.dates":
                                                      FieldValue.arrayUnion([
                                                    currentDate.toString()
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
                                            } else if (habit['habitType'] ==
                                                "Monthly") {
                                              final yearMonth =
                                                  DateFormat('MMM-yyyy')
                                                      .format(currentDate);
                                              //print("yearMonth: $yearMonth");
                                              try {
                                                await docRef.update({
                                                  "completed.$yearMonth.dates":
                                                      FieldValue.arrayUnion([
                                                    currentDate.toString()
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
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
