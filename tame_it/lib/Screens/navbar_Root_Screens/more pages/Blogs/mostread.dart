import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

import '../../../../widgets/custom_button.dart';

class MostRead extends StatelessWidget {
  const MostRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: AppColors.white,
              width: 300,
              height: 250,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/t2.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Positioned(
                    top: 13,
                    left: 175,
                    right: 7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Color(0xFFD9D9D9),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Psychotherapy',
                          style: TextStyle(
                            color: AppColors
                                .deepsea, // Adjust color to match your design
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        'How family problems affect the psyche of the child',
                        style: TextStyle(
                          color:
                              Colors.black, // Adjust color to match your design
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines:
                            3, // You can adjust this to control the maximum lines
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    left: 150,
                    right: 5,
                    child: Container(
                      width: 0.5,
                      child: CustomButton(
                        title: 'Read this',
                        color: AppColors.deepsea,
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: AppColors.white,
              width: 300,
              height: 250,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/t2.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Positioned(
                    top: 13,
                    left: 175,
                    right: 7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Color(0xFFD9D9D9),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Psychotherapy',
                          style: TextStyle(
                            color: AppColors
                                .deepsea, // Adjust color to match your design
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        'How family problems affect the psyche of the child',
                        style: TextStyle(
                          color:
                              Colors.black, // Adjust color to match your design
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines:
                            3, // You can adjust this to control the maximum lines
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    left: 150,
                    right: 5,
                    child: Container(
                      width: 0.5,
                      child: CustomButton(
                        title: 'Read this',
                        color: AppColors.deepsea,
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: AppColors.white,
              width: 300,
              height: 250,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/t2.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Positioned(
                    top: 13,
                    left: 175,
                    right: 7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Color(0xFFD9D9D9),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Psychotherapy',
                          style: TextStyle(
                            color: AppColors
                                .deepsea, // Adjust color to match your design
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        'How family problems affect the psyche of the child',
                        style: TextStyle(
                          color:
                              Colors.black, // Adjust color to match your design
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines:
                            3, // You can adjust this to control the maximum lines
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    left: 150,
                    right: 5,
                    child: Container(
                      width: 0.5,
                      child: CustomButton(
                        title: 'Read this',
                        color: AppColors.deepsea,
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 13),
        ],
      ),
    );
  }
}
