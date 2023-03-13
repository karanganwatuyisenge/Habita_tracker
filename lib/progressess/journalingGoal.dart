import 'package:flutter/material.dart';
import 'package:tracker_habit/progressess/progressess.dart';

class Journaling extends StatefulWidget{
  Journaling({Key? key}) : super(key:key);

  @override
  State<Journaling> createState() => _JournalingState();
}

class _JournalingState extends State<Journaling>{
  DateTime _selectedDate=DateTime.now();
  List<String> _weekdays=['Mo','Tue','We','Th','Fr','Sa','Su'];

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
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top:20,left:20),
              child: Text('June 4 2022',style:TextStyle(fontSize: 15,fontWeight:FontWeight.bold,),),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Progress())
                  );
                },
                icon: Icon(Icons.arrow_back,color: Colors.black, ),
              ),
              title: Text('Goal:Journaling everyday',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200,
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Journaling Everyday',style: TextStyle(fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightGreen.shade100,
                            ),
                            child: TextButton(
                                onPressed: (){},
                                child: Text('Achieved',style: TextStyle(color: Colors.green),),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Habit name:',style: TextStyle(fontWeight: FontWeight.bold),),
                        TextButton(
                          onPressed: (){},
                          child: Text('Journaling',style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Days Complete:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                        TextButton(
                          onPressed: (){},
                          child: Text('7 from 7 days',style: TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Days failed:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                        TextButton(
                          onPressed: (){},
                          child: Text('0 Day',style: TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Habit type:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                        TextButton(
                          onPressed: (){},
                          child: Text('Everyday',style: TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Created on:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                        TextButton(
                          onPressed: (){},
                          child: Text('June 4 2022',style: TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
      ],
      ),
      ),
    );
  }
}

