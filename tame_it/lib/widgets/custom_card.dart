import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tame_it/values/values.dart';
import '../Models/Doctor_model.dart';

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
          Navigator.of(context).pushNamed('/Profile');
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
                color: Colors.white,
                child: Row(children: [
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
                              child: Image.asset(
                                widget.doctor.image,
                                fit: BoxFit.cover,
                              )))),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.firstName + widget.doctor.lastName,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: width / 25),
                        ),
                        Text(widget.doctor.specialty,
                            style: TextStyle(fontWeight: FontWeight.w400)),
                        Text(widget.doctor.price + ' EGP',
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontWeight: FontWeight.w500,
                            )),
                        Row(children: [
                          const Icon(Icons.work_history_outlined,
                              size: 18, color: AppColors.deepsea),
                          const SizedBox(width: 5),
                          Text(
                            widget.doctor.experienceYears,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          )
                        ]),
                        Row(children: [
                          const Icon(FeatherIcons.plusCircle,
                              size: 18, color: AppColors.deepsea),
                          const SizedBox(width: 5),
                          Text(
                            widget.doctor.interest,
                            style: TextStyle(fontSize: width / 25),
                          )
                        ]),
                        const SizedBox(height: 4),
                        RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            // allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: AppColors.OrangePeel,
                                  size: 1,
                                ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            }),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width / 3.5,
                                height: height / 20,
                                child: TextButton(
                                  onPressed: () {},
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
                                            MaterialStatePropertyAll(
                                                AppColors.deepsea)),
                                    onPressed: () {},
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: width / 32,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ])
                      ])
                ]))));
  }
}
