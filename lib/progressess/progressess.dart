import 'package:flutter/material.dart';
import 'package:tracker_habit/progressess/seeAllGoals.dart';
import '../homepage.dart';
import '../settings/setting.dart';
import 'journalingGoal.dart';

class Progress extends StatefulWidget{
  Progress({Key? key}) : super(key:key);

  @override
  State<Progress> createState() => _MyProgressState();
}

class _MyProgressState extends State<Progress>{
  List<String> items=<String>[
    'January','February','March','April','May',
  ];
  String dropdownValue='January';
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
              Padding(
                  padding: EdgeInsets.only(top:20,left:20),
                child: Text('Progress',style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold,),),
              ),
              ListTile(
                title: Text('Progress Report',
                  style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
                trailing: DropdownButton<String>(
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
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Your Goals',
                          style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
                        trailing: TextButton(
                          onPressed: () {},
                          child: TextButton(
                            onPressed:(){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SeeAllGoals()));
                            },
                            child:Text('See all', style: TextStyle(color: Colors.deepOrangeAccent)),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width:100,
                            child: CircularProgressIndicator(
                              value: 0.5,
                              strokeWidth: 15,
                              backgroundColor: Color(0xFFF0F0F0),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepOrangeAccent),
                            ),
                          ),
                          Text('60%',style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 20,fontWeight: FontWeight.w500,

                          ),),

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.check),
                            title: Text('11 habits goal has achieved',style: TextStyle(
                              color: Colors.deepOrangeAccent,),),
                          ),
                          ListTile(
                            leading: Icon(Icons.cancel),
                            title: Text('6 habits goal hasn\'t achieved',style: TextStyle(
                              color: Colors.grey,),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 18.0,),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SeeAllGoals()));
                              },
                              child: Text('See All',style: TextStyle(color: Colors.deepOrangeAccent),)),
                        ],
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

          bottomNavigationBar:Container(
              child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:[
                    IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      icon: Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.show_chart,color: Colors.orangeAccent,),
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Setting()));
                      },
                      icon: Icon(Icons.settings),
                    ),

                  ]
              )
          ),
    ),
    );
  }
}

