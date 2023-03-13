import 'package:flutter/material.dart';
import 'package:tracker_habit/homepage.dart';
import 'package:tracker_habit/settings/setting.dart';

import '../progressess/progressess.dart';

class Account extends StatefulWidget{
  Account({Key? key}) : super(key:key);

  @override
  State<Account> createState() => _MyAccountState();

}

class _MyAccountState extends State<Account>{
  @override
  Widget build(BuildContext Context){
    return Container(
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
        children: [
        Text('Account',style:
        TextStyle(
        color:Color(0xff4c505b),
    fontSize: 27,
    fontWeight: FontWeight.w700,
    ),
    ),
    ],
    ),
    ),
          body:Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,
                  right: 35,
                  left: 35,
                ),
      child: Column(
        children: [
      TextField(
      decoration: InputDecoration(
      fillColor: Colors.white,
        filled: true,
        hintText: 'Name',
        suffixIcon: IconButton(
          onPressed: () {  },
          icon: Icon(Icons.input),

        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
    height:30,
    ),
    TextField(
    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: 'Email',
      suffixIcon: IconButton(
        onPressed: () {  },
        icon: Icon(Icons.input),

      ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    SizedBox(
    height: 30,
    ),
    TextField(
    obscureText: true,
    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: 'Password',
      suffixIcon: IconButton(
        onPressed: () {  },
        icon: Icon(Icons.remove_red_eye_outlined),

      ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    SizedBox(
    height: 30,
    ),
    TextField(
    obscureText: true,
    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: 'Password Confirmation',
      suffixIcon: IconButton(
        onPressed: () {  },
        icon: Icon(Icons.remove_red_eye_outlined),

      ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    SizedBox(
    height: 40,
    ),
    Row(
    children: [
    Container(
    width:280,
    child: ElevatedButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
    child:Text('Update'),
    onPressed: (){

    },
    ),

              ),
            ]
          ),
    ],
    ),
    ),
    ],
    ),

    )
    );
  }
}
