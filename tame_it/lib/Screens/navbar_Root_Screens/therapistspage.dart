import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import '../../Models/Doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/custom_card.dart';

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



class Therapists extends StatefulWidget {
  
  const Therapists({super.key});

  @override
  State<Therapists> createState() => __TherapistsStateState();
}

class __TherapistsStateState extends State<Therapists> {
  late Future<UserDetails> userDetails;
  List<Doctor> doctors = [];
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
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

  Future<void> searchDoctors(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/byName'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": query,
          "lastName": query,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          doctors = responseData.map((json) => Doctor.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Failed to search doctors. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error searching doctors: $e';
      });
    }
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
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        body: DefaultTabController(
            length: 2,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              ListView(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: widthOfScreen * 0.1,
                    right: widthOfScreen * 0.3,
                  ),
                ),
                SizedBox(
                  height: (heightOfScreen * 0.01),
                ),
                Container(
                  height: heightOfScreen,
                  child: _buildMyTherapy(),
                )
              ])
            ]))));
  }

//Our Therapists
  Widget _buildMyTherapy() {
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
              bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          )),
          title: const Text('Our Therapists',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          iconTheme: const IconThemeData(color: AppColors.deepsea),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Profile');
                      },
                      child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.black38,
                          child: FutureBuilder<UserDetails>(
                              future: userDetails,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // or any loading indicator
                                } else if (snapshot.hasError) {
                                  return const Icon(
                                      Icons.error); // handle error
                                } else {
                                  return CircleAvatar(
                                    radius: 16,
                                    backgroundImage: snapshot.data!.imageUrl !=
                                            null
                                        ? NetworkImage(snapshot.data!.imageUrl!)
                                        : AssetImage(
                                                'assets/images/newlogo.jpg')
                                            as ImageProvider, // Change this line
                                  );
                                }
                              }))))
            ])
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                        child: TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Therapist Name or interest',
                                hintStyle: const TextStyle(
                                    color: AppColors.greyShade7, fontSize: 15),
                                prefixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: AppColors.greyShade7,
                                    ),
                                    onPressed: () {
                                  searchDoctors(_searchController.text);
                                    }),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () => _searchController.clear(),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))))
                  ])),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(children: [
                        Container(
                            width: widthOfScreen * 0.45,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                        const BorderSide(
                                            color: AppColors.deepsea,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    shape: const WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ))),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.tune,
                                        color: AppColors.deepsea,
                                        size: 20,
                                      ),
                                      Text(' Filter by',
                                          style: TextStyle(
                                            color: AppColors.deepsea,
                                          ))
                                    ]),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/FiltersScreen');
                                }))
                      ])),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(children: [
                        Container(
                            width: widthOfScreen * 0.45,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                        const BorderSide(
                                            color: AppColors.deepsea,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    shape: const WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ))),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.swap_vert,
                                        color: AppColors.deepsea,
                                        size: 20,
                                      ),
                                      Text(' Sort by',
                                          style: TextStyle(
                                            color: AppColors.deepsea,
                                          ))
                                    ]),
                                onPressed: _showMultiSelect))
                      ]))
                ],
              ),
              SizedBox(
                height: 12,
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
                                        child: DoctorCard(
                                          doctor: doctor,
                                         
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
                                ),        const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

//Sorted by page
  String _selectedItem = ''; // Declaration and initialization of _selectedItem

  void _showMultiSelect() {
    final List<String> items = [
      'Price: low to high',
      'Price: high to low',
      'Customer rating',
      'Most popular'
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Sorting By",
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Domine',
                  )),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                for (String item in items)
                  RadioListTile<String>(
                      title: Text(item,
                          style: TextStyle(color: AppColors.deepsea)),
                      value: item,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                        Navigator.pop(context);
                      },
                      activeColor: AppColors.OrangePeel)
              ]),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.OrangePeel),
                    child: Text('Cancel'))
              ]);
        });
  }
}
