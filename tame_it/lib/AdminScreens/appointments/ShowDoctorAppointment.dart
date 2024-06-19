import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tame_it/values/values.dart';
import 'dart:convert';

import '../adminhome.dart'; // Adjust the path as per your project structure

// Model classes for user details and appointments
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
    required this.id,
    required this.doctorFName,
    required this.doctorLName,
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
    return Appointment(
      id: json['id'],
      doctorFName: json['doctorFName'],
      doctorLName: json['doctorLName'],
      year: json['year'],
      monthOfYear: json['monthOfYear'],
      dayOfMonth: json['dayOfMonth'],
      hours: json['hours'],
      minutes: json['minutes'],
      patientFName: json['patientFName'] ?? '',
      patientLName: json['patientLName'] ?? '',
      fees: json['fees']?.toDouble() ?? 0.0,
      clinicName: json['clinicName'] ?? '',
      clinicAddress: json['clinicAddress'] ?? '',
      clinicPhoneNumber: json['clinicPhoneNumber'] ?? '',
      isOnline: json['isOnline'] ?? false,
      dayOfWeek: json['dayOfWeek'] ?? '',
      monthNameYear: json['monthNameYear'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ShowDoctorAppointments extends StatefulWidget {
  final int doctorId;

  const ShowDoctorAppointments({Key? key, required this.doctorId})
      : super(key: key);

  @override
  State<ShowDoctorAppointments> createState() => _ShowDoctorAppointmentsState();
}

class _ShowDoctorAppointmentsState extends State<ShowDoctorAppointments> {
  late Future<List<Appointment>> appointments;

  @override
  void initState() {
    super.initState();
    appointments = fetchAppointments();
  }

  Future<List<Appointment>> fetchAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/appointment/readDoctorAppointments/${widget.doctorId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Appointment> appointments = data
            .map((appointmentJson) => Appointment.fromJson(appointmentJson))
            .toList();

        return appointments;
      } else {
        throw Exception(
            'Failed to load appointments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
    }
  }

  Future<void> deleteAppointment(Appointment appointment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.delete(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/appointment/delete/${appointment.id}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Appointment Deleted'),
              content: Text('Appointment deleted successfully.'),
              actions: <Widget>[
                TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the alert dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminHomePage()),
                      );
                    }),
              ],
            );
          },
        );

        appointments = fetchAppointments();
        setState(() {});
      } else {
        throw Exception(
            'Failed to delete appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointments',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: FutureBuilder<List<Appointment>>(
        future: appointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No appointments available'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'All Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: snapshot.data!
                        .map((appointment) => AppointmentCard(
                              appointment: appointment,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorSessionScreen(
                                      appointment: appointment,
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                deleteAppointment(appointment);
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No appointments available'));
          }
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${appointment.dayOfWeek}, ${appointment.monthNameYear} ${appointment.dayOfMonth}, ${appointment.year} - ${appointment.hours}:${appointment.minutes > 9 ? appointment.minutes : '0${appointment.minutes}'}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onDelete,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              appointment.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                color: appointment.isOnline ? Colors.green : Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appointment.status == 'BOOKED' ? 'Booked' : 'Available',
              style: TextStyle(
                color:
                    appointment.status == 'BOOKED' ? Colors.green : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Patient: ${appointment.patientFName} ${appointment.patientLName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (appointment.clinicName.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                'Clinic: ${appointment.clinicName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Address: ${appointment.clinicAddress}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Phone: ${appointment.clinicPhoneNumber}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class DoctorSessionScreen extends StatelessWidget {
  final Appointment appointment;

  const DoctorSessionScreen({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Session',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                // Placeholder for doctor's image
                backgroundColor: Colors.grey[300],
                // backgroundImage: NetworkImage(appointment.imageUrl ?? ''),
              ),
              title: Text(
                '${appointment.patientFName} ${appointment.patientLName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Session At ${appointment.hours}:${appointment.minutes > 9 ? appointment.minutes : '0${appointment.minutes}'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Type Of Session',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appointment.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${appointment.fees}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 226,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
