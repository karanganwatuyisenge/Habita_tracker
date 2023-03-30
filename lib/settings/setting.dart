import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/login.dart';
import '../homepage.dart';
import '../progressess/progressess.dart';
import 'account.dart';

class Setting extends StatefulWidget{
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _MySettingState();
}

class _MySettingState extends State<Setting>{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) =>MyLogin()),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context){
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Setting',style: TextStyle(fontSize: 27,color:Color(0xff4c505b),)),
          elevation:0,
        ),
        body:Container(
          child: ListView(
            children: [
              ListTile(
                title: Text('Account'),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Account()));
                  },
                    icon: Icon(Icons.arrow_forward_ios),),
              ),
              ListTile(
                title: Text('Term and Condition'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Policy'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('About App'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Log Out'),
                trailing: IconButton(
                    onPressed: () async {
                      await _signOut(context);
                    },
                  icon: Icon(Icons.logout),),
              ),
            ],
          ),
        ),
        bottomNavigationBar:Container(
            child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  IconButton(
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())
                      );
                    },
                    icon: Icon(Icons.home),
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Progress()));
                    },
                    icon: Icon(Icons.show_chart),
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                    icon: Icon(Icons.settings,color: Colors.orangeAccent,),
                  ),

                ]
            )
        ),
      ),
    );
  }
}
