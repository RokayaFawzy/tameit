import 'package:flutter/material.dart';
import 'package:tame_it/widgets/Toggle_rating.dart';
import 'package:tame_it/widgets/toggle_gender.dart';
import 'package:tame_it/widgets/toggle_hours_checkbox.dart';
import 'package:tame_it/values/values.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // Add this variable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
            title: const Text(
              '                     Filters',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 16,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w700,
                height: 1.70,
              ),
            ),
            shadowColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColors.deepsea)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 16,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.w600,
                              height: 1.20),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      ToggleGenderButtons(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Rating",
                          style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 16,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.w600,
                              height: 1.20),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      ToggleRatingButtons(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Available Hours",
                          style: TextStyle(
                              color: AppColors.deepsea,
                              fontSize: 16,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.w600,
                              height: 1.20),
                        ),
                      ],
                    ),
                  ),
                  Container(child: const AvailableHoursCheckbox()),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: AppColors.OrangePeel,
                        borderRadius: BorderRadius.circular(
                            25), // Set border radius to 25

                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ),
                            // );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: AppColors.deepsea,
                        borderRadius: BorderRadius.circular(
                            25), // Set border radius to 25

                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>

                            //       FiltersScreen(),
                            //       ),
                            // );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
