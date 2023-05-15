import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'login.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          right: 35,
          left: 35,
        ),
        child: Column(
          children: [
            Text('EnterNewPassword'),
            SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
              ),
              onPressed: () {
                String newPassword = _passwordController.text.trim();
                resetPassword(newPassword);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await user?.updatePassword(newPassword);
      // Password reset successful
    } catch (e) {
      // Handle any errors that occurred during the process
      print('Error resetting password: $e');
    }
  }
}




// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:tracker_habit/authentication/login.dart';
//
// class NewPassword extends StatelessWidget {
//   const NewPassword ({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               // padding: EdgeInsets.only(top:0),
//               child: Container(
//                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
//                   right: 35,
//                   left: 35,
//                 ),
//                 child: Column(
//                   children: [
//                     Text('EnterNewPassword'.tr()),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     OtpTextField(
//                         numberOfFields:5,
//                         borderColor:Colors.grey,
//                         showFieldAsBox:true,
//                         onCodeChanged:(String code){
//
//                         },
//                         onSubmit:(String verificationCode){
//                           showDialog(context: context,
//                               builder: (context)
//                               {
//                                 return AlertDialog(
//                                   title: Text('VerificationCode'.tr()),
//                                   content: Text('CodeEnteredIs $verificationCode'.tr()),
//                                 );
//                               });
//                         }
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width:280,
//                           child: ElevatedButton(
//                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
//                             child:Text('Submit'.tr()),
//                             onPressed: (){
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => MyLogin())
//                               );
//
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }