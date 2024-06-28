import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tame_it/AdminScreens/Postnotification/ListPost.dart';
import '../values/values.dart';
import 'drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key});

  @override
  State<AdminHomePage> createState() => __AdminHomePageStateState();
}

class __AdminHomePageStateState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
              bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          )),
          title: const Text('Home Page',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        drawer: const MyDrawer(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Welcome to TAME IT',
                      style: GoogleFonts.jacquesFrancois(
                          textStyle: const TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 18,
                      )))),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/ListDoctors');
                },
                child: _buildServiceCard(
                  image: 'assets/images/admindoctors.jpg',
                  title: 'Manage doctors',
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/ListUsers');
                  },
                  child: _buildServiceCard(
                    image: 'assets/images/adminusers.jpg',
                    title: 'Manage Users',
                  )),
              const SizedBox(height: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/ListAllAppointments');
                  },
                  child: _buildServiceCard(
                    image: 'assets/images/adminapointments.jpg',
                    title: 'Manage Appointments',
                  )),
              const SizedBox(height: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPostsPage()),
                    );
                  },
                  child: _buildServiceCard(
                    image: 'assets/images/manage plog.png',
                    title: 'Manage Posts',
                  )),
              const SizedBox(height: 55),
            ]))));
  }

  Widget _buildServiceCard({
    required String image,
    required String title,
    bool apparent = false,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final cardHeight = screenSize.height * 0.15;
    final cardWidth = screenSize.width * 0.9;

    return Center(
        child: Container(
            width: cardWidth,
            height: cardHeight,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(children: [
              Container(
                  width: cardWidth * 0.3,
                  height: cardHeight,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        height:
                            cardHeight, // Set image height to match card height
                      ))),
              SizedBox(width: cardWidth * 0.05),
              Center(
                  child: Text(title,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: AppColors.OrangePeel,
                        fontWeight: FontWeight.bold,
                      )))
            ])));
  }
}
