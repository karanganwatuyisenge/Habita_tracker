import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:tracker_habit/authentication/login.dart';

class NewPassword extends StatelessWidget {
  const NewPassword ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              // padding: EdgeInsets.only(top:0),
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    Text('Enter new password'),
                    SizedBox(
                      height: 30,
                    ),
                    OtpTextField(
                        numberOfFields:5,
                        borderColor:Colors.grey,
                        showFieldAsBox:true,
                        onCodeChanged:(String code){

                        },
                        onSubmit:(String verificationCode){
                          showDialog(context: context,
                              builder: (context)
                              {
                                return AlertDialog(
                                  title: Text('Verification Code'),
                                  content: Text('Code entered is $verificationCode '),
                                );
                              });
                        }
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
                            child:Text('Submit'),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MyLogin())
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