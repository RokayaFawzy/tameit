import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tame_it/AdminScreens/appointments/ListAppointments.dart';
import 'package:tame_it/AdminScreens/appointments/ShowDoctorAppointment.dart';
import '../../values/values.dart';

class AppointmentsCard extends StatefulWidget {
  final Doctor doctor;

  AppointmentsCard({super.key, required this.doctor});

  @override
  State<AppointmentsCard> createState() => _AppointmentsCardState();
}

class _AppointmentsCardState extends State<AppointmentsCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: [
            Card(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: width * 0.25,
                      height: height * 0.25,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.firstName +
                              " " +
                              widget.doctor.lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.04,
                          ),
                        ),
                        Text(
                          widget.doctor.jobTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: width * 0.035,
                          ),
                        ),
                        Text(
                          '${widget.doctor.price} EGP',
                          style: TextStyle(
                            color: AppColors.deepsea,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.035,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work_history_outlined,
                              size: width * 0.04,
                              color: AppColors.deepsea,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${widget.doctor.yearsOfExperience}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03,
                              ),
                            ),
                          ],
                        ),
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
                                        : widget.doctor.specializations
                                            .join(", "),
                                    style: TextStyle(fontSize: width / 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
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
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: width * 0.3,
                              height: height * 0.05,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.deepsea,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowDoctorAppointments(
                                                doctorId: widget.doctor.id,
                                                )),
                                  );
                                },
                                child: Text(
                                  'Show Appointment',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
