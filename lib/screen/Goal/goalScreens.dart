import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/screen/Goal/seeAllGoal.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/myThemes.dart';
import 'package:tracker_habit/provider/themeProvider.dart';


class GoalScreens extends StatefulWidget{
  GoalScreens({Key? key}) : super(key:key);

  @override
  State<GoalScreens> createState() => _GoalScreens();
}

class _GoalScreens extends State<GoalScreens>{
  bool showvalue = false;
  User user=FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
    builder: (context,themeProvider,child){
      return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: themeProvider.isDarkMode ? Colors.black : Color(0xFFFFFFFF),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text('YourGoals'.tr(),
                  style: TextStyle(
                    color: themeProvider.isDarkMode ?Colors.white:Color(0xff4c505b), fontSize: 20,),),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SeeAllGoal()));
                  },
                  child: Text(
                    'SeeAll'.tr(), style: TextStyle(
                      color: themeProvider.isDarkMode?Colors.blue:Colors.deepOrangeAccent),),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                stream: FirebaseFirestore.instance.collection('users')
                    .doc(user.uid).collection('goals').limit(3).where("completed",isEqualTo: false).snapshots(),
                builder: (context, streamSnapshot){
                  if(streamSnapshot.connectionState==ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }if(streamSnapshot.hasError){
                    print(streamSnapshot.error);
                    return Center(child: Text("ThereIsAnError: ${streamSnapshot.error}".tr()));
                  }
                  else if(streamSnapshot.hasData){
                    var goals=streamSnapshot.data!.docs;

                    return goals.isEmpty?Center(child: Text("NoGoalsAreCompleted".tr())): Column(

                        children:goals.map((goal) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:themeProvider.isDarkMode?Colors.grey:Colors.lightGreen.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(goal['goalName'],
                                        style: TextStyle(color:themeProvider.isDarkMode?Colors.white: Colors.green,fontSize: 20),
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
            ],
          ),
        ),
      );
    });

  }
    }

