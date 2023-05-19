import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/screen/Goal/completedGoals.dart';
import 'package:tracker_habit/screen/Goal/inCompleteGoals.dart';

class SeeAllGoal extends StatefulWidget {
  const SeeAllGoal({Key? key}) : super(key: key);

  @override
  State<SeeAllGoal> createState() => _SeeAllGoalState();
}

class _SeeAllGoalState extends State<SeeAllGoal> {
  bool showvalue = false;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) =>DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('YourGoal'.tr()),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage())
              );
          },
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                  child:Text('InCompleted'.tr(),
              style:TextStyle(fontSize: 18))),
              Tab(
                  child:Text('Completed'.tr(),
                  style: TextStyle(fontSize: 18),
                  )
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IncompleteGoals(),
            CompletedGoals(),
          ],

        ),
      ));

}

