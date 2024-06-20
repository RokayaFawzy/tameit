import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/chat_doctor.dart';
import '../../../values/values.dart';

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

class MyDoctor extends StatefulWidget {
  const MyDoctor({Key? key}) : super(key: key);

  @override
  State<MyDoctor> createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url =
          Uri.parse('https://tameit.azurewebsites.net/api/patient/myDoctors');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Doctor> fetchedDoctors =
            data.map((json) => Doctor.fromJson(json)).toList();

        setState(() {
          doctors = fetchedDoctors;
        });
      } else {
        // Handle error
        print('Failed to load doctors: ${response.statusCode}');
      }
    } else {
      // Handle case where token is null (not logged in?)
      print('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My doctor',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            Doctor doctor = doctors[index];
            return Column(
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "The doctors with whom I have booked appointments :",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: fontSize,
                            fontFamily: "Domine",
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                PastAppointment(doctor: doctor),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PastAppointment extends StatelessWidget {
  final Doctor doctor;

  const PastAppointment({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(doctor.imageUrl),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${doctor.firstName} ${doctor.lastName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor.specializations.join(', '),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 14),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${doctor.price}' + ' EGP',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Domine",
                      color: AppColors.deepsea,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 4),
                  Text(
                    doctor.rating.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: screenWidth * 0.3,
              margin: const EdgeInsets.all(11),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.deepsea,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatDoctorPage(doctorId: doctor.id)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.question_answer_outlined,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'send message',
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.deepsea,
          thickness: 0.1,
          height: 9,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
