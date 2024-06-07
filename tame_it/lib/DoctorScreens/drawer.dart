import 'package:flutter/material.dart';
import '../values/values.dart';
import 'appointment/Appointment.dart';
import 'patient/Patients.dart';

class DrawerDoctor extends StatefulWidget {
  @override
  _DrawerDoctorState createState() => _DrawerDoctorState();
}

class _DrawerDoctorState extends State<DrawerDoctor> {
  int _selectedIndex = -1; // -1 means no item is selected

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            // decoration: BoxDecoration(
            //   color: AppColors.deepsea,
            // ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: AppColors.deepsea),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                            'assets/images/userimage.jpg'), // Replace with your image asset
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor Name',
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'doctor.email@example.com',
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
          ),
          ListTile(
            leading: Icon(Icons.home_outlined,
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Home',
              style: TextStyle(
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury_outlined,
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Patients',
              style: TextStyle(
                color: _selectedIndex == 1
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Patients()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services_outlined,
                color: _selectedIndex == 2
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Appointments',
              style: TextStyle(
                color: _selectedIndex == 2
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Appointment()),
              ); // Add navigation logic here
            },
          ),
          Spacer(), // Pushes the remaining items to the bottom
          Divider(),
          ListTile(
            leading: Icon(Icons.settings_outlined,
                color: _selectedIndex == 3
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Settings',
              style: TextStyle(
                color: _selectedIndex == 3
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: _selectedIndex == 4
                    ? AppColors.OrangePeel
                    : AppColors.deepsea),
            title: Text(
              'Logout',
              style: TextStyle(
                color: _selectedIndex == 4
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 4;
              });
              Navigator.pop(context);
              // Add logout logic here
            },
          ),
        ],
      ),
    );
  }
}
