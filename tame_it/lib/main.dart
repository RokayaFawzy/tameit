import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/changePassword.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/Home.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/Profile.dart';
import 'package:tame_it/Screens/SignUp.dart';
import 'package:tame_it/Screens/forgot_Password/Resetpassword.dart';
import 'package:tame_it/Screens/forgot_Password/Verify_Phone_Number.dart';
import 'package:tame_it/Screens/forgot_Password/forgotpassword.dart';
import 'package:tame_it/Screens/forgot_Password/verification_code.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/edit_Profile_Page.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/filter_Page.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/more.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/therapistspage.dart';
import 'Screens/navbar_Root_Screens/navbar_root.dart';

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
       Login(),
      // NavBarRoot(),

      routes: {
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/Verify_Phone_Number': (context) => PhoneVerify(),
        '/ChangePassword': (context) => changePassword(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/ResetPassword': (context) => ResetPassword(),
        '/CodePhone': (context) => CodePhone(),
        '/Profile': (context) => Profile(),
        '/Therapists': (context) => Therapists(),
        '/FiltersScreen': (context) => FiltersScreen(),
        '/EditInformation': (context) => EditInformation(),
        '/Home':(context) => Home(),
        '/More': (context) => MorePage(),

      },
    );
  }
}
