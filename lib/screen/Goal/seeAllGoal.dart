import 'package:cloud_firestore/cloud_firestore.dart';
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
          title: Text('Your Goals'),
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
                  child:Text('Incompleted',
              style:TextStyle(fontSize: 18))),
              Tab(
                  child:Text('Completed',
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

  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Your Goals',
  //         style: TextStyle(color: Color(0xFF2F2F2F),fontSize: 30
  //         ),),
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => HomePage())
  //           );
  //         },
  //         icon: Icon(Icons.arrow_back,color: Color(0xFF2F2F2F),size: 40,),
  //
  //       ),
  //       elevation: 0,
  //       backgroundColor: Colors.white,
  //     ),
  //
  //     body: Center(
  //       child: Column(
  //           children: [
  //             SizedBox(
  //               height: 100,
  //             ),
  //             Container(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => CompletedGoals(),
  //                     ),
  //                   );
  //                 },
  //                 child: Container(
  //                   height: 100,
  //                   width: 350,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5),
  //                     color: Colors.deepOrange,
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Completed Goals",
  //                         style: TextStyle(fontSize: 40, color: Colors.white),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 30,
  //             ),
  //             Container(
  //               child:GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => IncompleteGoals(),
  //                     ),
  //                   );
  //                 },
  //                 child: Container(
  //                   height: 100,
  //                   width: 350,
  //
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5),
  //                     color: Colors.deepOrange,
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         'Incomplete Goals',
  //                         style: TextStyle(fontSize: 40, color: Colors.white),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ]),
  //     ),
  //   );
  // }
