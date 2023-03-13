import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:tracker_habit/authentication/forgotpassword.dart';

import '../homepage.dart';
class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool showvalue=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: const EdgeInsets.only(left: 20,top: 30,),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Log In',style:
              TextStyle(
                color:Color(0xff4c505b),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
              ),
              Row(
                children: [
                  TextButton(
                    child:Text('Sign Up',style: TextStyle(color: Colors.deepOrangeAccent),),
                    onPressed: (){
                      // print('Login');
                      Navigator.of(context).pushNamed('signup');
                    },
                  ),
                  Container(
                    child: IconButton(
                      color: Colors.deepOrangeAccent,
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),

                  ),
                ],
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              // padding: EdgeInsets.only(top:0),
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email',
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
                        Checkbox(
                            value: showvalue,
                            onChanged: (bool? value){
                              setState((){
                                showvalue=value!;
                              });
                            }),
                        Text('Remember me',style: TextStyle(color: Colors.grey),),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextButton(
                              onPressed:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ForgotPassword())
                                );
                              },
                              child:Text('Forgot Password?',style: TextStyle(color: Colors.deepOrangeAccent),)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width:280,
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                            child:Text('Log In'),
                            onPressed: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomePage())
                              );


                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}