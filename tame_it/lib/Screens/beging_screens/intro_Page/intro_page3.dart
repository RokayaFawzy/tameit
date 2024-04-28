import 'package:flutter/material.dart';

class IntPage3 extends StatefulWidget {
  const IntPage3({super.key});

  @override
  State<IntPage3> createState() => _IntPage3State();
}

class _IntPage3State extends State<IntPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: const Alignment(0.03, -0.38),
        child: Container(
          alignment: Alignment(0.03, 0.06),
          child: Image.asset(
            "assets/images/B3.png",
            width: 550, // Adjust the width as needed
            height: 550, // Adjust the height as needed
          ),
        ),
      ),
    );
  }
}
