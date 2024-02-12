import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

import '../../../Models/Doctor_model.dart';
import '../../../widgets/custom_card.dart';

class Therapists extends StatefulWidget {
  const Therapists({super.key});

  @override
  State<Therapists> createState() => __TherapistsStateState();
}

class __TherapistsStateState extends State<Therapists> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

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
                  child: _buildMyTherapy(),
                )
              ])
            ]))));
  }

  Widget _buildMyTherapy() {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
            backgroundColor: AppColors.whiteShade3,
            shape: const Border(
                bottom: BorderSide(
              color: AppColors.whiteShade4,
              width: 1,
            )),
            title: const Text('Our Therapists',
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
                child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                    // Use a Material design search bar
                    child: TextField(
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Therapist Name or interest',
                            hintStyle: const TextStyle(
                                color: AppColors.greyShade7, fontSize: 15),
                            prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.greyShade7,
                                ),
                                onPressed: () {
                                  // Perform the search here
                                }),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))))
              ])),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    Container(
                      width: widthOfScreen * 0.45,
                      child: OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: AppColors.deepsea,
                                width: 1.0,
                                style: BorderStyle.solid)),
                            shape: const MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ))),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.tune,
                                color: AppColors.deepsea,
                                size: 20,
                              ),
                              Text(' Filter by',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                  ))
                            ]),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/FiltersScreen');
                        },
                      ),
                    )
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    Container(
                      width: widthOfScreen * 0.45,
                      child: OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: AppColors.deepsea,
                                width: 1.0,
                                style: BorderStyle.solid)),
                            shape: const MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ))),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.swap_vert,
                                color: AppColors.deepsea,
                                size: 20,
                              ),
                              Text(' Sort by',
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                  ))
                            ]),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');
                        }
                      )
                    )
                  ]))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          DoctorCard(
            doctor: Doctor(
                firstName: 'Smith',
                specialty: 'Psychologist',
                rating: 5,
                lastName: ' Wilson',
                price: '800',
                experienceYears: '24 yr',
                interest: 'Depression, Stress, Anxiety',
                image: ''),
          ),
        ]))));
  }
}








// ClipRRect(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(10),
          //     topRight: Radius.circular(10),
          //   ),
          //   child: AspectRatio(
          //     aspectRatio: 10, // adjust aspect ratio as needed
          //     child: Image.asset(
          //         'assets/doctor.jpg'), // replace with your doctor image
          //   ),
          // ),