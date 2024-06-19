import 'package:flutter/material.dart';
import '../../../Models/Doctor_model.dart';
import '../../values/values.dart';
import 'appointmentsCard.dart';

class ListAllAppointments extends StatefulWidget {
  const ListAllAppointments({super.key});

  @override
  State<ListAllAppointments> createState() => __ListAllAppointmentsStateState();
}

class __ListAllAppointmentsStateState extends State<ListAllAppointments> {
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        body: DefaultTabController(
            length: 2,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              ListView(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: widthOfScreen * 0.1,
                    right: widthOfScreen * 0.3,
                  ),
                ),
                SizedBox(
                  height: (heightOfScreen * 0.01),
                ),
                Container(
                  height: heightOfScreen,
                  child: _buildMyTherapy(),
                )
              ])
            ]))));
  }

  Widget _buildMyTherapy() {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
              bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          )),
          title: const Text('All Appointments',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AppointmentsCard(
                        doctor: Doctor(
                      firstName: 'DR.Smith',
                      specialty: 'Psychologist',
                      rating: 5,
                      lastName: ' Wilson',
                      price: '800',
                      experienceYears: '24 yr',
                      interest: 'Depression, Stress, Anxiety',
                      image: 'assets/images/123.jpg',
                      id: 5,
                    )));
              }),
          const SizedBox(height: 200),
        ]))));
  }
}
