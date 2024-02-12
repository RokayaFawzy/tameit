import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tame_it/values/values.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => __HomeStateState();
}

class __HomeStateState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

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
                            'assets/fonts/images/First Imgae.jpg',
                            fit: BoxFit.cover,
                          )))),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.only(left:15.0),
                child: Text('Our Services',
                style: TextStyle(color: AppColors.deepsea,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: 8)
            ]))));
  }
}
