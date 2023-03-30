import 'package:flutter/material.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/images/add.png')),
          Text('Done!',style: TextStyle(fontSize: 40),),
          Text('New Habit has added',style: TextStyle(fontSize: 20),),
          Text('Lets do the best to achieve your goal',style: TextStyle(fontSize: 20),),
          ElevatedButton(
              onPressed: (){}, child: Text('Ok'))
          // Container(
          //   child: Image.asset('assets/images/add.png'),
          // ),
        ],
      ),
    );
  }
}
