import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker_habit/authentication/signup.dart';
import 'package:tracker_habit/authentication/forgotpassword.dart';
import '../homepage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController _emailController =TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  String _errorMessage='';
  String _userName = '';
  bool showvalue=false;
  bool isLoading=false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void Login() async{
    setState(() {
      isLoading = true;
    });
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage())
      );
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email')));
      }
      else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('WrongPassword'.tr())));
      }
      else{
        print('${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Fill All Fields')));
      }
    }finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var user=FirebaseAuth.instance.currentUser;
      if(user!=null){
        Navigator.of(context).pushReplacementNamed('home');
      }
    });

  }

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
              Text('LogIn'.tr(),style:
              TextStyle(
                color:Color(0xff4c505b),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
              ),
              Row(
                children: [
                  TextButton(
                    child:Text('SignUp'.tr(),style: TextStyle(color: Colors.deepOrangeAccent),),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password'.tr(),
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
                        //Text('RememberMe'.tr(),style: TextStyle(color: Colors.grey),),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextButton(
                              onPressed:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ForgotPassword())
                                );
                              },
                              child:Text('ForgotPassword'.tr(),style: TextStyle(color: Colors.deepOrangeAccent),)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width:280,
                          child: Stack(
                            children:[
                              Center(
                                child: SizedBox(
                                  width: 280,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                                    ),
                                    child: Text('LogIn'.tr()),
                                    onPressed: () {
                                      Login();
                                    },
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: isLoading,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ]
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

