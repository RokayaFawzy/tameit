import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Ensure you have AppColors defined in values.dart file
import '../../values/values.dart';

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

class ListPatient extends StatefulWidget {
  const ListPatient({Key? key}) : super(key: key);

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  final TextEditingController _searchController = TextEditingController();
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url =
          Uri.parse('https://tameit.azurewebsites.net/api/doctor/myPatients');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Patient> fetchedPatients =
            data.map((json) => Patient.fromJson(json)).toList();

        setState(() {
          patients = fetchedPatients;
          filteredPatients = patients;
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load patients: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Handle case where token is null (not logged in?)
      print('Token not found');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterPatients(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPatients = patients;
      });
    } else {
      setState(() {
        filteredPatients = patients
            .where((patient) =>
                '${patient.firstName} ${patient.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                patient.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text(
          'List Patients',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Find Patient',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: _filterPatients,
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        Patient patient = filteredPatients[index];
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.close,
                                          color: AppColors.deepsea),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              NetworkImage(patient.imageUrl),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${patient.firstName} ${patient.lastName}',
                                              style: TextStyle(
                                                color: AppColors.deepsea,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              patient.email,
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
                            Divider(),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
