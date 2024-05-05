import 'package:flutter/material.dart';
import 'package:tame_it/widgets/Toggle_rating.dart';
import 'package:tame_it/widgets/toggle_gender.dart';
import 'package:tame_it/widgets/toggle_hours_checkbox.dart';
import 'package:tame_it/values/values.dart';
// import 'package:intl/intl.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // final TextEditingController _date = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Gender",
                  style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontFamily: "Domine",
                      fontWeight: FontWeight.w600,
                      height: 1.20),
                ),
              ),
              ToggleGenderButtons(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Rating",
                  style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontFamily: "Domine",
                      fontWeight: FontWeight.w600,
                      height: 1.20),
                ),
              ),
              ToggleRatingButtons(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Available Hours",
                  style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontFamily: "Domine",
                      fontWeight: FontWeight.w600,
                      height: 1.20),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Choose Date",
              //     style: TextStyle(
              //         fontSize: 15,
              //         fontWeight: FontWeight.w700,
              //         fontFamily: 'NunitoSans',
              //         color: AppColors.deepsea),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: TextField(
              //     controller: _date,
              //     decoration: InputDecoration(
              //         icon: Icon(Icons.calendar_today_rounded),
              //         labelText: "Select Date"),
              //     onTap: () async {
              //       DateTime? pickeddate = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(2000),
              //           lastDate: DateTime(2110));
              //       if (pickeddate != null) {
              //         setState(() {
              //           _date.text =
              //               DateFormat('yyyy-MM-dd').format(pickeddate);
              //         });
              //       }
              //     },
              //   ),
              // ),

              AvailableHoursCheckbox(),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Material(
                      color: AppColors.OrangePeel,
                      borderRadius:
                          BorderRadius.circular(25), // Set border radius to 25

                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ),
                          // );
                        },
                        child: Padding(
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
                  ),
                  Flexible(
                    child: Material(
                      color: AppColors.deepsea,
                      borderRadius:
                          BorderRadius.circular(25), // Set border radius to 25

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
                        child: Padding(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
