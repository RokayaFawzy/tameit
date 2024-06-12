import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tame_it/AdminScreens/doctor/AdminDoctorCard.dart';
import 'package:tame_it/values/values.dart';

class UserDetails {}

class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final int rating;
  final int price;
  final int yearsOfExperience;
  final List<String> specializations;
  final String imageUrl;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.rating,
    required this.price,
    required this.yearsOfExperience,
    required this.specializations,
    required this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    List<dynamic> specializationsJson = json['specializations'];
    List<String> specializations = specializationsJson
        .map((spec) => spec['specializationName'].toString())
        .toList();
    int id;
    if (json.containsKey('id')) {
      id = json['id']?.toInt() ?? 0;
    } else {
      id = 0; // or any default value you prefer
    }
    return Doctor(
      id: id,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      rating: json['rating'] ?? 0,
      price: json['price'] ?? 0,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      specializations: specializations,
      imageUrl: json['imageUrl'],
    );
  }
}

class ListDoctors extends StatefulWidget {
  const ListDoctors({Key? key}) : super(key: key);

  @override
  State<ListDoctors> createState() => _ListDoctorsState();
}

class _ListDoctorsState extends State<ListDoctors> {
  List<Doctor> doctors = [];
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllDoctors();
  }

  Future<void> fetchAllDoctors() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/getAllDoctors'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          doctors = responseData.map((json) => Doctor.fromJson(json)).toList();
          isLoading = false;
        });
        print('Response Body: ${response.body}');
        print('List of Doctors:');
        doctors.forEach((doctor) {
          print('id: ${doctor.id}');
          print('First Name: ${doctor.firstName}');
          print('Last Name: ${doctor.lastName}');
          print('Job Title: ${doctor.jobTitle}');
          print('Rating: ${doctor.rating}');
          print('Price: ${doctor.price}');
          print('Years of Experience: ${doctor.yearsOfExperience}');
          print('Specializations: ${doctor.specializations}');
          print('imageUrl: ${doctor.imageUrl}');
          print('------------------------');
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Failed to load doctors. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching doctors: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

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
          'Our Therapists',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Therapist Name or interest',
                              hintStyle: const TextStyle(
                                color: AppColors.greyShade7,
                                fontSize: 15,
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.greyShade7,
                                ),
                                onPressed: () {
                                  // Perform the search here
                                },
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => _searchController.clear(),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: widthOfScreen * 0.45,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          side: WidgetStateProperty.all(
                            const BorderSide(
                              color: AppColors.deepsea,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.deepsea,
                              size: 20,
                            ),
                            Text(
                              ' Add Doctor',
                              style: TextStyle(
                                color: AppColors.deepsea,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/AddDoctorAdmin');
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : doctors.isEmpty
                              ? Center(
                                  child: Text('No doctors available.'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: doctors.length,
                                  itemBuilder: (context, index) {
                                    final doctor = doctors[index];
                                    if (doctor != null) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: AdminDoctorCard(
                                          doctor: doctor,
                                          onDelete: (id) {
                                            // Handle onDelete callback here
                                            print('Delete Doctor with ID: $id');
                                            // Call the function to delete the doctor with the provided ID
                                          },
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          'Error: Doctor data is null',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }
                                  },
                                ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
