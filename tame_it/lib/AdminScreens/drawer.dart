import 'package:flutter/material.dart';
import 'package:tame_it/AdminScreens/Postnotification/ListPost.dart';
import 'package:tame_it/AdminScreens/setting.dart';
import '../values/values.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'appointments/ListAppointments.dart';

class UserDetails {
  final int id;
  final String userName;
  final String email;
  final String? imageUrl;

  UserDetails({
    required this.id,
    required this.userName,
    required this.email,
    this.imageUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    int id;
    if (json.containsKey('id')) {
      id = json['id']?.toInt() ?? 0;
    } else {
      id = 0; // or any default value you prefer
    }
    return UserDetails(
      id: id,
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}

class MyDrawer extends StatefulWidget {
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

  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Future<UserDetails> userDetails;

  int _selectedIndex = 0;

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Stack(children: [
            Row(children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.black38,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.grey,
                ),
              ),
              SizedBox(width: 16),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userDetails.userName,
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(userDetails.email,
                        style: TextStyle(
                          color: AppColors.deepsea,
                          fontSize: 14,
                        ))
                  ])
            ]),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    }))
          ])),
          ListTile(
            leading: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text('Home',
                style: TextStyle(
                    color: _selectedIndex == 0
                        ? AppColors.OrangePeel
                        : AppColors.deepsea)),
            selected: _selectedIndex == 0,
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.of(context).pushNamed('/AdminHomePage');
            },
          ),
          ListTile(
            leading: Icon(Icons.person,
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Users',
              style: TextStyle(
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            selected: _selectedIndex == 1,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
              Navigator.of(context).pushNamed('/ListUsers');
            },
          ),
          ListTile(
              leading: Icon(Icons.local_hospital,
                  color: _selectedIndex == 2
                      ? AppColors.OrangePeel
                      : AppColors.deepsea),
              title: Text('Doctors',
                  style: TextStyle(
                    color: _selectedIndex == 2
                        ? AppColors.OrangePeel
                        : AppColors.deepsea,
                    fontSize: 14,
                  )),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.of(context).pushNamed('/ListDoctors');
              }),
          ListTile(
              leading: Icon(Icons.calendar_today,
                  color: _selectedIndex == 3
                      ? AppColors.OrangePeel
                      : AppColors.deepsea),
              title: Text(
                'Appointments',
                style: TextStyle(
                  color: _selectedIndex == 3
                      ? AppColors.OrangePeel
                      : AppColors.deepsea,
                  fontSize: 14,
                ),
              ),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListAllAppointments()),
                );
              }),
          ListTile(
              leading: Icon(Icons.psychology_outlined,
                  color: _selectedIndex == 4
                      ? AppColors.OrangePeel
                      : AppColors.deepsea),
              title: Text(
                'Post',
                style: TextStyle(
                  color: _selectedIndex == 4
                      ? AppColors.OrangePeel
                      : AppColors.deepsea,
                  fontSize: 14,
                ),
              ),
              selected: _selectedIndex == 4,
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPostsPage()),
                );
              }),
          const SizedBox(height: 85),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings,
                color: _selectedIndex == 5
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Settings',
              style: TextStyle(
                color: _selectedIndex == 5
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            selected: _selectedIndex == 5,
            onTap: () {
              setState(() {
                _selectedIndex = 5;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingAdmin()),
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
          ),
        ],
      ),
    );
  }
}
