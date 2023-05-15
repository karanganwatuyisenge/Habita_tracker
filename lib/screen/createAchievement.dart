import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/screen/Goal/createNewGoal.dart';
import 'package:tracker_habit/screen/habit/createNewHabit.dart';
import '../homepage.dart';
import '../provider/themeProvider.dart';

class NewAchievement extends StatefulWidget{
  NewAchievement({Key? key}) : super(key: key);

  @override
  State<NewAchievement> createState() => _NewAchievement();
}

class _NewAchievement extends State<NewAchievement>{
  final _formKey = GlobalKey<FormState>();
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String? _selectedGoalOrHabitType;
  List<String> _goalOrHabitTypes=['Goal','Habit'];

  Future<void> _showDialog(BuildContext context, Widget content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Set background color to transparent
          child: content,
        );
      },
    );
  }

  // Future<void> _dialogBuilder(BuildContext context){
  //   if(_selectedGoalOrHabitType=='Goal'){
  //     return showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return NewGoal();
  //         });
  //   }
  //   else if(_selectedGoalOrHabitType == 'Habit'){
  //     return showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return NewHabit();
  //         });
  //   }
  //   return Future.value();
  // }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return AlertDialog(
            backgroundColor: themeProvider.isDarkMode ? Colors.black :Color(0xFFFBFBFB),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CreateNewHabitorGoal'.tr(),
                    style: TextStyle(fontSize: 16, color: themeProvider.isDarkMode? Colors.white:Colors.black)),
                IconButton(
                  icon: Icon(Icons.cancel, color: themeProvider.isDarkMode? Colors.white:Colors.black,),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showDialog(context,NewGoal());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NewGoal(),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .height * 0.3,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Goals'.tr(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDialog(context,NewHabit());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NewHabit(),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .height * 0.3,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'habits'.tr(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          );
        });
  }

}

