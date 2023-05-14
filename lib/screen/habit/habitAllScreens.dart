import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/habit/seeAllHabit.dart';

import '../../homepage.dart';
import '../../provider/themeProvider.dart';
import '../Goal/completedGoals.dart';
import '../Goal/inCompleteGoals.dart';

class HabitAllScreens extends StatefulWidget {
  const HabitAllScreens({Key? key}) : super(key: key);

  @override
  State<HabitAllScreens> createState() => _HabitAllScreensState();
}

class _HabitAllScreensState extends State<HabitAllScreens> {
  bool showvalue = false;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) =>
      DefaultTabController(
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
                      child: Text('InCompleted'.tr(),
                          style: TextStyle(fontSize: 18))),
                  Tab(
                      child: Text('Completed'.tr(),
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
