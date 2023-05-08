import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/screen/Goal/completedGoals.dart';
import 'package:tracker_habit/screen/Goal/inCompleteGoals.dart';
import 'package:tracker_habit/screen/habit/completedHabit.dart';
import 'package:tracker_habit/screen/habit/incompleteHabit.dart';

import '../../settings/setting.dart';

class SeeAllHabit extends StatefulWidget {
  const SeeAllHabit({Key? key}) : super(key: key);

  @override
  State<SeeAllHabit> createState() => _SeeAllHabitState();
}

class _SeeAllHabitState extends State<SeeAllHabit> {
  bool showvalue = false;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) =>DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Today Habit'),
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
            IncompleteHabit(),
            CompletedHabit(),

          ],

        ),
        bottomNavigationBar: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: const Icon(Icons.home, color: Colors.orangeAccent,),
                  ),
                  IconButton(
                    onPressed: () {
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
      ));

}