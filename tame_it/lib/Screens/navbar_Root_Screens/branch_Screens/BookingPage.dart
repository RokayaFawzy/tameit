import 'package:flutter/material.dart';

import '../../../values/values.dart';

class AppointmentBooking extends StatefulWidget {
  @override
  _AppointmentBookingState createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  void _showPaymentDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPaymentItem('Consultation', '\$60.00'),
              _buildPaymentItem('Additional Discount', '-'),
              SizedBox(height: 8.0),
              Divider(),
              SizedBox(height: 8.0),
              _buildPaymentItem('Total', '\$61.00'),
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
                    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'Make an appointment',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
        backgroundColor: AppColors.whiteShade3,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/123.jpg'),
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
                        Text(
                          'Dr. Georgia Griffin',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Psychologist',
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Choose Date',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.deepsea,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ListTile(
                  title: Text(
                    '${_selectedDate.toLocal().toString().substring(0, 10)}',
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: _presentDatePicker,
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
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildTimeButton('9:00 am'),
                  _buildTimeButton('10:00 am'),
                  _buildTimeButton('11:00 am'),
                  _buildTimeButton('12:00 pm'),
                  _buildTimeButton('1:00 pm'),
                  _buildTimeButton('2:00 pm'),
                  _buildTimeButton('3:00 pm'),
                  _buildTimeButton('4:00 pm'),
                  _buildTimeButton('5:00 pm'),
                  _buildTimeButton('6:00 pm'),
                  _buildTimeButton('7:00 pm'),
                  _buildTimeButton('8:00 pm'),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showPaymentDetails(context);
                  },
                  child: Text(
                    'Make Appointment',
                    style: TextStyle(color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepsea,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    return ElevatedButton(
      onPressed: () {
        // Handle time selection logic here
      },
      child: Text(time, style: TextStyle(color: AppColors.blackShade4)),
    );
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
}
