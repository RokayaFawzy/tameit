import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/DoctorScreens/patient/chat.dart';
import 'package:tame_it/values/values.dart';

class UserDetails {
  final String userName;
  final String? imageUrl;

  UserDetails({required this.userName, this.imageUrl});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json['userName'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}

class Appointment {
  final int year;
  final int monthOfYear;
  final int dayOfMonth;
  final int hours;
  final int minutes;
  final String patientFName;
  final String patientLName;
  final double fees;
  final String clinicName;
  final String clinicAddress;
  final String clinicPhoneNumber;

  Appointment({
    required this.year,
    required this.monthOfYear,
    required this.dayOfMonth,
    required this.hours,
    required this.minutes,
    required this.patientFName,
    required this.patientLName,
    required this.fees,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicPhoneNumber,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      year: json['year'],
      monthOfYear: json['monthOfYear'],
      dayOfMonth: json['dayOfMonth'],
      hours: json['hours'],
      minutes: json['minutes'],
      patientFName: json['patientFName'] ?? '', // Handle null value
      patientLName: json['patientLName'] ?? '', // Handle null value
      fees: (json['fees'] as num?)?.toDouble() ?? 0.0, // Handle null value
      clinicName: json['clinicName'] ?? '', // Handle null value
      clinicAddress: json['clinicAddress'] ?? '', // Handle null value
      clinicPhoneNumber: json['clinicPhoneNumber'] ?? '', // Handle null value
    );
  }
}

class ShowMyAppointment extends StatefulWidget {
  @override
  _ShowMyAppointmentState createState() => _ShowMyAppointmentState();
}

class _ShowMyAppointmentState extends State<ShowMyAppointment> {
  late Future<UserDetails> userDetails;
  Future<List<Appointment>>? appointments;

  final TextEditingController _dateController = TextEditingController();
  final List<String> _sessionTimes = [
    "10:00 AM",
    "1:00 PM",
    "3:00 PM",
    "5:00 PM"
  ];

  String? selectedDate;
  List<Appointment> filteredAppointments = [];
  String? clinicName;
  String? clinicAddress;
  String? clinicPhoneNumber;

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
  }

  Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/user/details'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return UserDetails.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  Future<List<Appointment>> fetchAppointments({String? date}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/appointment/readDoctorAppointments'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Appointment> allAppointments =
            responseData.map((data) => Appointment.fromJson(data)).toList();

        if (date != null) {
          allAppointments = allAppointments
              .where((appointment) =>
                  '${appointment.year}-${appointment.monthOfYear.toString().padLeft(2, '0')}-${appointment.dayOfMonth.toString().padLeft(2, '0')}' ==
                  date)
              .toList();
        }

        return allAppointments;
      } else {
        throw Exception(
            'Failed to load appointments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2110),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dateController.text = selectedDate!;
        appointments = fetchAppointments(date: selectedDate);
        appointments?.then((value) {
          setState(() {
            filteredAppointments = value;
            if (filteredAppointments.isNotEmpty) {
              final clinic = filteredAppointments.first;
              clinicName = clinic.clinicName;
              clinicAddress = clinic.clinicAddress;
              clinicPhoneNumber = clinic.clinicPhoneNumber;
            }
          });
        });
      });
    }
  }

  void _navigateToSession(Appointment appointment) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YourSessionPage(
                  sessionTime:
                      '${appointment.hours}:${appointment.minutes.toString().padLeft(2, '0')}',
                  patientName:
                      '${appointment.patientFName} ${appointment.patientLName}',
                  fees: appointment.fees,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
        future: userDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data != null) {
              final imageProvider = snapshot.data!.imageUrl != null
                  ? NetworkImage(snapshot.data!.imageUrl!)
                  : const AssetImage('assets/images/newlogo.jpg');
              return buildUI(
                  snapshot.data!, imageProvider as ImageProvider<Object>);
            } else {
              return Text('User details not available');
            }
          }
        });
  }

  Widget _buildClinicField(int index) {
    return Column(children: [
      TextFormField(
          decoration: InputDecoration(
              hintText: clinicName ?? 'Clinic Name',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.deepsea),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ))),
      TextFormField(
          decoration: InputDecoration(
              hintText: clinicAddress ?? 'Address',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.deepsea),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ))),
      TextFormField(
          decoration: InputDecoration(
              hintText: clinicPhoneNumber ?? 'Phone Number',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.deepsea),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              )))
    ]);
  }

  Widget buildUI(UserDetails userDetails, ImageProvider imageProvider) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text('Show My Appointment',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: SafeArea(
            child: ListView(shrinkWrap: true, children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Hi Dr. ' + userDetails.userName,
                      style: TextStyle(
                          fontSize: 23,
                          color: AppColors.OrangePeel,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 15),
                Row(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Choose Date  to know your appointment',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )))
                ]),
                SizedBox(height: 25),
                Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 30.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              hintText: 'Date',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: _pickDate,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.deepsea),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          FutureBuilder<List<Appointment>>(
                              future: appointments,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return Column(children: [
                                      SizedBox(height: 15),
                                      Row(children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text('Clinics',
                                                style: TextStyle(
                                                  color: AppColors.deepsea,
                                                  fontFamily: "Domine",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                )))
                                      ]),
                                      _buildClinicField(0),
                                      SizedBox(height: 15),
                                      Row(children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text('Your Available Time',
                                                style: TextStyle(
                                                  color: AppColors.deepsea,
                                                  fontFamily: "Domine",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                )))
                                      ]),
                                      SizedBox(height: 15),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final appointment =
                                                snapshot.data![index];
                                            return Card(
                                                child: ListTile(
                                              title: Text(
                                                  '${appointment.hours}:${appointment.minutes.toString().padLeft(2, '0')}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  )),
                                              subtitle: Text(
                                                'Patient: ${appointment.patientFName} ${appointment.patientLName}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              onTap: () => _navigateToSession(
                                                  appointment),
                                            ));
                                          })
                                    ]);
                                  } else {
                                    return Text(
                                        'No appointments available for this date');
                                  }
                                }
                              })
                        ]))
              ]))
        ])));
  }
}

