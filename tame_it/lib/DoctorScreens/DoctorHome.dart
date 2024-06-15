import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/DoctorScreens/drawer.dart';
import '../values/values.dart';
import 'appointment/Appointment.dart';
import 'patient/Patients.dart';

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

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({super.key});

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  late Future<UserDetails> userDetails;
  bool _isLoading = false;

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
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/userDetails'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        return UserDetails.fromJson(responseData);
      } else {
        print(
            'Failed to load user details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      throw Exception('Error fetching user details');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

  Widget buildUI(UserDetails userDetails, ImageProvider imageProvider) {
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
      body: Stack(
        children: [
          SafeArea(
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
                        'Hi Doctor ' + userDetails.userName,
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepsea),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
