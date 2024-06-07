import 'package:flutter/material.dart';
import 'package:tame_it/DoctorScreens/patient/ListPatient.dart';
import 'package:tame_it/DoctorScreens/patient/ViewRoomChat.dart';

import '../../values/values.dart';

class Patients extends StatelessWidget {
  const Patients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Patients',
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
                      fontSize: 22,
                      color: AppColors.OrangePeel,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'View My Patient',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Domine",
                    color: AppColors.deepsea,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListPatient()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Image.asset(
                    'assets/images/doc3.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'View My Chat',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontFamily: "Domine",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomChat()),
                  );},
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/images/doc4.png',
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
