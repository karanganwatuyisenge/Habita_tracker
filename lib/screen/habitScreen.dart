import 'package:flutter/material.dart';

class HabitScreen extends StatefulWidget{
  HabitScreen({Key? key}) : super(key:key);

  @override
  State<HabitScreen> createState() => _HabitScreen();
}

class _HabitScreen extends State<HabitScreen>{
  bool showvalue = false;
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreen.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text('Meditating', style: TextStyle(
                          color: Colors.green, fontSize: 20,),),
                        Row(
                          children: [
                            Checkbox(
                              value: showvalue,
                              onChanged: (bool? value) {},),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert)),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreen.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text('Read Philosophy',
                          style: TextStyle(
                            color: Colors.green, fontSize: 20,),),
                        Row(
                          children: [
                            Checkbox(
                              value: showvalue,
                              onChanged: (bool? value) {},),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert)),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white60,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text('Journaling', style: TextStyle(
                          color: Colors.green, fontSize: 20,),),
                        Row(
                          children: [
                            Checkbox(
                              value: showvalue,
                              onChanged: (bool? value) {},),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert)),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
    );
  }

}
