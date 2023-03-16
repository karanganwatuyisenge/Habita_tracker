import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/models/createNewHabit.dart';
import 'progressess/progressess.dart';
import 'settings/setting.dart';
import 'progressess/yourHabit.dart';


class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _goalNameController=TextEditingController();
  TextEditingController _habitNameController=TextEditingController();
  List<String> items=<String>[
    'January','February','March','April','May',
  ];
  String _selectedPeriod='January';
  List<String> type=<String>[
    'Everyday','1 day per week','2 days per week','3 days per week','4 days per week','5 days per week'
  ];
  String _selectedHabit='Everyday';
  bool showvalue = false;

  Future<void> SaveHabit(String goalName,String habitName,String period,String habitType) async{
    try{
      await FirebaseFirestore.instance.collection('newhabits').add({
        'goalName':goalName,
        'habitName':habitName,
        'period':period,
        'habitType':habitType,
      });
      print('Data Saved Successfully');
    }
    catch(e){
      print('Error Saving data: $e');
    }
  }

  void _saveForm(){
    String _goalName = _goalNameController.text;
    String _habitName =_habitNameController.text;
    String _period =_selectedPeriod;
    String _habitType=_selectedHabit;

    SaveHabit(_goalName, _habitName, _period, _habitType);
    _goalNameController.clear();
    _habitNameController.clear();
    _period='January';
    _habitType='Everyday';
  }

  Future<void> saveNewHabit() {
    CreateNewHabit createNewHabit = CreateNewHabit(
      'goalName', // argument 1
      'habitName', // argument 2
      'period', // argument 3
      'habitType', // argument 4
    );
    return FirebaseFirestore.instance
        .collection('newhabits')
        .doc()
        .set({
      'goalName':_goalNameController,
      'habitName':_habitNameController,
      'period':_selectedPeriod,
      'habitType':_selectedHabit,
    });

  }



  Future <void> _dialogBuilder(BuildContext context){
    return showDialog <void>(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Create New Habit Goal',style: TextStyle(fontSize: 15),),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ],
              ),

              actions: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _goalNameController,
                          decoration: InputDecoration(
                            labelText: 'Your Goal',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your goal';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _habitNameController,
                          decoration: InputDecoration(
                            labelText: 'Habit Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your Habit Name';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          value: _selectedPeriod,
                          items: items.map((e){
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),);
                          }).toList(),
                          onChanged: (newValue){
                            setState(() {
                              _selectedPeriod=newValue!;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          value: _selectedHabit,
                          items: type.map((e){
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),);
                          }).toList(),
                          onChanged: (newValue){
                            setState(() {
                              _selectedHabit=newValue!;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: _saveForm,
                        child: const Text('Create New'),
                      )
                    ],
                  ),
                ),
                ),

              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarOpacity: 1.0,
        // bottomOpacity: 1.0,
        elevation: 0,
        title: Text('Sun,1 March 2022',
          style: TextStyle(color: Color(0xff4c505b),),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0,left:18.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(text: 'Hello,'),
                  TextSpan(text: 'Susy!',
                      style: TextStyle(fontWeight:FontWeight.w600,color: Colors.deepOrangeAccent)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0,left:18.0,right: 18.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepOrange,
                      Colors.orangeAccent,
                    ],

                ),
                // color: Colors.orange,
              ),
              child:Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircularProgressIndicator(
                              value: 0.5,
                              strokeWidth: 15,
                              backgroundColor: Colors.white60,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white70),
                            ),
                          ),
                          Text('70%',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                      Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('3 of 5 habits',style: TextStyle(fontSize: 20,color: Colors.white),),
                      Text('completed today!',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: Image.asset('assets/images/calendar.png',
                      width:120,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),

              ),
            ),
          SizedBox(
            height: 5,
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right:18.0),
            child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),color: Colors.grey.shade200,
            ),
            child:Column(
    children: [

    ListTile(
    title: Text('Your Goals',
    style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
    trailing: TextButton(
    onPressed: () {},
    child: Text(
    'See all', style: TextStyle(color: Colors.deepOrangeAccent),),
    ),
    ),
    Padding(
      padding: const EdgeInsets.only(left:8.0,right:8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.shade100,
        ),
        child: Column(
        children: [
        ListTile(
        title: Text('Finish 5 Philosophy Books',
        style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
        trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_vert),
        ),
        ),
        Padding(
        padding: const EdgeInsets.only(left:18.0,right: 30.0),
        child: LinearProgressIndicator(
        minHeight: 15,
        value: 0.5,
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(
        Colors.deepOrangeAccent)
        ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:132.0),
          child: Text('5 from 7 days target', style: TextStyle(fontSize: 15.0),),
        ),
        Padding(
          padding: const EdgeInsets.only(right:200.0),
          child: Text('Everyday', style: TextStyle(
          color: Colors.deepOrangeAccent, fontSize: 15.0),),
        )
        ],
        ),
      ),
    ),
    SizedBox(
      height: 20,
    ),
      Padding(
        padding: const EdgeInsets.only(left:8.0,right:8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey.shade100,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text('Sleep before 11 pm',
                  style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:18.0,right: 30.0),
                child: LinearProgressIndicator(
                    minHeight: 15,
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepOrangeAccent)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:132.0),
                child: Text('5 from 7 days target', style: TextStyle(fontSize: 15.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(right:200.0),
                child: Text('Everyday', style: TextStyle(
                    color: Colors.deepOrangeAccent, fontSize: 15.0),),
              )
            ],
          ),
        ),
      ),
    SizedBox(
      height:20,
    ),
      Padding(
        padding: const EdgeInsets.only(left:8.0,right:8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey.shade100,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text('Finish read the hobbits',
                  style: TextStyle(color: Color(0xff4c505b), fontSize: 20,),),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:18.0,right: 30.0),
                child: LinearProgressIndicator(
                    minHeight: 15,
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepOrangeAccent)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:132.0),
                child: Text('5 from 7 days target', style: TextStyle(fontSize: 15.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(right:200.0),
                child: Text('Everyday', style: TextStyle(
                    color: Colors.deepOrangeAccent, fontSize: 15.0),),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height:20,
      ),
    ],
        ),
        ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        onPressed: () => _dialogBuilder(context),
      ),
      bottomNavigationBar:Container(
          child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.home,color: Colors.orangeAccent,),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Progress()));
                  },
                  icon: Icon(Icons.show_chart),
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
                );
  }

  }


