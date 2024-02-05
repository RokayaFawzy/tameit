
import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/Profile.dart';
import 'package:tame_it/Screens/SignUp.dart';
import 'package:tame_it/Screens/forgot_Password/Resetpassword.dart';
import 'package:tame_it/Screens/forgot_Password/Verify_Phone_Number.dart';
import 'package:tame_it/Screens/forgot_Password/forgotpassword.dart';
import 'package:tame_it/Screens/forgot_Password/verification_code.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/filter_Page.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/navbar_root.dart';
import 'Screens/navbar_Root_Screens/Home.dart';

void main() {
  runApp(const TameIt());
}

class TameIt extends StatelessWidget {
  const TameIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // Login(),
          NavBarRoot(),
          
      routes: {
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/Verify_Phone_Number': (context) => PhoneVerify(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/ResetPassword': (context) => ResetPassword(),
        '/CodePhone': (context) => CodePhone(),
        '/Profile': (context) => Profile(),
        '/Home': (context) => Home(),
        '/FiltersScreen':(context) => FiltersScreen(),

      },
    );
  }
}

