import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_habit/homepage.dart';

class HabitReport extends StatefulWidget{
  final String habitName;

  HabitReport({required this.habitName});

  @override
  State<HabitReport> createState() => _HabitReportState();
}

class _HabitReportState extends State<HabitReport>{
  DateTime? currentDate;
  String? formattedDate;
  DateTime _selectedDate=DateTime.now();
  List<String> _weekdays=['Mo','Tue','We','Th','Fr','Sa','Su'];
  User user=FirebaseAuth.instance.currentUser!;

  List<int> _daysInMonth=[];

  void _selectDate(DateTime date){
    setState(() {
      _selectedDate=date;
    });
  }

  void _previousMonth(){
    setState(() {
      _selectedDate=DateTime(_selectedDate.year,_selectedDate.month -1);
    });
  }

  void _nextMonth(){
    setState(() {
      _selectedDate=DateTime(_selectedDate.year,_selectedDate.month +1);
    });
  }
  @override
  Widget build(BuildContext Context){
    currentDate = DateTime.now();
    formattedDate = DateFormat('E, d MMMM yyyy').format(currentDate!);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('$formattedDate',
        style: TextStyle(color: Color(0xff4c505b),),
    ),
    ),

      body: ListView(
        children: [
          ListTile(
            title: Text('Habit:Habit Name:frequency',style: TextStyle(fontSize: 21,fontWeight:FontWeight.w700,color: Color(0xFF2F2F2F)),),
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())
                );
              },
              icon: Icon(Icons.arrow_back),color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Start Date',style:TextStyle(fontWeight: FontWeight.bold)),
                          Text('June 4 2020', style:TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('End Date',style:TextStyle(fontWeight: FontWeight.bold)),
                          Text('July 3 2022' ,style:TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2050),
                      onDateChanged: (date){
                        setState(() {
                          _selectedDate =date;
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                    stream: FirebaseFirestore.instance.collection('users')
                        .doc(user.uid).collection('habits')
                        .snapshots(),
                    builder: (context, streamSnapshot){
                      if(streamSnapshot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      }if(streamSnapshot.hasError){
                        print(streamSnapshot.error);
                        return Center(child: Text("There is an error: ${streamSnapshot.error}"));
                      }
                      else if(streamSnapshot.hasData){
                        var habits=streamSnapshot.data!.docs;

                        return habits.isEmpty?const Center(child: Text("No habits yet")): Column(

                            children:habits.map((habit) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                                      title: Text(habit['habitName'],
                                        style: TextStyle(fontWeight: FontWeight.w700,fontSize:16,color: Color(0xFF000000)),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Target:',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))), trailing: Text('7 from 7 days',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                    ),
                                    ListTile(
                                      title: Text('Days Complete:',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                      trailing: Text('7 from 7 days',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                    ),
                                    ListTile(
                                      title: Text('Days Failed:',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                      trailing: Text('0 days',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                    ),
                                    ListTile(
                                      title: Text('Habit Type:',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                      trailing: Text('Everyday',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                    ),
                                    ListTile(
                                      title: Text('Created On:',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                      trailing: Text('24,june,2022',style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,color: Color(0xFF2F2F2F))),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                        );
                      }
                      else{
                        return const CircularProgressIndicator();
                      }

                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ) ,
    );

  }
}

