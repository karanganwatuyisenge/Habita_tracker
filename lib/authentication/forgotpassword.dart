import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:tracker_habit/authentication/optcode.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}


class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendOTPCode(String email) async{
    FirebaseAuth auth=FirebaseAuth.instance;

    try{
      List<String> signInMethods=await auth.fetchSignInMethodsForEmail(email);
      if(signInMethods.isNotEmpty){
        await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP code sent successfully')));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email is not registered')));
      }
    }catch(e){
      print('Error sending OTP code :$e');
    }

  }


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
            Text('EnterYourEmailBelowWeWillSendInstructionsToResetYourPassword'.tr()),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
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
                String email = _emailController.text.trim();
                sendOTPCode(email);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}



// class ForgotPassword extends StatelessWidget {
//   ForgotPassword({Key? key}) : super(key: key);
//
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.1,
//                   right: 35,
//                   left: 35,
//                 ),
//                 child: Column(
//                   children: [
//                     Text('EnterYourEmailBelowWeWillSendInstructionsToResetYourPassword'.tr()),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 280,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                 MaterialStateProperty.all(Colors.deepOrangeAccent)),
//                             child: Text('Submit'),
//                             onPressed: (){},
//                             // onPressed: () async {
//                             //   String email = _emailController.text.trim();
//                             //   RegExp emailRegex =
//                             //   RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                             //   if (emailRegex.hasMatch(email)) {
//                             //     String otpCode = generateOtpCode();
//                             //     await sendOtpCodeByEmail(email, otpCode);
//                             //     Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //             builder: (context) =>
//                             //                 OtpCode(email: email, otpCode: otpCode)));
//                             //   } else {
//                             //     showDialog(
//                             //         context: context,
//                             //         builder: (context) => AlertDialog(
//                             //           title: Text('Invalid Email'),
//                             //           content: Text(
//                             //               'Please enter a valid email address.'),
//                             //           actions: [
//                             //             TextButton(
//                             //                 onPressed: () =>
//                             //                     Navigator.pop(context),
//                             //                 child: Text('OK'))
//                             //           ],
//                             //         ));
//                             //   }
//                             // },
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
