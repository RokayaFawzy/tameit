import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/SignUp.dart';
import 'package:tame_it/Screens/forgot_Password/Verify_Phone_Number.dart';

void main() {
  runApp(const TameIt());
}

class TameIt extends StatelessWidget {
  const TameIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      //  PhoneVerify(),

      routes: {
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/Verify_Phone_Number': (context) => PhoneVerify(),
      },
    );
  }
}
