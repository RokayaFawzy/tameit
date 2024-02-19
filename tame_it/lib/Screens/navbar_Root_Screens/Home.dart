import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tame_it/values/values.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => __HomeStateState();
}

class __HomeStateState extends State<Home> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        body: DefaultTabController(
            length: 2,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              ListView(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: widthOfScreen * 0.1,
                    right: widthOfScreen * 0.3,
                  ),
                ),
                SizedBox(
                  height: (heightOfScreen * 0.01),
                ),
                Container(
                  height: heightOfScreen,
                  child: _buildHome(),
                )
              ])
            ]))));
  }

  Widget _buildHome() {
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
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Profile');
                        },
                        child: const CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.black38,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  AssetImage('assets/images/123.jpg'),
                            ))))
              ])
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                  child: Text('Welcome to TAME IT',
                      style: GoogleFonts.jacquesFrancois(
                          textStyle: const TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 18,
                      )))),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.deepsea),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/First Imgae.jpg',
                            fit: BoxFit.cover,
                          )))),
              const SizedBox(height: 12),
              const Padding(
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
