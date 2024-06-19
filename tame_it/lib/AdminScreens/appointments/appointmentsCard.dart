import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Models/Doctor_model.dart';
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
            child: Card(
                color: Colors.white,
                child: Row(children: [
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
                              child: Image.asset(
                                widget.doctor.image,
                                fit: BoxFit.cover,
                              )))),
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
                            )),
                        Text(widget.doctor.specialty,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.035,
                            )),
                        Text(widget.doctor.price + ' EGP',
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.035,
                            )),
                        Row(children: [
                          Icon(
                            Icons.work_history_outlined,
                            size: width * 0.04,
                            color: AppColors.deepsea,
                          ),
                          SizedBox(width: 5),
                          Text(widget.doctor.experienceYears,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03,
                              ))
                        ]),
                        Row(children: [
                          Icon(
                            FeatherIcons.plusCircle,
                            size: width * 0.04,
                            color: AppColors.deepsea,
                          ),
                          SizedBox(width: 5),
                          Text(widget.doctor.interest,
                              style: TextStyle(
                                fontSize: width * 0.035,
                              ))
                        ]),
                        SizedBox(height: 4),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: width * 0.05,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColors.OrangePeel,
                          ),
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
                                        Navigator.of(context).pushNamed(
                                            '/ShowDoctorAppointments');
                                      },
                                      child: Text('Show Appointment',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.w600,
                                          ))))),
                        ),
                        SizedBox(height: 10),
                      ]))
                ]))));
  }
}
