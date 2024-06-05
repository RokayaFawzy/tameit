import 'package:flutter/material.dart';

import '../../../Models/Doctor_model.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_card.dart';

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
          '                 My doctor',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        shadowColor: Colors.white,
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
                            color: AppColors.deepsea,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2, // Assuming there are 2 doctors
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DoctorCard(
                        // Assuming DoctorCard requires a Doctor object
                        doctor: Doctor(
                          firstName: 'Smith',
                          specialty: 'Psychologist',
                          rating: 5,
                          lastName: ' Wilson',
                          price: '800',
                          experienceYears: '24 yr',
                          interest: 'Depression, Stress, Anxiety',
                          image: 'assets/images/123.jpg',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
