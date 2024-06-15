import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/branch_Screens/doctor_details.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/therapistspage.dart';
import 'package:tame_it/values/values.dart';

class DoctorCard extends StatefulWidget {
  final Doctor doctor;

  DoctorCard({super.key, required this.doctor});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
 Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorDetails(doctorId:  widget.doctor.id,)),
        );      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          color: Colors.white,
          child: Row(
            children: [
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
                        bottomLeft: Radius.circular(15)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr.' +
                        widget.doctor.firstName +
                        ' ' +
                        widget.doctor.lastName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width / 25),
                  ),
                  Text(widget.doctor.jobTitle,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  Text(
                      '${widget.doctor.price} EGP', // Use string interpolation to concatenate the integer and the string
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontWeight: FontWeight.w500,
                      )),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: width / 3.5,
                        height: height / 20,
                        child: TextButton(
                          onPressed: () {
 Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorDetails(doctorId:  widget.doctor.id,)),
        );                          },
                          child: Text(
                            'View Profile',
                            style: TextStyle(
                              color: AppColors.OrangePeel,
                              fontSize: width / 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
                              Navigator.of(context)
                                  .pushNamed('/AppointmentBooking');
                            },
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: width / 32,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                      SizedBox(height: 10)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
