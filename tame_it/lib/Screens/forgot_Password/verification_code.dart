import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class CodePhone extends StatefulWidget {
  const CodePhone({super.key});

  @override
  State<CodePhone> createState() => _CodePhoneState();
}

class _CodePhoneState extends State<CodePhone> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';
  late Timer _timer;
  int _start = 60;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  // verify() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   const oneSec = Duration(milliseconds: 10000);
  //   _timer = Timer.periodic(oneSec, (timer) {
  //     setState(() {
  //       _isLoading = false;
  //       _isVerified = true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Center(
            child: Text(
              'Verification code',
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 16,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 0.07,
              ),
            ),
          ),
          shadowColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.deepsea)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    " Please enter the verification code",
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.bold,
                      // letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left:10.0,right: 10),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    " we have sent a verification code to your Email ",
                    style: TextStyle(
                      color: AppColors.Bermuda,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: VerificationCode(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                      color: AppColors.Bermuda,
                    ),
                    length: 4,
                    onCompleted: (value) {
                      setState(() {
                        _code = value;
                      });
                    },
                    onEditing: (value) {}),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn\'t receive the OTP ?',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isResendAgain) return;
                      resend();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const PhoneVerify(),
                      //   ),
                      // );
                    },
                    child: Text(
                      _isResendAgain
                          ? "Try Again in" + _start.toString()
                          : '   Resend',
                      style: const TextStyle(
                        color: AppColors.deepsea,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              CustomButton(
                title: "Next",
                color: AppColors.deepsea,
                textStyle: const TextStyle(
                  fontSize: 16, // Adjust the font size as needed
                  color: Colors.white, // Change the text color as needed
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ResetPassword');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
