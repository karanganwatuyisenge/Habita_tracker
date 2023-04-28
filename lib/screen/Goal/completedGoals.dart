import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CompletedGoals extends StatefulWidget {
  const CompletedGoals({Key? key}) : super(key: key);

  @override
  State<CompletedGoals> createState() => _CompletedGoalsState();
}

class _CompletedGoalsState extends State<CompletedGoals> {
  User user=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(user.uid).collection('goals').where("completed",isEqualTo: true).snapshots(),
        builder: (context, streamSnapshot){
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }if(streamSnapshot.hasError){
            print(streamSnapshot.error);
            return Center(child: Text("ThereIsAnError: ${streamSnapshot.error}".tr()));
          }
          else if(streamSnapshot.hasData){
            var goals=streamSnapshot.data!.docs;

            return goals.isEmpty?Center(child: Text("NoGoalsYet".tr())): Column(

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

                              trailing:Checkbox(
                                value: goal["completed"],
                                onChanged: (bool? newValue){
                                  FirebaseFirestore.instance
                                      .collection("users").doc(user.uid)
                                      .collection("goals").doc(goal.id)
                                      .update({"completed": newValue?? false});
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
