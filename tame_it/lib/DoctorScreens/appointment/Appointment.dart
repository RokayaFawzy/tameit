import 'package:flutter/material.dart';

import '../../values/values.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Appointments',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'here you can connect with your pationt',
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: "Domine",
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'select my free time',
                  style: TextStyle(
                    fontSize: 19,
                    color: AppColors.OrangePeel,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ListPatient()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Image.asset(
                    'assets/images/doc5.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'show my appointment',
                  style: TextStyle(
                    color: AppColors.OrangePeel,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RoomChat()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/images/doc2.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'join to online sessions',
                  style: TextStyle(
                    color: AppColors.OrangePeel,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RoomChat()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/images/doc6.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
