import 'package:flutter/material.dart';

import '../../values/values.dart';

class ShowMyAppointment extends StatefulWidget {
  const ShowMyAppointment({super.key});

  @override
  State<ShowMyAppointment> createState() => _ShowMyAppointmentState();
}

class _ShowMyAppointmentState extends State<ShowMyAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Show My Appointment',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
