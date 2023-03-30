import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/Goal/createNewGoal.dart';
import 'package:tracker_habit/screen/habit/createNewHabit.dart';
class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
       body: Container(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: GridView(
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               crossAxisSpacing: 10,
             ),
             children: [
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => NewGoal(),
                     ),
                   );
                 },
                 child: Container(
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
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => NewHabit(),
                     ),
                   );
                 },
                 child: Container(
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
             ],
           ),

       ),

    )
    );
  }
}
