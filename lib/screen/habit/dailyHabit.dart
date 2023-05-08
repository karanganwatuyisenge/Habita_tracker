import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/themeProvider.dart';
class DailyHabit extends StatefulWidget {
  const DailyHabit({Key? key}) : super(key: key);

  @override
  State<DailyHabit> createState() => _DailyHabitState();
}

class _DailyHabitState extends State<DailyHabit> {
  User user=FirebaseAuth.instance.currentUser!;
  String? habitPeriod;
  String dailyformat=DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          String formattedDate = DateFormat('yyyy-MM-dd').format(
              DateTime.now());
          return Scaffold(
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('habits')
                  .where('habitType', isEqualTo: 'Monthly')
                  .snapshots(),
              //.where('completed.$formattedDate.dates', isEqualTo: null)
              //.snapshots(),
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
                } else if (streamSnapshot.hasData) {
                  var habits = streamSnapshot.data!.docs;

                  return habits.isEmpty
                      ? Center(child: Text("NoHabitsYet".tr()))
                      : SingleChildScrollView(
                    child: Column(
                        children: habits.map((habit) {
                          // int indexes = habits.indexOf(habit);
                          int frequency = habit['habitFrequency'];
                          int count = habit['completed.$formattedDate.count'];
                          int remaining = frequency - count;
                          double percentage = frequency == 0 || count == 0
                              ? 0.0
                              : count / frequency;
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 15, right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //backgroundColor:themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF) ,
                                color: themeProvider.isDarkMode ? Colors.black : Color(0xFFFBFBFB)
                                //color: const Color(0xFFFBFBFB),
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
                                        style: TextStyle(
                                            color: themeProvider.isDarkMode ? Colors.black : Color(0xFF2F2F2F),
                                            //color: Color(0xFF2F2F2F),
                                            fontSize: 25),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                      title: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: percentage,
                                          backgroundColor: themeProvider.isDarkMode? Colors.black:Colors.grey,
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              themeProvider.isDarkMode ? Colors.black :Colors.deepOrangeAccent)),
                                    ),
                                    ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                      title: Text(
                                        '$count From $frequency DaysTarget'
                                            .tr(),
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.black :Color(0xFF2F2F2F),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                      title: Text('Remaining $remaining days',
                                          style: TextStyle(
                                              color: themeProvider.isDarkMode ? Colors.black :Color(0xFF2F2F2F),
                                              fontSize: 20)),
                                    ),
                                    ListTile(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 0),
                                        title: Text(
                                          'Everyday'.tr(),
                                          style: TextStyle(
                                              color: themeProvider.isDarkMode ? Colors.black:Color(0xFFFF5C00),
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
                                            String formattedDate = DateFormat(
                                                'yyyy-MM-dd').format(dateTime);
                                            if (habit['habitType'] ==
                                                "Weekly") {
                                              DateTime now = DateTime.now();
                                              int currentWeekDayOfMonth =
                                                  now.weekday;
                                              habitPeriod =
                                              '${DateFormat('yyyy-MM').format(
                                                  DateTime
                                                      .now())}-$currentWeekDayOfMonth';
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
                                              DateFormat('yyyy-MM').format(
                                                  DateTime.now());
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
        });
  }
}
