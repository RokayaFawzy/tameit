import 'package:flutter/material.dart';
import '../values/values.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          child: Stack(children: [
        const Row(children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black38,
            child: CircleAvatar(
              radius: 25,
              // backgroundImage: NetworkImage('URL'), // Add your image URL here
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 25), // Placeholder icon
            ),
          ),
          SizedBox(width: 16),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Admin',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 4),
                Text('admin@email.com',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 14,
                    ))
              ])
        ]),
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the drawer
                }))
      ])),
      ListTile(
        leading: Icon(Icons.home,
            color:
                _selectedIndex == 0 ? AppColors.OrangePeel : AppColors.deepsea),
        title: Text('Home',
            style: TextStyle(
                color: _selectedIndex == 0
                    ? AppColors.OrangePeel
                    : AppColors.deepsea)),
        selected: _selectedIndex == 0,
        onTap: () {
          setState(() {
            _selectedIndex = 0;
          });
          Navigator.of(context).pushNamed('/AdminHomePage');
        },
      ),
      ListTile(
        leading: Icon(Icons.person,
            color:
                _selectedIndex == 1 ? AppColors.OrangePeel : AppColors.deepsea),
        title: Text(
          'Users',
          style: TextStyle(
            color:
                _selectedIndex == 1 ? AppColors.OrangePeel : AppColors.deepsea,
            fontSize: 14,
          ),
        ),
        selected: _selectedIndex == 1,
        onTap: () {
          setState(() {
            _selectedIndex = 1;
          });
          Navigator.of(context).pushNamed('/ListUsers');
        },
      ),
      ListTile(
          leading: Icon(Icons.local_hospital,
              color: _selectedIndex == 2
                  ? AppColors.OrangePeel
                  : AppColors.deepsea),
          title: Text('Doctors',
              style: TextStyle(
                color: _selectedIndex == 2
                    ? AppColors.OrangePeel
                    : AppColors.deepsea,
                fontSize: 14,
              )),
          selected: _selectedIndex == 2,
          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
            Navigator.of(context).pushNamed('/ListDoctors');
          }),
      ListTile(
          leading: Icon(Icons.calendar_today,
              color: _selectedIndex == 3
                  ? AppColors.OrangePeel
                  : AppColors.deepsea),
          title: Text(
            'Appointments',
            style: TextStyle(
              color: _selectedIndex == 3
                  ? AppColors.OrangePeel
                  : AppColors.deepsea,
              fontSize: 14,
            ),
          ),
          selected: _selectedIndex == 3,
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
            Navigator.pop(context);
          }),
      const SizedBox(height: 85),
      const Divider(),
      ListTile(
        leading: Icon(Icons.settings,
            color:
                _selectedIndex == 4 ? AppColors.OrangePeel : AppColors.deepsea),
        title: Text(
          'Settings',
          style: TextStyle(
            color:
                _selectedIndex == 4 ? AppColors.OrangePeel : AppColors.deepsea,
            fontSize: 14,
          ),
        ),
        selected: _selectedIndex == 4,
        onTap: () {
          setState(() {
            _selectedIndex = 4;
          });
          Navigator.pop(context);
        },
      ),
      ListTile(
          leading: Icon(Icons.logout,
              color: _selectedIndex == 5
                  ? AppColors.OrangePeel
                  : AppColors.deepsea),
          title: Text(
            'Logout',
            style: TextStyle(
              color: _selectedIndex == 5
                  ? AppColors.OrangePeel
                  : AppColors.deepsea,
              fontSize: 14,
            ),
          ),
          selected: _selectedIndex == 5,
          onTap: () {
            setState(() {
              _selectedIndex = 5;
            });
            Navigator.pop(context);
          })
    ]));
  }
}
