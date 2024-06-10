import 'package:flutter/material.dart';
import '../../../values/values.dart';
import '../../../widgets/Dr_cardupcoming.dart';
import '../../../widgets/date_widgit.dart';
import '../../../widgets/past_appointment.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'My Appointment',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upcoming Appointments",
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontFamily: "Domine",
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DateWidget(),
                    Expanded(
                      child: Column(
                        children: [
                          const DrCardUpcoming(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "  Confirmed  ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: AppColors.OrangePeel,
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.3,
                                margin: const EdgeInsets.all(2),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.OrangePeel,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/ChatDoctorPage');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.question_answer_outlined,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Chat',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.deepsea,
                  thickness: 0.4,
                  indent: 15,
                  endIndent: 15,
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Past appointments",
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontFamily: "Domine",
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const PastAppointment(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
