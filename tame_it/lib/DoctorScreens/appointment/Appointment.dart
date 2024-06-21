import 'package:flutter/material.dart';
import 'package:tame_it/DoctorScreens/appointment/ShowMyAppointment.dart';
import 'package:tame_it/DoctorScreens/appointment/join_onlinesession.dart';
import 'package:tame_it/DoctorScreens/appointment/select_free_time.dart';
import '../../values/values.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  Widget _buildServiceCard({
    required BuildContext context,
    required String image,
    required String title,
    bool apparent = false,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final cardHeight = screenSize.height * 0.15;
    final cardWidth = screenSize.width * 0.9;

    return Center(
        child: Container(
            width: cardWidth,
            height: cardHeight,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(children: [
              Container(
                width: cardWidth * 0.3,
                height: cardHeight,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: cardHeight, // Set image height to match card height
                  ),
                ),
              ),
              SizedBox(width: cardWidth * 0.05),
              Center(
                  child: Text(title,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.045,
                        color: AppColors.OrangePeel,
                        fontWeight: FontWeight.bold,
                      )))
            ])));
  }

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
                  'Here you can connect with your patient',
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: "Domine",
                    color: AppColors.deepsea,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectFreeTime()),
                  );
                },
                child: _buildServiceCard(
                  context: context,
                  image: 'assets/images/doc5.png',
                  title: 'Select My Free Time',
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowMyAppointment()),
                  );
                },
                child: _buildServiceCard(
                  context: context,
                  image: 'assets/images/doc2.png',
                  title: 'Show My Appointment',
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JoinOnlineSession()),
                    );
                  },
                  child: _buildServiceCard(
                    context: context,
                    image: 'assets/images/doc6.png',
                    title: 'Join Online Sessions',
                  ))
            ]))));
  }
}
