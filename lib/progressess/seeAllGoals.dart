import 'package:flutter/material.dart';
import 'package:tracker_habit/progressess/progressess.dart';



class SeeAllGoals extends StatefulWidget{
  SeeAllGoals({Key? key}) : super(key:key);

  @override
  State<SeeAllGoals> createState() => _SeeAllGoalsState();
}

class _SeeAllGoalsState extends State<SeeAllGoals>{
  List<String> items=<String>[
    'All','Item1','Item2','Item3','Item4',
  ];
  String dropdownValue='All';
  @override
  Widget build(BuildContext Context){
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Progress()));
                    },
                  icon: Icon(Icons.arrow_back)),
                Text('Your Goals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                DropdownButton<String>(
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
                ),
              ],
            ),
            SizedBox(
              height: 15,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.white60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
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
                            Text('Journaling everyday',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(
                                onPressed: (){},
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightGreen.shade100,),
                                    child: Text('Achieved',style: TextStyle(color: Colors.green),)))

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.white60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
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
                            Text('Cooking Practice',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(
                                onPressed: (){},
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightGreen.shade100,),
                                    child: Text('Achieved',style: TextStyle(color: Colors.green),)))

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.white60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: 0.7,
                                  backgroundColor: Colors.blueGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                                Text('70%',style: TextStyle(
                                  color: Colors.grey,
                                ),),
                              ],
                            ),
                            Text('Vitamin',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(
                                onPressed: (){},
                                child: Text('Unachieved',style: TextStyle(color: Colors.grey),))

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.white60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
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
                            Text('Mediate',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(
                                onPressed: (){},
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightGreen.shade100,),
                                    child: Text('Achieved',style: TextStyle(color: Colors.green),)))

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.white60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: 0.7,
                                  backgroundColor: Colors.blueGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                                Text('70%',style: TextStyle(
                                  color: Colors.grey,
                                ),),
                              ],
                            ),
                            Text('Learn Arabic',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(
                                onPressed: (){},
                                child: Text('Unachieved',style: TextStyle(color: Colors.grey),))

                          ],
                        ),
                      ),
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

