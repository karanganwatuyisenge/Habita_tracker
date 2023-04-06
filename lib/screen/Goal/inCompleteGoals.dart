import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class IncompleteGoals extends StatefulWidget {
  const IncompleteGoals({Key? key}) : super(key: key);

  @override
  State<IncompleteGoals> createState() => _IncompleteGoalsState();
}

class _IncompleteGoalsState extends State<IncompleteGoals> {
  User user=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(user.uid).collection('goals').where("completed",isEqualTo: false).snapshots(),
        builder: (context, streamSnapshot){
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }if(streamSnapshot.hasError){
            print(streamSnapshot.error);
            return Center(child: Text("There is an error: ${streamSnapshot.error}"));
          }
          else if(streamSnapshot.hasData){
            var goals=streamSnapshot.data!.docs;

            return goals.isEmpty?const Center(child: Text("No goals yet")): Column(

                children:goals.map((goal) {
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
                              title: Text(goal['goalName'],
                                style: TextStyle(color: Colors.green,fontSize: 20),
                              ),
                              trailing: Checkbox(
                                value: goal["completed"],
                                onChanged: (bool? newValue) async{
                                final docRef=FirebaseFirestore.instance
                                    .collection("users").doc(user.uid)
                                    .collection("goals").doc(goal.id);
                                try{
                                  await docRef.update({"completed":newValue});
                                  }catch(e){
                                  print("Error updating document: $e");
                                  }
                                }
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
    );
  }
  }

