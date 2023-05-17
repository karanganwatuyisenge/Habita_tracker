import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/themeProvider.dart';
class CompletedGoals extends StatefulWidget {
  const CompletedGoals({Key? key}) : super(key: key);

  @override
  State<CompletedGoals> createState() => _CompletedGoalsState();
}

class _CompletedGoalsState extends State<CompletedGoals> {
  User user=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return Scaffold(
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('users')
                  .doc(user.uid).collection('goals').where(
                  "completed", isEqualTo: true).snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (streamSnapshot.hasError) {
                  print(streamSnapshot.error);
                  return Center(child: Text(
                      "ThereIsAnError: ${streamSnapshot.error}".tr()));
                }
                else if (streamSnapshot.hasData) {
                  var goals = streamSnapshot.data!.docs;

                  return goals.isEmpty
                      ? Center(child: Text("NoGoalsYet".tr()))
                      : ListView(
                    children: [
                  Column(

                  children: goals.map((goal) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 15, right: 15),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: themeProvider.isDarkMode?Colors.grey:Colors.lightGreen.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    Text('Goal Name:',style: TextStyle(color:themeProvider.isDarkMode?Colors.white: Color(0xFF2F2F2F),fontSize: 20),),
                                    Text(goal['goalName'],
                                      style: TextStyle(color:themeProvider.isDarkMode?Colors.white: Colors.green,fontSize: 20),
                                    ),
                                  ],
                                ),
                                subtitle:Row(
                                  children: [
                                    Text('End Date:',style: TextStyle(color:themeProvider.isDarkMode?Colors.white: Color(0xFF2F2F2F),fontSize: 20),),
                                    Text(goal['endDate'],
                                      style: TextStyle(color:themeProvider.isDarkMode?Colors.white: Colors.green,fontSize: 20),
                                    ),
                                  ],
                                ),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: goal["completed"],
                                        onChanged: (bool? newValue) {
                                          FirebaseFirestore.instance
                                              .collection("users").doc(user.uid)
                                              .collection("goals").doc(goal.id)
                                              .update(
                                              {"completed": newValue ?? false});
                                        }
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(100, 230, 30, 0),
                                          items: [
                                            PopupMenuItem(
                                              child: ListTile(
                                                leading: Icon(Icons.edit),
                                                title: Text('Update'),
                                                onTap: () {
                                                  TextEditingController _goalNameController = TextEditingController(text: goal['goalName']);
                                                  TextEditingController _endDateController = TextEditingController(text: goal['endDate']);
                                                  String? _selectedGoalType;
                                                  Navigator.pop(context); // Close the menu
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext dialogContext) => AlertDialog(
                                                      title: Text('Update Goal'),
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            controller: _goalNameController,
                                                            decoration: InputDecoration(
                                                              labelText: 'New Goal Name',
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                          ),
                                                          TextFormField(
                                                            controller: _endDateController,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              labelText: 'Select End Date',
                                                            ),
                                                            onTap: () async {
                                                              DateTime? pickedDate = await showDatePicker(
                                                                context: dialogContext,
                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(2022),
                                                                lastDate: DateTime(2025),
                                                              );
                                                              if (pickedDate != null) {
                                                                _endDateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
                                                                _selectedGoalType = _endDateController.text;
                                                              }
                                                            },
                                                            validator: (value) {
                                                              if (value?.isEmpty ?? true) {
                                                                return 'PleaseEnterYourGoal'.tr();
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            String newGoalName = _goalNameController.text.trim();
                                                            String newEndDate = _endDateController.text.trim(); // Get the updated end date value
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(user.uid)
                                                                .collection("goals")
                                                                .doc(goal.id)
                                                                .update({
                                                              "goalName": newGoalName,
                                                              "endDate": newEndDate, // Update the end date value in the document
                                                            });
                                                            Navigator.pop(dialogContext); // Close the dialog
                                                          },
                                                          child: Text('Save'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            PopupMenuItem(
                                              child: ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text('Delete'),
                                                onTap: () {
                                                  Navigator.pop(context); // Close the menu
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext dialogContext) => AlertDialog(
                                                      title: Text('Delete Goal'),
                                                      content: Text('Are you sure you want to delete this goal?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(user.uid)
                                                                .collection("goals")
                                                                .doc(goal.id)
                                                                .delete();
                                                            Navigator.pop(dialogContext); // Close the dialog
                                                          },
                                                          child: Text('Delete'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(dialogContext); // Close the dialog
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                          ],
                                        );
                                      },
                                      icon: Icon(Icons.more_vert),
                                    ),

                                  ],
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()
                )]);

                }
                else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          );
        });
  }
}
