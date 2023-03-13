import 'package:flutter/material.dart';
import 'package:tracker_habit/homepage.dart';

class YourHabit extends StatefulWidget{
  YourHabit({Key? key}) : super(key:key);

  @override
  State<YourHabit> createState() => _YourHabitState();
}

class _YourHabitState extends State<YourHabit>{
  bool showvalue = false;
  @override
  Widget build(BuildContext Context){
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:38.0),
              child: Row(

                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      icon: Icon(Icons.arrow_back),iconSize: 30,),
                  Text('Your Habit',style: TextStyle(fontSize:30),),


                ],
              ),
            ),
            SizedBox(
              height:20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.pink.shade100,),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('1 March',style:TextStyle(color:Colors.deepOrangeAccent,fontSize: 15,)),
                          ],
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),color: Colors.grey.shade200,),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('29 Feb',style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),color: Colors.grey.shade200,),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('28 Feb',style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),color: Colors.grey.shade200,),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('27 Feb',style: TextStyle(fontSize: 20,),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),color: Colors.grey.shade200,),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('26 Feb',style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height:40,
            ),
            Padding(
              padding: const EdgeInsets.only(left:18,right:18),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Today Habit',
                        style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
                      trailing: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => YourHabit())
                          );
                        },
                        child: Text(
                          'See all', style: TextStyle(color: Colors.deepOrangeAccent),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.lightGreen.shade100,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Meditating',style: TextStyle(color: Colors.green,fontSize: 20,),),
                              Row(
                                children: [
                                  Checkbox(
                                    value: showvalue,
                                    onChanged: (bool? value) {},),
                                  IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.more_vert)),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.lightGreen.shade100,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Read Philosophy',style: TextStyle(color: Colors.green,fontSize: 20,),),
                              Row(
                                children: [
                                  Checkbox(
                                    value: showvalue,
                                    onChanged: (bool? value) {},),
                                  IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.more_vert)),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white60,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Journaling',style: TextStyle(color: Colors.green,fontSize: 20,),),
                              Row(
                                children: [
                                  Checkbox(
                                    value: showvalue,
                                    onChanged: (bool? value) {},),
                                  IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.more_vert)),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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

