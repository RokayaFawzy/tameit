import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class FirstBlog extends StatefulWidget {
  const FirstBlog({super.key});

  @override
  State<FirstBlog> createState() => _FirstBlogState();
}

class _FirstBlogState extends State<FirstBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'A Deeper Understanding of Mental Well-Being',
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
                    "assets/images/first1.png",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Mental Health: A Deeper Understanding of Mental Well-Bein',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mental health is an integral part of overall health and deserves attention and care just like physical illnesses. In our world today, awareness of mental health is increasing, and the negative stigma associated with it is gradually changing. Mental illnesses are not a sign of weakness or madness; they are health conditions that can affect anyone, regardless of age, gender, or cultural background.',
                    style: TextStyle(color: AppColors.deepsea),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Raising awareness about mental health means understanding that mental illnesses have multiple causes, including biological, psychological, and environmental factors. They can arise from painful life experiences, such as trauma or chronic stress, as well as chemical changes in the brain. A deep understanding of these causes helps provide necessary support and appropriate treatment for affected individuals.',
                    style: TextStyle(color: AppColors.deepsea),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'It’s also essential to emphasize that seeking psychological treatment is not a sign of weakness; rather, it’s a courageous step toward healing and mental balance. Encouraging people to seek help when needed and offering support without judgment is crucial. Applications and platforms aimed at mental health awareness play a significant role in changing social perceptions and providing accurate information and necessary resources.',
                    style: TextStyle(color: AppColors.deepsea),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mental health is not merely the absence of illnesses; it’s a state of well-being that allows individuals to realize their potential, cope with life’s natural pressures, work productively, and contribute to their communities. Therefore, efforts to promote mental health and support those facing challenges in this area are essential for building a healthier and more cohesive society.',
                    style: TextStyle(color: AppColors.deepsea),
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
