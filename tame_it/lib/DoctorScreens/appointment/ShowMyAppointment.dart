import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/DoctorScreens/patient/chat.dart'; // Import your chat screen if needed
import 'package:tame_it/values/values.dart';

import 'join_onlinesession.dart'; // Import your colors or other values

// UserDetails class for storing user details
class UserDetails {
  final int id;
  final String userName;
  final String? imageUrl;

  UserDetails({
    required this.userName,
    this.imageUrl,
    required this.id,
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
      imageUrl: json['imageUrl'],
    );
  }
}

class Patient {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String gender;
  final String city;
  final String country;
  final String birthDate;

  Patient({
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

  factory Patient.fromJson(Map<String, dynamic> json) {
    int id = json['id']?.toInt() ?? 0;
    return Patient(
      id: id,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      birthDate: json['birthDate'] ?? '',
    );
  }
}

// Appointment class for storing appointment details
class Appointment {
  final int id;
  final String doctorFName;
  final String doctorLName;
  final int year;
  final int monthOfYear;
  final int dayOfMonth;
  final String dayOfWeek;
  final String monthNameYear;
  final int hours;
  final int minutes;
  final String patientFName;
  final String patientLName;
  final double fees;
  final String clinicName;
  final String clinicAddress;
  final String clinicPhoneNumber;
  final bool isOnline;
  final String status;

  Appointment({
    required this.doctorFName,
    required this.doctorLName,
    required this.id,
    required this.year,
    required this.monthOfYear,
    required this.dayOfMonth,
    required this.hours,
    required this.minutes,
    required this.patientFName,
    required this.patientLName,
    required this.fees,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicPhoneNumber,
    required this.isOnline,
    required this.dayOfWeek,
    required this.monthNameYear,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    int id;
    if (json.containsKey('id')) {
      id = json['id']?.toInt() ?? 0;
    } else {
      id = 0; // or any default value you prefer
    }
    return Appointment(
      id: id,
      year: json['year'],
      monthOfYear: json['monthOfYear'],
      dayOfMonth: json['dayOfMonth'],
      hours: json['hours'],
      minutes: json['minutes'],
      patientFName: json['patientFName'] ?? '',
      patientLName: json['patientLName'] ?? '',
      fees: (json['fees'] as num?)?.toDouble() ?? 0.0,
      clinicName: json['clinicName'] ?? '',
      clinicAddress: json['clinicAddress'] ?? '',
      clinicPhoneNumber: json['clinicPhoneNumber'] ?? '',
      isOnline: json['isOnline'] ?? false,
      doctorFName: json['doctorFName'] ?? '',
      doctorLName: json['doctorLName'] ?? '',
      dayOfWeek: json['dayOfWeek'] ?? '',
      monthNameYear: json['monthNameYear'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

// ShowMyAppointment widget
class ShowMyAppointment extends StatefulWidget {
  @override
  _ShowMyAppointmentState createState() => _ShowMyAppointmentState();
}

class _ShowMyAppointmentState extends State<ShowMyAppointment> {
  late Future<UserDetails> userDetails; // Future for user details
  Future<List<Appointment>>? appointments; // Future for appointments

  final TextEditingController _dateController = TextEditingController();

  String? selectedDate; // Selected date for filtering appointments

  @override
  void initState() {
    super.initState();
    userDetails =
        fetchUserDetails(); // Fetch user details on widget initialization
  }

  // Fetch user details from SharedPreferences
  Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/user/details'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return UserDetails.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  // Fetch appointments based on selected date
  Future<List<Appointment>> fetchAppointments({String? date}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      // Construct the URL with query parameters
      Uri url = Uri.parse(
          'https://tameit.azurewebsites.net/api/appointment/readDoctorAppointments');

      Map<String, String> queryParams = {
        if (date != null && date.isNotEmpty) 'date': date,
      };

      // Append query parameters to the URL
      url = url.replace(queryParameters: queryParams);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse JSON response into List<Appointment>
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Appointment> allAppointments =
            responseData.map((data) => Appointment.fromJson(data)).toList();

        return allAppointments;
      } else {
        throw Exception(
            'Failed to load appointments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
    }
  }

  // Function to pick a date from date picker dialog
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2110),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dateController.text = selectedDate!;
        appointments = fetchAppointments(date: selectedDate);
      });
    }
  }

  // Function to navigate to session details page
  void _navigateToSession(Appointment appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourSessionPage(
          sessionTime:
              '${appointment.hours}:${appointment.minutes.toString().padLeft(2, '0')}',
          patientName:
              '${appointment.patientFName} ${appointment.patientLName}',
          fees: appointment.fees,
          isOnline: appointment.isOnline,
          clinicName: appointment.clinicName,
          clinicAddress: appointment.clinicAddress,
          clinicPhoneNumber: appointment.clinicPhoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: userDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.data != null) {
            final imageProvider = snapshot.data!.imageUrl != null
                ? NetworkImage(snapshot.data!.imageUrl!)
                : AssetImage('assets/images/newlogo.jpg');
            return buildUI(
                snapshot.data!, imageProvider as ImageProvider<Object>);
          } else {
            return Center(child: Text('User details not available'));
          }
        }
      },
    );
  }

  // Function to build the UI based on user details and appointments
  Widget buildUI(UserDetails userDetails, ImageProvider imageProvider) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Show My Appointment',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.deepsea,
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Hi Dr. ' + userDetails.userName + '!',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ))),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: imageProvider,
                  )
                ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    appointments = fetchAppointments(
                        date:
                            selectedDate); // Fetch appointments for the selected date
                  });
                },
                child: Text('Show Appointments'),
              ),
            ),
            FutureBuilder<List<Appointment>>(
              future: appointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return buildAppointmentList(snapshot.data!);
                } else {
                  return Center(child: Text('No appointments available.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to build appointment list UI
  Widget buildAppointmentList(List<Appointment> appointments) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return GestureDetector(
              onTap: () {
                _navigateToSession(appointment);
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Patient: ${appointment.patientFName} ${appointment.patientLName}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Date: ${appointment.dayOfMonth}-${appointment.monthOfYear}-${appointment.year}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Time: ${appointment.hours}:${appointment.minutes.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Clinic: ${appointment.clinicName}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Address: ${appointment.clinicAddress}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Phone: ${appointment.clinicPhoneNumber}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'is online ?: ${appointment.isOnline}',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Status: ${appointment.status}',
                                    style: TextStyle(
                                      color: appointment.status == 'Active'
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ))
                              ])))));
        });
  }
}

