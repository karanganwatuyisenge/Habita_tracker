import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'newpassword.dart';

class OtpCode extends StatelessWidget {
  const OtpCode({Key? key}) : super(key: key);

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
                    Text('EnterOTPCodeWeveSentToYourEmail'.tr()),
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
                                  title: Text('VerificationCode'.tr()),
                                  content: Text('CodeEnteredIs $verificationCode'.tr()),
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
                            child:Text('Submit'.tr()),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => NewPassword())
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