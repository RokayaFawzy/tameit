import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../values/values.dart';
import '../therapistspage.dart';

class Appointment {
  final String doctorFName;
  final String doctorLName;
  final String? patientFName;
  final String? patientLName;
  final String clinicName;
  final String clinicAddress;
  final String clinicPhoneNumber;
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
    this.patientFName,
    this.patientLName,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicPhoneNumber,
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
      patientFName: json['patientFName'],
      patientLName: json['patientLName'],
      clinicName: json['clinicName'],
      clinicAddress: json['clinicAddress'],
      clinicPhoneNumber: json['clinicPhoneNumber'],
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

class AppointmentBooking extends StatefulWidget {
  final int doctorId;
  final List<String> doctorSpecialization;
  final String doctorImage;

  const AppointmentBooking({
    Key? key,
    required this.doctorId,
    required this.doctorSpecialization,
    required this.doctorImage,
  }) : super(key: key);

  @override
  _AppointmentBookingState createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime _selectedDate = DateTime.now();
  Map<String, String> _availableTimes = {};
  String? _selectedTime;
  bool _isLoading = true;
  Appointment? _appointment;
  bool _isBooking = false;

  @override
  void initState() {
    super.initState();
    _fetchAppointments(widget.doctorId);
  }

  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _isLoading = true; // Set loading state before fetching appointments
        _fetchAppointments(widget.doctorId);
      });
    }
  }

  List<Widget> _buildTimeButtons() {
    return _availableTimes.keys.map((time) => _buildTimeButton(time)).toList();
  }

  Widget _buildTimeButton(String time) {
    String formattedTime = _formatTime(time); // Format time to HH:mm
    String status = _availableTimes[time]!;
    bool isAvailable = status == 'AVAILABLE';
    Color buttonColor = isAvailable
        ? (_selectedTime == time ? AppColors.deepsea : Colors.green)
        : Colors.red;
    String buttonText = isAvailable ? 'Available' : 'Booked';

    return ElevatedButton(
      onPressed: isAvailable ? () => _selectTime(time) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      child: Text(
        formattedTime,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  String _formatTime(String time) {
    List<String> parts = time.split(':');
    if (parts.length == 2) {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    }
    return time; // Return original time if format is unexpected
  }

  void _selectTime(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  void _fetchAppointments(int doctorId) async {
    String apiUrl =
        'https://tameit.azurewebsites.net/api/appointment/readDoctorAppointments/${widget.doctorId}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _processAppointments(data);
    } else {
      print('Failed to fetch appointments: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false; // Turn off loading state after fetching appointments
    });
  }

  Future<void> bookAppointment(int appointmentId) async {
    setState(() {
      _isBooking = true; // Set booking in progress
    });

    String apiUrl =
        'https://tameit.azurewebsites.net/api/appointment/book/$appointmentId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Appointment bookedAppointment = Appointment.fromJson(data);
        _showPaymentDetails(context, bookedAppointment);
      } else {
        _showErrorDialog('Failed to book the appointment. Please try again.');
      }
    } catch (e) {
      print('Error booking appointment: $e');
      _showErrorDialog('An error occurred while booking the appointment.');
    } finally {
      setState(() {
        _isBooking = false; // Reset booking state
      });
    }
  }

  void _processAppointments(List<dynamic> appointmentsData) {
    Map<String, String> availableTimes = {};
    for (var appointment in appointmentsData) {
      if (appointment['dayOfMonth'] == _selectedDate.day &&
          appointment['monthOfYear'] == _selectedDate.month &&
          appointment['year'] == _selectedDate.year) {
        String time = '${appointment['hours']}:${appointment['minutes']}';
        availableTimes[time] = appointment['status'];
      }
      if (_appointment == null &&
          appointment['doctorFName'] != null &&
          appointment['doctorLName'] != null) {
        _appointment = Appointment.fromJson(appointment);
      }
    }
    setState(() {
      _availableTimes = availableTimes;
    });
  }

  Widget _buildPaymentItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  void _showPaymentDetails(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPaymentItem('Fees', '${appointment.fees}'),
              SizedBox(height: 8.0),
              Divider(),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Clinic Information:',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.deepsea,
                      fontSize: 13),
                ),
              ),
              SizedBox(height: 8.0),
              _buildPaymentItem('Name', appointment.clinicName),
              SizedBox(height: 8.0),
              _buildPaymentItem('Address', appointment.clinicAddress),
              SizedBox(height: 8.0),
              _buildPaymentItem('Phone Number', appointment.clinicPhoneNumber),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Therapists()),
                    );
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Make an appointment',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.doctorImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_appointment != null)
                              Text(
                                'Dr. ${_appointment!.doctorFName} ${_appointment!.doctorLName}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            Text(
                              '${widget.doctorSpecialization.join(', ')}',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'Choose Date',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: _presentDatePicker,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ListTile(
                        title: Text(
                          '${_selectedDate.toLocal().toString().substring(0, 10)}',
                        ),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Available Time',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _availableTimes.isEmpty
                      ? Center(
                          child: Text(
                            'No available times for selected date.',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _buildTimeButtons(),
                        ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _selectedTime != null
                          ? () {
                              int appointmentId =
                                  int.parse(_selectedTime!.replaceAll(':', ''));
                              bookAppointment(appointmentId);
                            }
                          : null,
                      child: Text(
                        'Make Appointment',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepsea,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