// class YourSessionPage extends StatefulWidget {
//   final String sessionTime;
//   final String patientName;
//   final double fees;

//   const YourSessionPage(
//       {Key? key,
//       required this.sessionTime,
//       required this.patientName,
//       required this.fees})
//       : super(key: key);

//   @override
//   State<YourSessionPage> createState() => _YourSessionPageState();
// }

// class _YourSessionPageState extends State<YourSessionPage> {
//   String _sessionType = 'offline'; // Default selected session type

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: const Text(
//           'Your Session',
//           style: TextStyle(
//             color: AppColors.deepsea,
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: AppColors.deepsea),
//       ),
//       body: SafeArea(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundImage: AssetImage(
//                             'assets/images/userimage.jpg'), // Replace with your image asset
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.patientName,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.deepsea,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             SizedBox(width: 80),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Chat(
//                                             patientName: '',
//                                           )),
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.message,
//                                 color: AppColors.deepsea,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Divider(
//                     color: AppColors.deepsea,
//                     thickness: 0.1,
//                     height: 8,
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Text(
//                           'Your Session Is At ${widget.sessionTime}',
//                           style: const TextStyle(
//                             color: AppColors.OrangePeel,
//                             fontFamily: "Domine",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Type Of Session',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: AppColors.deepsea,
//                               fontFamily: "Domine",
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Radio<String>(
//                             value: 'online',
//                             groupValue: _sessionType,
//                             onChanged: (value) {
//                               setState(() {
//                                 _sessionType = value!;
//                               });
//                             },
//                           ),
//                           const Text(
//                             'Online',
//                             style: TextStyle(
//                                 fontSize: 18, color: AppColors.OrangePeel),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Radio<String>(
//                             value: 'offline',
//                             groupValue: _sessionType,
//                             onChanged: (value) {
//                               setState(() {
//                                 _sessionType = value!;
//                               });
//                             },
//                           ),
//                           const Text(
//                             'Offline',
//                             style: TextStyle(
//                                 fontSize: 18, color: AppColors.OrangePeel),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Price',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: AppColors.deepsea,
//                               fontFamily: "Domine",
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '\$${widget.fees}',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: AppColors.deepsea,
//                               fontFamily: "Domine",
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class YourSessionPage extends StatefulWidget {
  final String sessionTime;
  final String patientName;
  final double fees;

  const YourSessionPage(
      {Key? key,
      required this.sessionTime,
      required this.patientName,
      required this.fees})
      : super(key: key);

  @override
  State<YourSessionPage> createState() => _YourSessionPageState();
}

class _YourSessionPageState extends State<YourSessionPage> {
  String _sessionType = 'offline'; // Default selected session type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Your Session',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                            'assets/images/userimage.jpg'), // Replace with your image asset
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.patientName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepsea,
                                  ),
                                ),
                                SizedBox(width: 80),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chat(
                                                patientName: '',
                                              )),
                                    );
                                  },
                                  child: Icon(
                                    Icons.message,
                                    color: AppColors.deepsea,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: AppColors.deepsea,
                    thickness: 0.1,
                    height: 8,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Your Session Is At ${widget.sessionTime}',
                          style: const TextStyle(
                            color: AppColors.OrangePeel,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Type Of Session',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'online',
                            groupValue: _sessionType,
                            onChanged: (value) {
                              setState(() {
                                _sessionType = value!;
                              });
                            },
                          ),
                          const Text(
                            'Online',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.OrangePeel),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'offline',
                            groupValue: _sessionType,
                            onChanged: (value) {
                              setState(() {
                                _sessionType = value!;
                              });
                            },
                          ),
                          const Text(
                            'Offline',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.OrangePeel),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${widget.fees}',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
