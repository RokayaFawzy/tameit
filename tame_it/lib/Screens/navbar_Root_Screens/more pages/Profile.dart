import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_painters.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserDetails> userDetails;

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
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 138, 125),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          drawCircles(),
          FutureBuilder<UserDetails>(
            future: userDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    const SizedBox(height: 75),
                    SizedBox(
                      height: 400,
                      child: _buildProfile(snapshot.data!),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No user data found'));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget drawCircles() {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.5, heightOfScreen * -0.19),
            radius: widthOfScreen * 0.7,
            color: const Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(UserDetails userDetails) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.black38,
          child: CircleAvatar(
            radius: 39,
            backgroundImage: userDetails.imageUrl != null
                ? NetworkImage(userDetails.imageUrl!)
                : const AssetImage('assets/images/newlogo.jpg')
                    as ImageProvider,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          userDetails.userName,
          style: const TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          userDetails.email,
          style: const TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 40),
        buildListTile(
          icon: Icons.person_outline_rounded,
          title: 'Personal info',
          onTap: () {
            Navigator.of(context).pushNamed('/PersonalInformation');
          },
        ),
        buildListTile(
          icon: Icons.medical_services_outlined,
          title: 'My appointment',
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
        buildListTile(
          icon: Icons.personal_injury_outlined,
          title: 'My doctors',
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
      ],
    );
  }

  Widget buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyShade2, width: 0.1),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.grey),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 15,
        ),
      ),
    );
  }
}

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
