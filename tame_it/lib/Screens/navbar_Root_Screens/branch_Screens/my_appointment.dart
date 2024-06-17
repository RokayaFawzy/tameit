import 'package:flutter/material.dart';
import '../../../values/values.dart';

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

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width * 0.3;

    return Container(
      width: containerSize,
      height: containerSize,
      padding: const EdgeInsets.all(5),
      child: Container(
        color: AppColors.deepsea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            const Flexible(
              child: Text(
                'monthNameYear',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Flexible(
              child: Text(
                'dayOfMonth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.50,
                  fontFamily: "Domine",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Flexible(
              child: Text(
                'at ' + 'hours'+':'+'minutes',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrCardUpcoming extends StatelessWidget {
  const DrCardUpcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.only(left: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/123.jpg'),
            ),
          ),
          const SizedBox(width: 8), // Adjust spacing
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                        "Dr."+" "+"doctorFName"+" doctorLName",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                        "clinicName",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 14), // Adjust spacing
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.deepsea,
                ),
              ),
              const SizedBox(height: 20), // Adjust spacing
            ],
          ),
        ],
      ),
    );
  }
}

class PastAppointment extends StatelessWidget {
  const PastAppointment({super.key});
  final int n = 3;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: List.generate(n, (index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Adjust alignment
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/123.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8), // Adjust spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Dr."+" "+"doctorFName"+" doctorLName",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepsea,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "clinicName",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.deepsea,
                        ),
                      ),
                      SizedBox(height: 14), // Adjust spacing
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "fees",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Domine",
                          color: AppColors.deepsea,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.OrangePeel,
                      ),
                      SizedBox(width: 4), // Adjust spacing
                      Text(
                        "monthNameYear"+" dayOfMonth"+", dayOfWeek",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Adjust spacing
                Container(
                  width: screenWidth *
                      0.3, // Adjust the width according to the screen size
                  margin: const EdgeInsets.all(11),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.deepsea,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(25)), // Adjust the border radius
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/ChatDoctorPage');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.question_answer_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'send message',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: AppColors.deepsea,
              thickness: 0.1,
              height: 9,
            ),
            const SizedBox(height: 5)
          ],
        );
      }),
    );
  }
}
