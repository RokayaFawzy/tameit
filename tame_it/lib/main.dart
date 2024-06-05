import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/Testings/Adult_ADHD.dart';
import 'package:tame_it/Screens/Testings/Depressionscale.dart';
import 'package:tame_it/Screens/Testings/OCDscale.dart';
import 'package:tame_it/Screens/Testings/PTSD.dart';
import 'package:tame_it/Screens/Testings/testings.dart';
import 'package:tame_it/Screens/beging_screens/splash_screen.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/chat_doctor.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/doctor_details.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/BlogPage.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/onlinepage.dart';
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
import 'package:tame_it/Screens/navbar_Root_Screens/more.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/therapistspage.dart';
import 'package:tame_it/values/values.dart';
import 'Screens/Testings/Anxietyscale.dart';
import 'Screens/Testings/dep,anx,str.dart';
import 'Screens/navbar_Root_Screens/branch_Screens/BookingPage.dart';
import 'Screens/navbar_Root_Screens/more pages/payment.dart';
import 'Screens/navbar_Root_Screens/navbar_root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/Personal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool rememberMe = prefs.getBool('rememberMe') ?? false;
  String? username = prefs.getString('username');
  String? password = prefs.getString('password');

  runApp(
      TameIt(rememberMe: rememberMe, username: username, password: password));
}

class TameIt extends StatelessWidget {
  final bool rememberMe;
  final String? username;
  final String? password;

  const TameIt(
      {required this.rememberMe, this.username, this.password, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: rememberMe && username != null && password != null
          ? NavBarRoot() // Automatically log in if "Remember me" was checked and credentials are stored
          :
          // SplashScreen(),
          Login(),
          // NavBarRoot(),
          // PaymentFormPage(),
          // AppointmentBooking(),
          
      routes: {
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/Verify_Phone_Number': (context) => PhoneVerify(),
        '/ChangePassword': (context) => ChangePassword(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/ResetPassword': (context) => ResetPassword(
              username: '',
            ),
        '/CodePhone': (context) => CodePhone(
              username: '',
              sendVerificationEmail: (String) {},
            ),
        '/Profile': (context) => Profile(),
        '/Therapists': (context) => Therapists(),
        '/OnlineTherapists': (context) => OnlineTherapists(),
        '/FiltersScreen': (context) => FiltersScreen(),
        '/EditInformation': (context) => EditInformation(),
        '/PersonalInformation': (context) => PersonalInformation(),
        '/Home': (context) => Home(),
        '/More': (context) => MorePage(),
        '/NavBarRoot': (context) => NavBarRoot(),
        '/DoctorDetails': (context) => DoctorDetails(),
        '/ChatDoctorPage': (context) => ChatDoctorPage(),
        '/Testings': (context) => Testings(),
        '/BlogPage': (context) => BlogPage(),
        '/Dep_Anx_Str': (context) => Dep_Anx_Str(),
        '/AnxietyScale': (context) => AnxietyScale(),
        '/DepressionScale': (context) => DepressionScale(),
        '/OCDScale': (context) => OCDScale(),
        '/PTSDScale': (context) => PTSD(),
        '/Adult_ADHD_Self_ReportScale': (context) =>
            Adult_ADHD_Self_Report_Scale(),
        '/AppointmentBooking': (context) => AppointmentBooking(),
        '/PaymentFormPage':(context) => PaymentFormPage(),
      },
      theme: ThemeData.from(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: AppColors.deepsea, // قم بتغيير اللون هنا
            ),
      ),
    );
  }
}
