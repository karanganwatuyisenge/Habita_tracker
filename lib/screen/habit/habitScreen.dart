import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/habit/dailyHabit.dart';
import 'package:tracker_habit/screen/habit/monthlyHabit.dart';
import 'package:tracker_habit/screen/habit/weeklyHabit.dart';

import '../../homepage.dart';
import '../Goal/completedGoals.dart';
import '../Goal/inCompleteGoals.dart';

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
                  child:Text('Daily',
                      style:TextStyle(fontSize: 18))),
              Tab(
                  child:Text('Weekly',
                    style: TextStyle(fontSize: 18),
                  )
              ),
              Tab(
                  child:Text('Monthly',
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
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       backgroundColor: Colors.grey,
    //       body: Padding(
    //           padding: EdgeInsets.all(8.0),
    //       child: Column(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(5),
    //               color: Colors.red
    //             ),
    //             child: TabBar(
    //               tabs: [
    //                 Tab(
    //                   child:Text('Daily')
    //                 ),
    //                 Tab(
    //                   child:Text('Weekly')
    //                 )
    //               ],
    //             )
    //           ),
    //           Expanded(
    //               child: SizedBox(
    //                 child: TabBarView(
    //                     children: [
    //                       DailyHabit(),
    //                     ]),
    //               )),
    //         ],
    //       ),
    //       )
    //     )
    // );
  }



