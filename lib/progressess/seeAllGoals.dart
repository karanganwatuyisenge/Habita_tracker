import 'package:flutter/material.dart';
import 'package:tracker_habit/progressess/progressess.dart';

import 'journalingGoal.dart';



class SeeAllGoals extends StatefulWidget{
  SeeAllGoals({Key? key}) : super(key:key);

  @override
  State<SeeAllGoals> createState() => _SeeAllGoalsState();
}

class _SeeAllGoalsState extends State<SeeAllGoals>{
  List<String> items=<String>[
    'All','Item1','Item2','Item3','Item4',
  ];
  String dropdownValue='All';
  @override
  Widget build(BuildContext Context){
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        body:ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () { Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Progress()));
                    },
                    icon: Icon(Icons.arrow_back)),
                Text('Your Goals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                DropdownButton<String>(
                  onChanged: (String? newValue){
                    setState((){
                      dropdownValue = newValue!;
                    });
                    dropdownValue = newValue!;
                  },
                  value: dropdownValue,
                  items: items.map<DropdownMenuItem<String>>(

                          (String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }
                  ).toList(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,top:18.0,right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:18.0,left:18.0,right: 18.0,),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFBFBFB)
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                              ),
                              Text('100%',style: TextStyle(
                                color: Colors.green,
                              ),),
                            ],
                          ),
                          title: Text('Journaling everyday',style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Journaling()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.lightGreen.shade100,
                                  ),
                                  child: Text('Achieved',style: TextStyle(color: Colors.green),))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,right: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFBFBFB)
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                              ),
                              Text('100%',style: TextStyle(
                                color: Colors.green,
                              ),),
                            ],
                          ),
                          title: Text('Cooking Practice',style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Journaling()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.lightGreen.shade100,
                                  ),
                                  child: Text('Achieved',style: TextStyle(color: Colors.green),))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,right: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFBFBFB)
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey),
                              ),
                              Text('70%',style: TextStyle(
                                color: Colors.grey,
                              ),),
                            ],
                          ),
                          title: Text('Vitamin',style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Journaling()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    //color: Colors.lightGreen.shade100,
                                  ),
                                  child: Text('Unachieved',style: TextStyle(color: Colors.grey),))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,right: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFBFBFB)
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                              ),
                              Text('100%',style: TextStyle(
                                color: Colors.green,
                              ),),
                            ],
                          ),
                          title: Text('Meditate',style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Journaling()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.lightGreen.shade100,
                                  ),
                                  child: Text('Achieved',style: TextStyle(color: Colors.green),))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,right: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFBFBFB)
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey),
                              ),
                              Text('70%',style: TextStyle(
                                color: Colors.grey,
                              ),),
                            ],
                          ),
                          title: Text('Learn Arabic',style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Journaling()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    //color: Colors.lightGreen.shade100,
                                  ),
                                  child: Text('Unachieved',style: TextStyle(color: Colors.grey),))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

