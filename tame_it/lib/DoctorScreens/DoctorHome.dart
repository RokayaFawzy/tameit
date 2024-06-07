import 'package:flutter/material.dart';
import 'package:tame_it/DoctorScreens/drawer.dart';
import '../values/values.dart';
import 'appointment/Appointment.dart';
import 'patient/Patients.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({super.key});

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text(
          'Home',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      drawer: DrawerDoctor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Welcome to TAME IT !',
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.deepsea,
                        fontFamily: "RobotoSlab",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Hi Doctor ' + 'Sara  ',
                    style: TextStyle(
                        fontSize: 22,
                        // color: AppColors.deepsea,
                        fontFamily: "Domine",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 19.0),
                child: Text(
                  'To interact With Patients',
                  style: TextStyle(
                    color: AppColors.OrangePeel,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Patients()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/images/doc1.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 19.0),
                child: Text(
                  'To Show My Appointments',
                  style: TextStyle(
                    color: AppColors.OrangePeel,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Appointment()),
                  );
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
            ],
          ),
        ),
      ),
    );
  }
}
