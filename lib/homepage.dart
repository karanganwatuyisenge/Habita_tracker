import 'package:flutter/material.dart';
import 'progressess/progressess.dart';
import 'settings/setting.dart';
import 'progressess/yourHabit.dart';

class HomePage extends StatelessWidget {
  bool showvalue = false;

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
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Your Goal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height:15,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Habit Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text('Period'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Habit Type'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
          Row(
          children: [
          ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
          child:Text('Create New'),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CircularProgressIndicator()));

          },
          ),
            ],

          ),]);
        });
  }
