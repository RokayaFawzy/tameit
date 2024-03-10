import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Welcome to TAME IT',
                  style: GoogleFonts.jacquesFrancois(
                    textStyle: const TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/First Imgae.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Our Services',
                    style: TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: 10),
              Center(
                  child: Container(
                      width: width / 1.1,
                      height: height / 6,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(children: [
                            SizedBox(
                                width: width / 3.5,
                                height: height / 3.5,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/p1.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: width / 5),
                              child: Text('Therapists',
                                  style: TextStyle(
                                      fontSize: width / 20,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ])))),
              SizedBox(height: 20),
              Center(
                  child: Container(
                      width: width / 1.1,
                      height: height / 8,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(children: [
                            SizedBox(
                                width: width / 3.1,
                                height: height / 8,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/p2.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: width / 5),
                              child: Text(' Group \nTherapy',
                                  style: TextStyle(
                                      fontSize: width / 20,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.bold)),
                            )
                          ])))),
              SizedBox(height: 20),
              Center(
                  child: Container(
                      width: width / 1.1,
                      height: height / 5,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(children: [
                            SizedBox(
                                width: width / 3,
                                height: height / 3.5,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/p3.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: width / 5),
                              child: Text('ChatBot',
                                  style: TextStyle(
                                      fontSize: width / 20,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.bold)),
                            )
                          ])))),
              SizedBox(height: 20),
              Center(
                  child: Container(
                      width: width / 1.1,
                      height: height / 4.5,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(children: [
                            SizedBox(
                                width: width / 3,
                                height: height / 3,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/p4.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: width / 5),
                              child: Text(' Online \nSessions',
                                  style: TextStyle(
                                      fontSize: width / 20,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.bold)),
                            )
                          ])))),
              SizedBox(height: 20),
              Center(
                  child: Container(
                      width: width / 1.1,
                      height: height / 5,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(children: [
                            Container(
                                width: width / 3,
                                height: height / 3.5,
                                decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/p5.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: width / 5),
                              child: Text('Testings',
                                  style: TextStyle(
                                      fontSize: width / 20,
                                      color: AppColors.OrangePeel,
                                      fontWeight: FontWeight.bold)),
                            )
                          ])))),
              SizedBox(height: 200)
            ]))));
  }
}
