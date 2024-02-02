import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class NavBarRoot extends StatefulWidget {
  const NavBarRoot({super.key});

  @override
  State<NavBarRoot> createState() => _NavBarRootState();
}

class _NavBarRootState extends State<NavBarRoot> {
  int _selectedIndex = 0;
  final _screens = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          shadowColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.segment_rounded),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black38,
                child: CircleAvatar(
                  radius: 13,
                  backgroundImage: AssetImage('assets/images/123.jpg'),
                ),
              ),
            ],
          ),
          flexibleSpace: Column(
            children: [
              Container(
                height: 1, // Height of the line
                color: Colors.grey,
                // Color of the line
              ),
              // Add other widgets if needed
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.deepsea)),
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          backgroundColor: AppColors.deepsea,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.OrangePeel,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt), label: "THERAPISTS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "ONLINE"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "MY THERAPY"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), label: "CHATBOT"),
          ],
        ),
      ),
    );
  }
}
