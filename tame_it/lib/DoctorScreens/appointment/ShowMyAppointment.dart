import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/DoctorScreens/appointment/Your_Session.dart';

import '../../values/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetails {
  final String userName;
  final String email;
  final String? imageUrl;

  UserDetails({
    required this.userName,
    required this.email,
    this.imageUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}

class ShowMyAppointment extends StatefulWidget {
  const ShowMyAppointment({super.key});

  @override
  State<ShowMyAppointment> createState() => _ShowMyAppointmentState();
}

class _ShowMyAppointmentState extends State<ShowMyAppointment> {
  late Future<UserDetails> userDetails;

  final TextEditingController _dateController = TextEditingController();
  final List<String> _sessionTimes = [
    "10:00 AM",
    "1:00 PM",
    "3:00 PM",
    "5:00 PM"
  ];

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
  }

  Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/userDetails'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserDetails.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2110),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _navigateToSession(String time) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourSessionPage(sessionTime: time),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: userDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data != null) {
            final imageProvider = snapshot.data!.imageUrl != null
                ? NetworkImage(snapshot.data!.imageUrl!)
                : const AssetImage('assets/images/newlogo.jpg');
            return buildUI(
                snapshot.data!, imageProvider as ImageProvider<Object>);
          } else {
            return Text('User details not available');
          }
        }
      },
    );
  }

  Widget _buildClinicField(int index) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Clinic Name',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Address',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Phone Number',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUI(UserDetails userDetails, ImageProvider imageProvider) {
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
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Hi Dr. ' + userDetails.userName,
                      style: TextStyle(
                          fontSize: 23,
                          color: AppColors.OrangePeel,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Choose Date  to know your appointment',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose date',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 13),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today_rounded),
                              onPressed: _pickDate,
                            ),
                            labelText: "Select Date",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Row(
                            children: [
                              Text(
                                "Fees",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepsea,
                                  fontFamily: "Domine",
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Fees Is ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.deepsea),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Row(
                            children: [
                              Text(
                                "Clinic",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepsea,
                                  fontFamily: "Domine",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                              1, (clinicIndex) => _buildClinicField(2)),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'You Have Session At',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: _sessionTimes.map((time) {
                            bool isSpecialTime =
                                time == "1:00 PM" || time == "3:00 PM";
                            return GestureDetector(
                              onTap: () => _navigateToSession(time),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSpecialTime
                                      ? AppColors.deepsea.withOpacity(0.5)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.deepsea),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
