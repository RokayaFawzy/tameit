import 'package:flutter/material.dart';

import '../../../Models/Doctor_model.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/past_appointment.dart';

class MyDoctor extends StatefulWidget {
  const MyDoctor({super.key});

  @override
  State<MyDoctor> createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize =
        screenWidth * 0.04; // Adjust the multiplier as needed

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'My doctor',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        shadowColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "The doctors with whom I have booked appointments :",
                          style: TextStyle(
                            color: AppColors.OrangePeel,
                            fontSize: fontSize,
                            fontFamily: "Domine",
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                PastAppointment(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
