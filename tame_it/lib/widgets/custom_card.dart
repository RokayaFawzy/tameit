import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tame_it/values/values.dart';
import '../Models/Doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/Profile');
        },
        child: Card(
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(doctor.image)),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.firstName + doctor.lastName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          Text(doctor.specialty,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400)),
                          Text(doctor.price + ' EGP',
                              style: const TextStyle(
                                color: AppColors.deepsea,
                                fontWeight: FontWeight.w500,
                              )),
                          Row(children: [
                            const Icon(Icons.work_history_outlined,
                                size: 18, color: AppColors.deepsea),
                            const SizedBox(width: 5),
                            Text(
                              doctor.experienceYears,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ]),
                          Row(
                            children: [
                              const Icon(FeatherIcons.plusCircle,
                              size: 18,
                              color: AppColors.deepsea),
                              const SizedBox(width: 5),
                              Text(doctor.interest,),
                            ],
                          ),
                          const SizedBox(height: 4),
                          RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColors.OrangePeel,
                                    size: 1,
                                  ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              })
                        ])
                  ])
                ])));
  }
}
