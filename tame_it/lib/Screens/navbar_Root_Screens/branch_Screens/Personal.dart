import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../values/values.dart';

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

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late Future<UserDetails> userDetails;
  bool _isLoading = true;

  final TextEditingController userNameController =
      TextEditingController(text: '');
  final TextEditingController lastNameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController countryController =
      TextEditingController(text: '');
  final TextEditingController cityController = TextEditingController(text: '');
  final TextEditingController phoneNumberController =
      TextEditingController(text: '');
  final TextEditingController birthDateController =
      TextEditingController(text: '');
  String? gender;

  @override
  void initState() {
    super.initState();
    fetchPatientDetails();
    userDetails = fetchUserDetails();
    userDetails.whenComplete(() => setState(() {
          _isLoading = false;
        }));
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

  Future<void> fetchPatientDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse(
        'https://tameit.azurewebsites.net/api/patient/getPatientDetails');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userNameController.text = data['firstName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        emailController.text = data['email'] ?? '';
        countryController.text = data['country'] ?? '';
        cityController.text = data['city'] ?? '';
        phoneNumberController.text = data['phoneNumber'] ?? '';
        birthDateController.text = data['birthDate'] ?? '';
        gender = data['gender']; // Fetch gender
      });
    } else {
      throw Exception('Failed to load patient details');
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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
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
          child: FutureBuilder<UserDetails>(
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
                                  ? NetworkImage(snapshot.data!.imageUrl!)
                                  : AssetImage('assets/images/newlogo.jpg')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    TextField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      controller: userNameController,
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
                      controller: lastNameController,
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
                      controller: emailController,
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
                      controller: phoneNumberController,
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
                      controller: countryController,
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
                      controller: cityController,
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
                        child: DropdownButton(
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
                          value: gender, // Set initial value
                          onChanged: null, // Disable the dropdown
                          items: ['FEMALE', 'MALE', null].map((valueItem) {
                            return DropdownMenuItem(
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
                        controller: birthDateController,
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
