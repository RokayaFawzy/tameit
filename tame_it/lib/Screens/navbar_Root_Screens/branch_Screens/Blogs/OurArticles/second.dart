import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class secondBlog extends StatefulWidget {
  const secondBlog({super.key});

  @override
  State<secondBlog> createState() => _secondBlogState();
}

class _secondBlogState extends State<secondBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Mental Health Awareness',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 14,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
          backgroundColor: AppColors.whiteShade3),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/second.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      ' Mental Health Awareness ',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mental health awareness is :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.deepsea),
                  ),
                  Text(
                    ' a fundamental pillar for building a society that is conscious and understanding of mental health issues. It plays a vital role in changing negative perceptions and stigmas associated with mental illnesses. In this article, we will explore the significant importance of mental health awareness and how it can contribute to improving the quality of life for individuals and society as a whole.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Early Recognition Firstly ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    ' mental health awareness enables individuals to recognize early symptoms of psychological problems and seek help in a timely manner. This early awareness can lead to effective therapeutic interventions and prevent the worsening of the mental condition.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Open Communication Secondly ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'awareness encourages individuals to speak openly about their psychological experiences, helping to break down barriers and build a strong social support network. This openness fosters solidarity and understanding among individuals, reducing feelings of isolation and loneliness.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Healthcare Knowledge Thirdly',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    ' awareness contributes to enhancing the knowledge of healthcare providers, professionals, and institutions about the importance of mental health, improving the quality of services provided and facilitating access to appropriate treatment.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Psychological Fitness Fourthly',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    ' awareness promotes individuals’ psychological fitness, helping them develop effective strategies for dealing with psychological challenges and daily stress. This contributes to better psychological balance and enhances emotional health and overall well-being.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Policy Change Finally',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                      ' mental health awareness helps change policies and practices at the community and institutional levels, contributing to the creation of a supportive environment that values and prioritizes mental health.'),
                  SizedBox(height: 10),
                  Text(
                    'In conclusion, mental health awareness is not just an educational campaign, but a comprehensive movement aimed at building a healthier and more understanding society towards psychological challenges. It represents an important step towards achieving mental well-being for all and is an integral part of comprehensive healthcare. Through ongoing awareness and support, we can all contribute to creating a brighter and healthier future for the coming generations.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.OrangePeel,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
