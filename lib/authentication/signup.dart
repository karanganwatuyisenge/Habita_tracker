import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:dio/dio.dart';
import 'package:tracker_habit/country.dart';

import '../geolocation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _MySignupState();
}

class _MySignupState extends State<SignUp> {
  // String _selectedValue = 'Rwanda';
  // final List<String> _options = ['Rwanda', 'Kenya', 'Tanzania', 'Uganda', 'Burundi',];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  List <Country> _country= [];
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    // fetchCountries();
  }

  // fetchCountries() async{
  //   final response = await Dio().get('https://restcountries.com/v2/all?fields=name,capital,callingCodes,flags');
  //   final jsonData = response.data;
  //   List <Country> countries=[];
  //   for(var country in jsonData){
  //     var item = Country.fromJson(country);
  //     countries.add(item);
  //   }
  //   setState(() {
  //     _country=countries;
  //   });
  //   print("length ${_country.length}");
  // }

  void _Register() async {
    print("Signing up...");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
      });
      Navigator.pop(context);
    }
    on FirebaseAuthException catch (e) {
      print("Exception here ${e.code}");
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    }
    catch (e) {
      print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    print("length ${_country.length}");
    return Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 88.0, left: 25.0, right: 25.0,),
            child: ClipRect(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sign Up', style:
                      TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: const Text('Log In', style: TextStyle(color: Colors
                                .deepOrangeAccent),),
                            onPressed: () {
                              // print('Login');
                              Navigator.of(context).pushNamed('login');
                            },
                          ),
                          Container(
                            child: IconButton(
                              color: Colors.deepOrangeAccent,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyLogin()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Country>(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: 'Country',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) ),
                      value: _selectedCountry,
                      hint: Text('Country'),
                      items: _country.map((e) => DropdownMenuItem(
                        value: e,
                          child: Text(e.name))).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCountry=newValue;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter yur confirm password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _Register();
                      }
                    },
                    child: const Text('Sign Up'),
                  )
                ],

              ),
            ),
          ),
        )
    );
  }
}


//   validator: (value){
//   if(value == null){
//     return 'Please select your country';
//   }
//   return null;
//   },
// ),