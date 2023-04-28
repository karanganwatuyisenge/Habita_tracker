import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget{
  GoalScreen({Key? key}) : super(key: key);

  @override
  State<GoalScreen> createState() => _GoalScreen();
}

class _GoalScreen extends State<GoalScreen>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text('YourGoals'.tr(),
                style: TextStyle(
                  color: Color(0xff4c505b), fontSize: 20,),),
              trailing: TextButton(
                onPressed: () {},
                child: Text(
                  'SeeAll'.tr(), style: TextStyle(
                    color: Colors.deepOrangeAccent),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Finish 5 Philosophy Books',
                        style: TextStyle(color: Color(0xff4c505b),
                          fontSize: 20,),),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 30.0),
                      child: LinearProgressIndicator(
                          minHeight: 15,
                          value: 0.5,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepOrangeAccent)
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 132.0),
                      child: Text('5 from 7 days target',
                        style: TextStyle(fontSize: 15.0),),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200.0),
                      child: Text('Everyday', style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 15.0),),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Sleep before 11 pm',
                        style: TextStyle(color: Color(0xff4c505b),
                          fontSize: 20,),),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 30.0),
                      child: LinearProgressIndicator(
                          minHeight: 15,
                          value: 0.5,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepOrangeAccent)
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 132.0),
                      child: Text('5 from 7 days target',
                        style: TextStyle(fontSize: 15.0),),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200.0),
                      child: Text('Everyday', style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 15.0),),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Finish read the hobbits',
                        style: TextStyle(color: Color(0xff4c505b),
                          fontSize: 20,),),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 30.0),
                      child: LinearProgressIndicator(
                          minHeight: 15,
                          value: 0.5,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepOrangeAccent)
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 132.0),
                      child: Text('5 from 7 days target',
                        style: TextStyle(fontSize: 15.0),),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200.0),
                      child: Text('Everyday', style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 15.0),),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

}
