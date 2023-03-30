import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HabitScreen extends StatefulWidget{
  HabitScreen({Key? key}) : super(key:key);

  @override
  State<HabitScreen> createState() => _HabitScreen();
}

class _HabitScreen extends State<HabitScreen>{
  bool showvalue = false;
  User user=FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade200,
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text('Today Habit',
                  style: TextStyle(
                    color: Color(0xff4c505b), fontSize: 20,),),
                trailing: TextButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(
                    //         builder: (context) => YourHabit())
                    // );
                  },
                  child: const Text(
                    'See all', style: TextStyle(
                      color: Colors.deepOrangeAccent),),
                ),
              ),
      StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(user.uid).collection('habits').snapshots(),
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
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Colors.lightGreen.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(habit['habitName'],
                                style: TextStyle(color: Colors.green,fontSize: 20),
                              ),
                            ),

                          ],
                        ),
                      ),
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
    );
  }

}
