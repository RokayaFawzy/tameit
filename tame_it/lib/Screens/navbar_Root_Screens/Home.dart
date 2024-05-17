import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/values/values.dart';
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

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => __HomeStateState();
}

class __HomeStateState extends State<Home> {
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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
            bottom: BorderSide(
              color: AppColors.whiteShade4,
              width: 1,
            ),
          ),
          title: const Text(
            'Home Page',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Profile');
                    },
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.black38,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: imageProvider,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Welcome to TAME IT',
                  style: GoogleFonts.jacquesFrancois(
                    textStyle: const TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/First Imgae.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Our Services',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Therapists');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p1.jpg',
                  title: 'Therapists',
                ),
              ),
              const SizedBox(height: 5),
              _buildServiceCard(
                image: 'assets/images/p2.jpg',
                title: 'Group Therapy',
              ),
              const SizedBox(height: 5),
              _buildServiceCard(
                image: 'assets/images/p3.jpg',
                title: 'ChatBot',
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/OnlineTherapists');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p4.jpg',
                  title: 'Online Sessions',
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Testings');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p5.jpg',
                  title: 'Testings',
                  apparent: true,
                ),
              ),
              const SizedBox(height: 200),
            ]))));
  }

  Widget _buildServiceCard({
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
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3),
              //   ),
              //  ],
            ),
            child: Row(children: [
              Container(
                  width: cardWidth * 0.3,
                  height: cardHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(15),
                      //   bottomLeft: Radius.circular(15),

                      // ),
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        height:
                            cardHeight, // Set image height to match card height
                      ))),
              SizedBox(width: cardWidth * 0.05),
              Center(
                  child: Text(title,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: AppColors.OrangePeel,
                        fontWeight: FontWeight.bold,
                      )))
            ])));
  }
}
