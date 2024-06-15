import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Assuming these imports match your project structure
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../DoctorHome.dart';

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
  const SelectFreeTime({Key? key}) : super(key: key);

  @override
  State<SelectFreeTime> createState() => _SelectFreeTimeState();
}

class _SelectFreeTimeState extends State<SelectFreeTime> {
  late Future<UserDetails> userDetails;
  bool _isLoading = false;

  final List<DateTime> _dates = [DateTime.now()];
  final List<List<String>> _availableTimes = [
    ["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]
  ];
  final List<Map<String, String>> _clinicDetails = [
    {"clinicName": "", "address": "", "phoneNumber": ""}
  ];
  final List<double> _fees = [0.0]; // Using double for fees

  void _addDateTimeSection() {
    setState(() {
      _dates.add(DateTime.now());
      _availableTimes
          .add(["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]);
      _clinicDetails.add({"clinicName": "", "address": "", "phoneNumber": ""});
      _fees.add(0.0); // Initialize with 0.0
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

  void _updateClinicDetails(int index, String field, String value) {
    setState(() {
      _clinicDetails[index][field] = value;
    });
  }

  void _updateFees(int index, double value) {
    setState(() {
      _fees[index] = value;
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
        return UserDetails.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  Future<void> createAppointment(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    setState(() {
      _isLoading = true;
    });

    final body = {
      "fees": _fees[index].toString(),
      "appointmentDate": DateFormat('yyyy-MM-dd').format(_dates[index]),
      "appointmentTime": _availableTimes[index].isNotEmpty
          ? _availableTimes[index][0]
          : "", // Taking the first available time
      "clinic": _clinicDetails[index],
    };

    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/appointment/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        _showAlertDialog('Success', 'Appointment created successfully', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeDoctor()),
          );
        });
      } else {
        _showAlertDialog(
          'Error',
          'Failed to create appointment. Status code: ${response.statusCode}',
          () {},
        );
        print(
            'Failed to create appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _showAlertDialog('Error', 'Error creating appointment: $e', () {});
      print('Error creating appointment: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlertDialog(String title, String message, Function() onPressed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicField(int index) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Clinic Name',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) =>
              _updateClinicDetails(index, "clinicName", value),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Address',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) => _updateClinicDetails(index, "address", value),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Phone Number',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) =>
              _updateClinicDetails(index, "phoneNumber", value),
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
                "Fees",
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
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter Fees',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepsea),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) => _updateFees(index, double.parse(value)),
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
        Column(
          children: List.generate(1, (clinicIndex) => _buildClinicField(index)),
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
                icon: Icon(Icons.add),
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
        Wrap(
          spacing: 8.0,
          children: _availableTimes[index].map((time) {
            return Chip(
              label: Text(time),
              deleteIcon: Icon(Icons.close),
              onDeleted: () {
                _removeTime(index, time);
              },
            );
          }).toList(),
        ),
        Container(
          width: 300,
          child: CustomButton(
            color: AppColors.deepsea,
            textStyle: TextStyle(color: Colors.white, fontSize: 19),
            onPressed: () => createAppointment(index),
            title: "Save",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Stack(
        children: [
          FutureBuilder<UserDetails>(
            future: userDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No user details available'));
              } else {
                final userDetails = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        color: Colors.white,
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: userDetails.imageUrl != null
                                  ? NetworkImage(userDetails.imageUrl!)
                                  : null,
                            ),
                            title: Text(
                              userDetails.userName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepsea,
                                fontFamily: "Domine",
                              ),
                            ),
                            subtitle: Text(
                              userDetails.email,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.deepsea,
                                fontFamily: "Domine",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: AppColors.deepsea,
                        thickness: 0.1,
                        height: 8,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Choose Available time and Date",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepsea,
                                fontFamily: "Domine",
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.add, color: AppColors.deepsea),
                            onPressed: _addDateTimeSection,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: List.generate(
                            _dates.length,
                            (index) => _buildDateTimeSection(index),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepsea),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
