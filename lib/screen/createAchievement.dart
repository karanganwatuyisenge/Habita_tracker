import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_habit/screen/Goal/createNewGoal.dart';
import 'package:tracker_habit/screen/habit/createNewHabit.dart';
import '../homepage.dart';

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

  Future<void> _dialogBuilder(BuildContext context){
    if(_selectedGoalOrHabitType=='Goal'){
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return NewGoal();
          });
    }
    else if(_selectedGoalOrHabitType == 'Habit'){
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return NewHabit();
          });
    }
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Create New Habit or Habit', style: TextStyle(fontSize: 15)),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewGoal(),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFEDEDED),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Goal",
                      style: TextStyle(fontSize: 40, color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
                child:GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewHabit(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 200,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFEDEDED),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Habit',
                          style: TextStyle(fontSize: 40, color: Color(0xFF666666)),
                        ),
                      ],
                    ),
                  ),
                ),
    ),
            ]),
          );
  }




}

