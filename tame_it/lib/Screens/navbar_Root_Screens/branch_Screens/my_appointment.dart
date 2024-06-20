import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/chat_doctor.dart';

// Replace these with actual values from your design or constants file
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

class MyAppointments extends StatefulWidget {
  const MyAppointments({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  late List<Appointment> upcomingAppointments;
  late List<Appointment> pastAppointments;
  bool isLoading = true;
  List<Doctor> doctors = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
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

  Future<void> fetchAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Handle token not found case
      return;
    }

    String apiUrl =
        'https://tameit.azurewebsites.net/api/appointment/readPatientAppointments';

    try {
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        // Successful API call
        List<dynamic> parsedAppointments = jsonDecode(response.body);
        List<Appointment> fetchedAppointments = parsedAppointments
            .map((json) => Appointment.fromJson(json))
            .toList();

        // Categorize appointments into upcoming and past based on date
        DateTime now = DateTime.now();
        upcomingAppointments = fetchedAppointments.where((appointment) {
          DateTime appointmentDate = DateTime(
            appointment.year,
            appointment.monthOfYear,
            appointment.dayOfMonth,
          );
          return appointmentDate.isAfter(now);
        }).toList();

        pastAppointments = fetchedAppointments.where((appointment) {
          DateTime appointmentDate = DateTime(
            appointment.year,
            appointment.monthOfYear,
            appointment.dayOfMonth,
          );
          return appointmentDate.isBefore(now);
        }).toList();

        setState(() {
          isLoading = false;
        });
      } else {
        // Handle error case
        print('Failed to load appointments: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle network error
      print('Error fetching appointments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        shadowColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upcoming Appointments",
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontSize: 16,
                            fontFamily: "Domine",
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ...upcomingAppointments.map((appointment) {
                        //TODO: Doing red error then disappear
                        // Doctor doctor = doctors.firstWhere((doc) =>
                        //     doc.firstName == appointment.doctorFName &&
                        //     doc.lastName == appointment.doctorLName);
                        return AppointmentCard(
                          appointment: appointment,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           ChatDoctorPage(doctorId: doctor.id)),
                            // );
                          },
                        );
                      }).toList(),
                      const Divider(
                        color: AppColors.deepsea,
                        thickness: 0.4,
                        indent: 15,
                        endIndent: 15,
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Past Appointments",
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontSize: 16,
                            fontFamily: "Domine",
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ...pastAppointments.map((appointment) {
                        //TODO: Doing red error then disappear
                        // Doctor doctor = doctors.firstWhere((doc) =>
                        //     doc.firstName == appointment.doctorFName &&
                        //     doc.lastName == appointment.doctorLName);

                        return AppointmentCard(
                          appointment: appointment,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           ChatDoctorPage(doctorId: doctor.id)),
                            // );
                          },
                        );
                      }).toList(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;

  const AppointmentCard({
    required this.appointment,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.deepsea),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateWidget(
                monthNameYear: appointment.monthNameYear,
                dayOfMonth: appointment.dayOfMonth.toString(),
                hours: appointment.hours.toString(),
                minutes: appointment.minutes.toString(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrCardUpcoming(
                      doctorFName: appointment.doctorFName,
                      doctorLName: appointment.doctorLName,
                      clinicName: appointment.clinicName,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointment.status,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.OrangePeel,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.3,
                          margin: const EdgeInsets.all(2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.OrangePeel,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: onTap,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.question_answer_outlined,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Chat',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final String monthNameYear;
  final String dayOfMonth;
  final String hours;
  final String minutes;

  const DateWidget({
    required this.monthNameYear,
    required this.dayOfMonth,
    required this.hours,
    required this.minutes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width * 0.3;

    return Container(
      width: containerSize,
      height: containerSize,
      padding: const EdgeInsets.all(5),
      child: Container(
        color: AppColors.deepsea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            Flexible(
              child: Text(
                monthNameYear.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                dayOfMonth,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.50,
                  fontFamily: "Domine",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Flexible(
              child: Text(
                'at $hours:$minutes',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrCardUpcoming extends StatelessWidget {
  final String doctorFName;
  final String doctorLName;
  final String clinicName;

  const DrCardUpcoming({
    required this.doctorFName,
    required this.doctorLName,
    required this.clinicName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/123.jpg'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. $doctorFName $doctorLName",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "ClinicName :" + clinicName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 14), // Adjust spacing
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.deepsea,
                ),
              ),
              const SizedBox(height: 20), // Adjust spacing
            ],
          ),
        ],
      ),
    );
  }
}

class Appointment {
  final String doctorFName;
  final String doctorLName;
  final String clinicName;
  final int dayOfMonth;
  final String dayOfWeek;
  final int monthOfYear;
  final String monthNameYear;
  final int year;
  final int hours;
  final int minutes;
  final String status;
  final double fees;

  Appointment({
    required this.doctorFName,
    required this.doctorLName,
    required this.clinicName,
    required this.dayOfMonth,
    required this.dayOfWeek,
    required this.monthOfYear,
    required this.monthNameYear,
    required this.year,
    required this.hours,
    required this.minutes,
    required this.status,
    required this.fees,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorFName: json['doctorFName'],
      doctorLName: json['doctorLName'],
      clinicName: json['clinicName'],
      dayOfMonth: json['dayOfMonth'],
      dayOfWeek: json['dayOfWeek'],
      monthOfYear: json['monthOfYear'],
      monthNameYear: json['monthNameYear'],
      year: json['year'],
      hours: json['hours'],
      minutes: json['minutes'],
      status: json['status'],
      fees: json['fees'].toDouble(),
    );
  }
}
// Adjust spacing
