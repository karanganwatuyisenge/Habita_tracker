import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/models/createNewHabit.dart';
import 'package:tracker_habit/screen/createNewHabit.dart';
import 'package:tracker_habit/screen/goalScreen.dart';
import 'progressess/progressess.dart';
import 'settings/setting.dart';
import 'progressess/yourHabit.dart';
import 'screen/habitScreen.dart';



class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = '';
  List<String> _data = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    User user = auth.currentUser!;
    String userId = user.uid;
    DocumentSnapshot snapshot = await _firestore.collection('users')
        .doc(userId)
        .get();

    setState(() {
      _userName = snapshot.get('name');
    });
  }



  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _data = ['Item 1', 'Item 2', 'Item 3'];
    });
  }

  Future <void> _dialogBuilder(BuildContext context) {
    return showDialog <void>(
        context: context,
        builder: (BuildContext context) {
          return NewGoalHabit();
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
        title: const Text('Sun,1 March 2022',
          style: TextStyle(color: Color(0xff4c505b),),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: () {
              if (mounted) {
                return _refreshData();
              }
              else {
                return Future.value();
              }
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Hello,'),
                        TextSpan(text: 'Susy!',
                            style: TextStyle(fontWeight: FontWeight.w600,
                                color: Colors.deepOrangeAccent)),
                      ],
                    ),
                  ),
                ),
                Text('Welcome, $_userName!'),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 18.0, right: 18.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.deepOrange,
                          Colors.orangeAccent,
                        ],

                      ),
                      // color: Colors.orange,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const SizedBox(
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
                                const Text('70%',
                                  style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('3 of 5 habits', style: TextStyle(
                                    fontSize: 20, color: Colors.white),),
                                const Text('completed today!', style: TextStyle(
                                    fontSize: 20, color: Colors.white),),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: Image.asset('assets/images/calendar.png',
                            width: 120,
                            alignment: Alignment.bottomRight,
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: HabitScreen(),
                ),

                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: GoalScreen(),
                ),
              ],
            ),


          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        onPressed:() => _dialogBuilder(context)
      ),
      bottomNavigationBar: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home, color: Colors.orangeAccent,),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Progress()));
                  },
                  icon: const Icon(Icons.show_chart),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const Setting()));
                  },
                  icon: const Icon(Icons.settings),
                ),

              ]
          )
      ),
    );
  }
}
