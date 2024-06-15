import 'package:flutter/material.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/BookingPage.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/chat_doctor.dart';
import 'package:tame_it/values/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../widgets/custom_text_form_field.dart';

class Clinic {
  final String clinicName;
  final String address;
  final String phoneNumber;

  Clinic({
    required this.clinicName,
    required this.address,
    required this.phoneNumber,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      clinicName: json['clinicName'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicName': clinicName,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
}

class Details {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String? gender;
  final String jobTitle;
  final int price;
  final List<String> specializations;
  final List<Clinic> clinics;
  final int yearsOfExperience;
  final int rating;
  final String about;
  final String phoneNumber;

  Details({
    required this.clinics,
    required this.about,
    required this.phoneNumber,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.gender,
    required this.jobTitle,
    required this.rating,
    required this.price,
    required this.yearsOfExperience,
    required this.specializations,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    List<dynamic> specializationsJson = json['specializations'];
    List<String> specializations = specializationsJson
        .map((spec) => spec['specializationName'].toString())
        .toList();
    List<dynamic> clinicsJson = json['clinics'];
    List<Clinic> clinics =
        clinicsJson.map((clinic) => Clinic.fromJson(clinic)).toList();
    int id = json['id'] ?? 0;
    String firstName = json['firstName'] ?? '';
    String lastName = json['lastName'] ?? '';
    String imageUrl = json['imageUrl'] ?? '';
    String? gender = json['gender'];
    String jobTitle = json['jobTitle'] ?? '';
    int rating = json['rating'] ?? 0;
    int price = json['price'] ?? 0;
    int yearsOfExperience = json['yearsOfExperience'] ?? 0;
    String about = json['about'] ?? '';
    String phoneNumber = json['phoneNumber'] ?? '';

    return Details(
      id: id,
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
      gender: gender,
      jobTitle: jobTitle,
      specializations: specializations,
      rating: rating,
      price: price,
      yearsOfExperience: yearsOfExperience,
      clinics: clinics,
      about: about,
      phoneNumber: phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'gender': gender,
      'jobTitle': jobTitle,
      'price': price,
      'specializations': specializations,
      'clinics': clinics.map((clinic) => clinic.toJson()).toList(),
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'about': about,
      'phoneNumber': phoneNumber,
    };
  }
}

class DoctorDetails extends StatefulWidget {
  final int doctorId;

  const DoctorDetails({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late Future<Details> _detailsFuture;

  @override
  void initState() {
    super.initState();
    _detailsFuture = _fetchDoctorDetails(widget.doctorId);
  }

  Future<Details> _fetchDoctorDetails(int doctorId) async {
    final response = await http.get(Uri.parse(
        'https://tameit.azurewebsites.net/api/auth/doctorCard/$doctorId'));

    if (response.statusCode == 200) {
      return Details.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load doctor details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: Text(
          'Therapist Profile',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: FutureBuilder<Details>(
        future: _detailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final details = snapshot.data!;
            return _buildDoctorDetails(details);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentBooking()),
                    );
                  },
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepsea,
                    side: BorderSide(
                      color: AppColors.deepsea,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorDetails(Details details) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: _MySliverAppBar(
                expandedHeight: 250.0,
                imageUrl: details.imageUrl,
              ),
              floating: false,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(top: 16.0, left: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. ${details.firstName} ${details.lastName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: AppColors.deepsea,
                                    ),
                                  ),
                                  Text(details.jobTitle),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatDoctorPage()),
                                );
                              },
                              child: Icon(
                                Icons.message,
                                color: AppColors.deepsea,
                              ),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Text('Patients'),
                            SizedBox(width: 45),
                            Text('Experience'),
                            SizedBox(width: 45),
                            Text('Rating'),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('1.4K',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 90),
                            Text('${details.yearsOfExperience} yr',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 70),
                            Text('${details.rating}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Specialties',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 7),
                        Wrap(
                          spacing: 10, // Adjust the spacing as needed
                          children: details.specializations.map((spec) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                                color: AppColors.greyShade5,
                              ),
                              child: Text(
                                spec,
                                style: TextStyle(
                                  color: AppColors.deepsea,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'About',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            details.about,
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Clinics',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                        ...details.clinics
                            .map((clinic) => _buildClinicFieldSet(clinic))
                            .toList(),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClinicFieldSet(Clinic clinic) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Clinic Name :-',
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: AppColors.greyShade5,
              ),
              child: Text(
                clinic.clinicName,
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Clinic Location :-',
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: AppColors.greyShade5,
              ),
              child: Text(
                clinic.address,
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Clinic Number :-',
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: AppColors.greyShade5,
              ),
              child: Text(
                clinic.phoneNumber,
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
      ],
    );
  }
}

class _MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String imageUrl;

  _MySliverAppBar({required this.expandedHeight, required this.imageUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(_MySliverAppBar oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        imageUrl != oldDelegate.imageUrl;
  }
}
