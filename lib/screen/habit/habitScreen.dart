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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: TabBar(
              isScrollable: false,
              indicatorColor: Theme.of(context).primaryColor,
              //unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                    child:Text('Daily'.tr(),
                        style:TextStyle(fontSize: 18,color: Colors.white))),
                Tab(
                    child:Text('Weekly'.tr(),
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    )
                ),
                Tab(
                    child:Text('Monthly'.tr(),
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    )
                ),
              ],
            ),
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



