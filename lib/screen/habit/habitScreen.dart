import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/habit/dailyHabit.dart';
import 'package:tracker_habit/screen/habit/monthlyHabit.dart';
import 'package:tracker_habit/screen/habit/weeklyHabit.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({Key? key}) : super(key: key);

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {

  @override
  Widget build(BuildContext context) =>DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                  child:Text('Daily'.tr(),
                      style:TextStyle(fontSize: 18))),
              Tab(
                  child:Text('Weekly'.tr(),
                    style: TextStyle(fontSize: 18),
                  )
              ),
              Tab(
                  child:Text('Monthly'.tr(),
                    style: TextStyle(fontSize: 18),
                  )
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DailyHabit(),
            WeeklyHabit(),
            MonthlyHabit(),

          ],

        ),
      ));

  }



