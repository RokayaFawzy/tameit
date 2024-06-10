import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

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
                        "Dr. Georgia Griffin",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepsea,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "ADHD",
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
                        r"$24",
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
                        "  Jan 15, Sunday",
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
