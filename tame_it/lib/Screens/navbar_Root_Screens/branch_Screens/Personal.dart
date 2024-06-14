import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../values/values.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String? gender; // Nullable field
  final String city;
  final String country;
  final String birthDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.city,
    required this.country,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    String firstName = json['firstName'] ?? '';
    String lastName = json['lastName'] ?? '';
    String imageUrl = json['imageUrl'] ?? '';
    String email = json['email'] ?? '';
    String phoneNumber = json['phoneNumber'] ?? '';
    String? gender = json['gender']; // Nullable gender field
    String city = json['city'] ?? '';
    String country = json['country'] ?? '';
    String birthDate = json['birthDate'] ?? '';

    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      city: city,
      country: country,
      birthDate: birthDate,
    );
  }
}

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late Future<User> userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
  }

  Future<User> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/patient/getPatientDetails'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        return User.fromJson(responseData);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 16,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            height: 1.70,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/EditInformation');
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<User>(
            future: userDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading...'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black38,
                            child: CircleAvatar(
                              radius: 49,
                              backgroundImage: snapshot.data?.imageUrl != null
                                  ? NetworkImage(snapshot.data!.imageUrl)
                                  : AssetImage('assets/images/newlogo.jpg')
                                      as ImageProvider<Object>,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    TextField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.firstName ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 9),
                    TextField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.lastName ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 9),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.email ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 9),
                    TextField(
                      keyboardType: TextInputType.phone,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.phoneNumber ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'Phone Number',
                      ),
                    ),
                    SizedBox(height: 9),
                    TextField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.country ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'Country',
                      ),
                    ),
                    SizedBox(height: 9),
                    TextField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      controller: TextEditingController(
                          text: snapshot.data?.city ?? ''),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        hintText: 'City',
                      ),
                    ),
                    SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.only(left: 1, right: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String?>(
                          hint: Text("Select Gender"),
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          value: snapshot.data?.gender,
                          onChanged: null, // Disable the dropdown
                          items:
                              ['FEMALE', 'MALE', null].map((String? valueItem) {
                            return DropdownMenuItem<String?>(
                              value: valueItem,
                              child: Text(valueItem ?? 'Other'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: "Birth Date",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        controller: TextEditingController(
                            text: snapshot.data?.birthDate ?? ''),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
