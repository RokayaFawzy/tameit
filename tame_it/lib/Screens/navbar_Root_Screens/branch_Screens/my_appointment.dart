import 'package:flutter/material.dart';
import '../../../values/values.dart';
import '../../../widgets/Dr_cardupcoming.dart';
import '../../../widgets/date_widgit.dart';
import '../../../widgets/past_appointment.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Upcoming Appointments",
                        style: TextStyle(
                          color: AppColors.deepsea,
                          fontSize: 16,
                          fontFamily: "Domine",
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DateWidget(),
                    Column(
                      children: [
                        const DrCardUpcoming(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: Row(
                                children: [
                                  Text(
                                    "  Confirmed  ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    size: 20,
                                    color: AppColors.OrangePeel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: const EdgeInsets.all(11),
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
                                  children: [
                                    Icon(
                                      Icons.question_answer_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12),
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
                  ],
                ),
                const Divider(
                  color: AppColors.deepsea,
                  thickness: 0.4,
                  indent: 15,
                  endIndent: 15,
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Past appointments",
                        style: TextStyle(
                          color: AppColors.deepsea,
                          fontSize: 16,
                          fontFamily: "Domine",
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const PastAppointment(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
