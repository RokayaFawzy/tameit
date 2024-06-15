import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/AdminScreens/adminhome.dart';
import 'package:tame_it/AdminScreens/doctor/ListDoctors.dart';
import 'package:tame_it/AdminScreens/doctor/edit_Doctor_Admain.dart';
import 'package:tame_it/values/values.dart';
import 'package:http/http.dart' as http;

class AdminDoctorCard extends StatefulWidget {
  final Doctor doctor;
  final Function(int) onDelete; // Callback function

  AdminDoctorCard({super.key, required this.doctor, required this.onDelete});

  @override
  State<AdminDoctorCard> createState() => _AdminDoctorCardState();
}

class _AdminDoctorCardState extends State<AdminDoctorCard> {
  var size, height, width;
  bool _isLoading = false;

  Future<void> deleteDoctor(int DoctorID) async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final String apiUrl =
        'https://tameit.azurewebsites.net/api/admin/deleteDoctor/$DoctorID';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Replace with your token
        },
      );

      if (response.statusCode == 204) {
        // Doctor deleted successfully
        print('Doctor deleted successfully');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Success'),
            content: Text('Doctor deleted successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    // Navigate to AdminHomePage
                    context,
                    MaterialPageRoute(builder: (context) => AdminHomePage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        widget.onDelete(DoctorID); // Notify parent widget
      } else if (response.statusCode == 403) {
        // Handle unauthorized access error
        print('Failed to delete doctor: 403 Forbidden');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('You are not authorized to delete this doctor.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle error
        print('Failed to delete doctor: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete doctor. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error deleting doctor: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'An error occurred while deleting the doctor. Please try again later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/DoctorDetails');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          color: Colors.white,
          child: Stack(
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: width / 4,
                    height: height / 3.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: widget.doctor.imageUrl != null
                          ? Image.network(
                              widget.doctor.imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/nurse.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Text(
                        'Dr.' +
                            widget.doctor.firstName +
                            ' ' +
                            widget.doctor.lastName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: width / 25),
                      ),
                    ],
                  ),
                  Text(widget.doctor.jobTitle,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  Text(
                    '${widget.doctor.price} EGP', // Use string interpolation to concatenate the integer and the string
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(children: [
                    const Icon(Icons.work_history_outlined,
                        size: 18, color: AppColors.deepsea),
                    const SizedBox(width: 5),
                    Text(
                      '${widget.doctor.yearsOfExperience}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    )
                  ]),
                  Container(
                    height: 50, // Adjust the height as needed
                    child: Flexible(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 2.0,
                        children: [
                          Chip(
                            label: Text(
                              widget.doctor.specializations.length > 2
                                  ? "${widget.doctor.specializations.take(2).join(", ")} and..."
                                  : widget.doctor.specializations.join(", "),
                              style: TextStyle(fontSize: width / 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBar.builder(
                    initialRating: widget.doctor.rating
                        .toDouble(), // Set the initial rating
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, index) {
                      return Icon(
                        index < widget.doctor.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: index < widget.doctor.rating
                            ? AppColors.OrangePeel
                            : Colors
                                .grey, // Color the stars based on the rating
                        size: 20,
                      );
                    },
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                        width: width / 3.5,
                        height: height / 20,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/DoctorDetails');
                            },
                            child: Text('View Profile',
                                style: TextStyle(
                                  color: AppColors.OrangePeel,
                                  fontSize: width / 28,
                                  fontWeight: FontWeight.w600,
                                )))),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width / 3.5,
                      height: height / 20,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.deepsea)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDoctorAdmin(
                                      doctorId: widget.doctor.id)),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: width / 30,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ])
                ]),
              ]),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Confirmation'),
                        content: Text(
                            'Are you sure you want to delete this doctor?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              deleteDoctor(widget.doctor.id);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure you want to delete this doctor?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                deleteDoctor(widget.doctor
                                    .id); // Call deleteDoctor function with the doctor's ID
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
