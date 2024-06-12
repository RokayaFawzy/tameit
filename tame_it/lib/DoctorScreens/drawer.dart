import 'package:flutter/material.dart';
import 'package:tame_it/DoctorScreens/setting.dart';
import '../values/values.dart';
import 'appointment/Appointment.dart';
import 'patient/Patients.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class DrawerDoctor extends StatefulWidget {
  Future<void> _logout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (BuildContext context) {
        return AbsorbPointer(
          absorbing: true,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/logout'),
        // Optionally, add headers or body parameters here
      );

      if (response.statusCode == 204) {
        // Logout successful, navigate to the login screen
        Navigator.of(context).pushReplacementNamed('/Login');
      } else {
        // Handle other status codes (e.g., 401 for unauthorized)
        print('Logout failed with status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Logout failed with status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: $e'),
        ),
      );
    }
  }

  @override
  _DrawerDoctorState createState() => _DrawerDoctorState();
}

class _DrawerDoctorState extends State<DrawerDoctor> {
  late Future<UserDetails> userDetails;

  int _selectedIndex = -1; // -1 means no item is selected

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
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            // decoration: BoxDecoration(
            //   color: AppColors.deepsea,
            // ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: AppColors.deepsea),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: imageProvider,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userDetails.userName,
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            userDetails.email,
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined,
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Home',
              style: TextStyle(
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury_outlined,
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Patients',
              style: TextStyle(
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Patients()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services_outlined,
                color: _selectedIndex == 2
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Appointments',
              style: TextStyle(
                color: _selectedIndex == 2
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Appointment()),
              ); // Add navigation logic here
            },
          ),
          Spacer(), // Pushes the remaining items to the bottom
          Divider(),
          ListTile(
            leading: Icon(Icons.settings_outlined,
                color: _selectedIndex == 3
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Settings',
              style: TextStyle(
                color: _selectedIndex == 3
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingDoctor()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () =>
                  widget._logout(context), // Call widget._logout when tapped
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout, color: AppColors.deepsea),
                  SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 3),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