class YourSessionPage extends StatelessWidget {
  final String sessionTime;
  final String patientName;
  final double fees;
  final bool isOnline;
  final String? clinicName;
  final String? clinicAddress;
  final String? clinicPhoneNumber;

  const YourSessionPage({
    Key? key,
    required this.sessionTime,
    required this.patientName,
    required this.fees,
    required this.isOnline,
    this.clinicName,
    this.clinicAddress,
    this.clinicPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sessionType = isOnline ? 'online' : 'offline';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Your Session',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: AppColors.deepsea,
          ),
        ),
        body: SafeArea(
            child: ListView(shrinkWrap: true, children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                          'assets/images/userimage.jpg'), // Replace with your image asset
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                patientName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepsea,
                                ),
                              ),
                              SizedBox(width: 80),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JoinOnlineSession()),
                                  );
                                },
                                child: Icon(
                                  Icons.message,
                                  color: AppColors.deepsea,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: AppColors.deepsea,
                  thickness: 0.1,
                  height: 8,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Your Session Is At $sessionTime',
                        style: const TextStyle(
                          color: AppColors.OrangePeel,
                          fontFamily: "Domine",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Type Of Session',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'online',
                          groupValue: sessionType,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Online',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.OrangePeel),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'offline',
                          groupValue: sessionType,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Offline',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.OrangePeel),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isOnline == false)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Clinic Information',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.deepsea,
                                          fontFamily: "Domine",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Clinic Name:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.deepsea,
                                      ),
                                    ),
                                    Text(
                                      '$clinicName',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.OrangePeel,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Clinic Address:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.deepsea,
                                      ),
                                    ),
                                    Text(
                                      '$clinicAddress',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.OrangePeel,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Clinic Phone Number:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.deepsea,
                                        ),
                                      ),
                                      Text(' $clinicPhoneNumber',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.OrangePeel,
                                          ))
                                    ])
                              ])),
                      SizedBox(height: 20),
                    ],
                  ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.deepsea,
                                fontFamily: "Domine",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$fees',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.deepsea,
                                fontFamily: "Domine",
                                fontWeight: FontWeight.bold),
                          )
                        ]))
              ]))
        ])));
  }
}
