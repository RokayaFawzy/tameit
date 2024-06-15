import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/AdminScreens/doctor/ListDoctors.dart';
import 'package:tame_it/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';

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

class SelectFreeTime extends StatefulWidget {
  const SelectFreeTime({super.key});

  @override
  State<SelectFreeTime> createState() => _SelectFreeTimeState();
}

class _SelectFreeTimeState extends State<SelectFreeTime> {
  late Future<UserDetails> userDetails;

  final List<DateTime> _dates = [DateTime.now()];
  final List<List<String>> _availableTimes = [
    ["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]
  ];

  void _addDateTimeSection() {
    setState(() {
      _dates.add(DateTime.now());
      _availableTimes
          .add(["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]);
    });
  }

  void _updateDate(int index, DateTime date) {
    setState(() {
      _dates[index] = date;
    });
  }

  void _addTime(int index, String time) {
    setState(() {
      _availableTimes[index].add(time);
    });
  }

  void _removeTime(int index, String time) {
    setState(() {
      _availableTimes[index].remove(time);
    });
  }

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

  Widget _buildClinicField(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Clinic',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
        ),
        CustomTextFormField(
          hintText: 'Clinic Name',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
        CustomTextFormField(
          hintText: 'Address',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
        CustomTextFormField(
          hintText: 'Phone Number',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection(int index) {
    TextEditingController _dateController = TextEditingController();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_dates[index]);

    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Row(
            children: [
              Text(
                "Choose Date",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                  fontFamily: "Domine",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _dateController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today_rounded),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dates[index],
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2110),
                  );
                  if (pickedDate != null) {
                    _updateDate(index, pickedDate);
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              labelText: "Select Date",
            ),
            readOnly: true,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Row(
            children: [
              Text(
                "fees",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                  fontFamily: "Domine",
                ),
              ),
            ],
          ),
        ),
        CustomTextFormField(
          hintText: 'fees',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Row(
            children: [
              Text(
                "Clinic",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                  fontFamily: "Domine",
                ),
              ),
            ],
          ),
        ),
        // Add clinic fields here
        Column(
          children: List.generate(1, (index) => _buildClinicField(index)),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                "Available Time",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Domine",
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add, color: AppColors.deepsea),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController _timeController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text("Add Time"),
                        content: TextField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            labelText: "Enter Time (e.g., 10:00 AM)",
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_timeController.text.isNotEmpty) {
                                _addTime(index, _timeController.text);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 2.0,
          runSpacing: 2.0,
          children: _availableTimes[index].map((time) {
            return Chip(
              label: Text(time),
              onDeleted: () {
                _removeTime(index, time);
              },
            );
          }).toList(),
        ),
      ],
    );
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Select Free Time',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: imageProvider,
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userDetails.userName,
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  userDetails.email,
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
                  SizedBox(height: 10),
                  const Divider(
                    color: AppColors.deepsea,
                    thickness: 0.1,
                    height: 8,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          "Choose Available time and Date",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.add, color: AppColors.deepsea),
                          onPressed: _addDateTimeSection,
                        ),
                      ],
                    ),
                  ),
                  ..._dates.asMap().entries.map((entry) {
                    int index = entry.key;
                    return _buildDateTimeSection(index);
                  }).toList(),
                  SizedBox(
                    height: 190,
                  ),
                  Container(
                    width: 330,
                    child: CustomButton(
                      title: "Done",
                      color: AppColors.deepsea,
                      textStyle:
                          TextStyle(color: AppColors.white, fontSize: 19),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
