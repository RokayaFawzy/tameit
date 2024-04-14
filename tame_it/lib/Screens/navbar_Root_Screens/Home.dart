import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tame_it/values/values.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => __HomeStateState();
}

class __HomeStateState extends State<Home> {
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
              ),
            ),
            title: const Text(
              'Home Page',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  icon: const CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.black38,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage('assets/images/123.jpg'),
                      )))
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Welcome to TAME IT',
                      style: GoogleFonts.jacquesFrancois(
                          textStyle: const TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 18,
                      )))),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/First Imgae.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))),
              const SizedBox(height: 12),
              Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text('Our Services',
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ))),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Therapists');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p1.jpg',
                  title: 'Therapists',
                ),
              ),
              const SizedBox(height: 5),
              _buildServiceCard(
                image: 'assets/images/p2.jpg',
                title: 'Group Therapy',
              ),
              const SizedBox(height: 5),
              _buildServiceCard(
                image: 'assets/images/p3.jpg',
                title: 'ChatBot',
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/OnlineTherapists');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p4.jpg',
                  title: 'Online Sessions',
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Testings');
                },
                child: _buildServiceCard(
                  image: 'assets/images/p5.jpg',
                  title: 'Testings',
                  apparent: true,
                ),
              ),
              const SizedBox(height: 200),
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
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3),
              //   ),
              //  ],
            ),
            child: Row(children: [
              Container(
                  width: cardWidth * 0.3,
                  height: cardHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(15),
                      //   bottomLeft: Radius.circular(15),

                      // ),
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
