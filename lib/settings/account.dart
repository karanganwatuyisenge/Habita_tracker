// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Account extends StatefulWidget {
//   const Account({Key? key}) : super(key: key);
//
//   @override
//   State<Account> createState() => _AccountState();
// }
//
// class _AccountState extends State<Account> {
//   final _formKey = GlobalKey<FormState>();
//   String? _name;
//   String? _email;
//   String? _oldPassword;
//   String? _newPassword;
//   String? _confirmPassword;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db=FirebaseFirestore.instance;
//
//   Future<void> _updateAccount() async{
//     if(!_formKey.currentState!.validate()){
//       return;
//     }
//     try{
//       final user=_auth.currentUser;
//       final credential = EmailAuthProvider.credential(
//           email: user?.email?? '',
//           password: _oldPassword!);
//       await user?.reauthenticateWithCredential(credential);
//     }on FirebaseAuthException catch(e){
//       if(e.code == 'wrong-password'){
//         _showSnackbar('Incorrect password.Please try again.');
//         return;
//       }
//       else{
//         _showSnackbar('An error occured.Please try again');
//         return;
//       }
//     }catch(e){
//       _showSnackbar('An error occured.Please try again.');
//       return;
//     }
//     try{
//       final user=_auth.currentUser;
//       if(_email!=null){
//         await user?.updateEmail(_email!);
//       }
//       if(_name!=null){
//         await _db.collection('users').doc(user?.uid).update({'name':_name});
//       }
//     }on FirebaseAuthException catch(e){
//       if(e.code=='email-already-in-use'){
//         _showSnackbar('The email address is aslready in use.');
//         return;
//       }else{
//         _showSnackbar('An error occured.Please try again');
//         return;
//       }
//     }catch(e){
//       _showSnackbar('An error occured.Please try again.');
//       return;
//     }
//     if(_newPassword !=null){
//       if(_newPassword!= _confirmPassword){
//         _showSnackbar('Passwords do not match.');
//         return;
//       }
//       try{
//         final user=_auth.currentUser;
//         await user?.updatePassword(_newPassword!);
//
//       }on FirebaseAuthException catch(e){
//         _showSnackbar('An error occured.Please try again.');
//         return;
//       }catch(e){
//         _showSnackbar('An error occured.Please try again');
//         return;
//       }
//     }
//     _showSnackbar('Account update successfully');
//   }
//
//   void _showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//   bool isValidEmail(String email) {
//     // Regex pattern for email validation
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     return emailRegex.hasMatch(email);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Account'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _name = value,
//                 initialValue: _name,
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!isValidEmail(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _email = value,
//                 initialValue: _email,
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Old Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your old password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _oldPassword = value,
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your new password';
//                   }
//                   if (value!.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _newPassword = value,
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Confirm Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _newPassword) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _confirmPassword = value,
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 child: Text('Update Account'),
//                 onPressed: _updateAccount,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/themeProvider.dart';
import 'package:tracker_habit/settings/setting.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key:key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<Account> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPasswordController=TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool isUpdating = false;


  Future<void> _updateAccount() async {
    setState(() {
      isUpdating = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final oldPassword=_oldPasswordController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'name': name});
    }

    if (email.isNotEmpty) {
      await user!.updateEmail(email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': email});
    }

    if (oldPassword.isNotEmpty) {
      final credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      try {
        await user.reauthenticateWithCredential(credentials);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OldPasswordIncorrect'.tr())));
        return;
      }
    }

    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        await user!.updatePassword(password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PasswordsDoNotMatch'.tr())));
        return;
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('AccountUpdated'.tr())));
    Navigator.pop(context);

    setState(() {
      isUpdating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'] ?? '';
        _emailController.text = user.email ?? '';
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Color(
          0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Color(
            0xFFFFFFFF),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              },
            ),
            Text(
              'Account'.tr(),
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w700,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              right: 35,
              left: 35,
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Name'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'oldPassword'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'newPassword'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'ConfirmPassword'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: isUpdating ? null : _updateAccount,
                          child: Text('Update'.tr()),
                        ),
                        isUpdating
                            ? Container(
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                        )
                            : SizedBox(),
                      ],

                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//         builder: (context,themeProvider,child){
//       final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       backgroundColor:themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF) ,
//       appBar: AppBar(
//         backgroundColor: themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF),
//         elevation: 0,
//         title:Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: themeProvider.isDarkMode ? Colors.white : Colors.black,
//                 size: 27,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Setting()),
//                 );
//               },
//             ),
//
//             Text('Account'.tr(),
//                 style: TextStyle(fontSize: 27,
//                     fontWeight: FontWeight.w700,
//                     color: themeProvider.isDarkMode? Colors.white:Colors.black)),
//           ],
//         ),
//         // title: Row(
//         //   children: [
//         //     Text(
//         //       'Account'.tr(),
//         //       style: TextStyle(
//         //         color: themeProvider.isDarkMode ? Colors.black:Color(0xff4c505b),
//         //         fontSize: 27,
//         //         fontWeight: FontWeight.w700,
//         //       ),
//         //     ),
//         //   ],
//         // ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height * 0.05,
//               right: 35,
//               left: 35,
//             ),
//             child: Column(
//               children: [
//                 Form(
//                   key: _formKey,
//                   child: Expanded(
//                     child: ListView(
//                       children: [
//                         TextFormField(
//                           controller: _nameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             labelText: 'Name'.tr(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         TextFormField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             labelText: 'Email'.tr(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             labelText: 'Password'.tr(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         TextFormField(
//                           controller: _confirmPasswordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             labelText: 'ConfirmPassword'.tr(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         ElevatedButton(
//                           onPressed: _updateAccount,
//                           child: Text('Update'.tr()),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   });
// }}
