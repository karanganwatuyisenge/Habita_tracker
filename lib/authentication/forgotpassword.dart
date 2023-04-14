import 'package:flutter/material.dart';
import 'package:tracker_habit/authentication/optcode.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    Text('Enter your email below, we will send instructions to reset your password.'),
                    SizedBox(
                      height: 30,
                    ),
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
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 280,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrangeAccent)),
                            child: Text('Submit'),
                            onPressed: (){},
                            // onPressed: () async {
                            //   String email = _emailController.text.trim();
                            //   RegExp emailRegex =
                            //   RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            //   if (emailRegex.hasMatch(email)) {
                            //     String otpCode = generateOtpCode();
                            //     await sendOtpCodeByEmail(email, otpCode);
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 OtpCode(email: email, otpCode: otpCode)));
                            //   } else {
                            //     showDialog(
                            //         context: context,
                            //         builder: (context) => AlertDialog(
                            //           title: Text('Invalid Email'),
                            //           content: Text(
                            //               'Please enter a valid email address.'),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: () =>
                            //                     Navigator.pop(context),
                            //                 child: Text('OK'))
                            //           ],
                            //         ));
                            //   }
                            // },
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
