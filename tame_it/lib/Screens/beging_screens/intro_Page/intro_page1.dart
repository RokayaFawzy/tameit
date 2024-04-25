import 'package:flutter/material.dart';

class IntPage1 extends StatefulWidget {
  const IntPage1({super.key});

  @override
  State<IntPage1> createState() => _IntPage1State();
}

class _IntPage1State extends State<IntPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: const Alignment(0.03, -0.38),
        child: Container(
          alignment: Alignment(0.03, -0.38),
          child: Image.asset(
            "assets/images/B1.png",
            width: 600, // Adjust the width as needed
            height: 600, // Adjust the height as needed
          ),
        ),
      ),
    );
  }
}
