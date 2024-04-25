import 'package:flutter/material.dart';

class IntPage2 extends StatefulWidget {
  const IntPage2({super.key});

  @override
  State<IntPage2> createState() => _IntPage2State();
}

class _IntPage2State extends State<IntPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Align(
        alignment: const Alignment(0.03, -0.38),
        child: Container(
          alignment: Alignment(0.03, -0.38),
          child: Image.asset(
            "assets/images/B2.png",
            width: 600, // Adjust the width as needed
            height: 600, // Adjust the height as needed
          ),
        ),
      ),
    );
  }
}
