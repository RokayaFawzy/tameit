import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/SignUp.dart';

void main() {
  runApp(const TameIt());
}

class TameIt extends StatelessWidget {
  const TameIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Login(),
      routes: {
        '/Login' :(context) => Login(),
        '/SignUp': (context) => SignUp(),
      },
    );
  }
}
