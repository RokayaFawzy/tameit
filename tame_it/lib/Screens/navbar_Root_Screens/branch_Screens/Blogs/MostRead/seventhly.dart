import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class seventhlyBlog extends StatefulWidget {
  const seventhlyBlog({super.key});

  @override
  State<seventhlyBlog> createState() => _seventhlyBlogState();
}

class _seventhlyBlogState extends State<seventhlyBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Providing psychological awareness courses to students by teachers ',
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
                    "assets/images/seventhly.webp",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Providing psychological awareness courses to students by teachers',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Providing psychological awareness courses to students by teachers Providing psychological awareness courses to students by teachers In the world of education, the role of teachers is not limited to the transfer of academic knowledge, but extends to include an essential role in promoting the mental health of students. Offering psychological awareness courses in schools is an important step towards achieving this goal, as these courses can play a vital role in providing the necessary support for students to face the psychological and emotional challenges they may face.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,                      color: AppColors.deepsea,
),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The importance of psychological awareness courses ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                      'Psychological awareness courses teach students how to recognize and deal with emotions, and provide them with the tools to build psychological and emotional resilience. It also helps reduce the stigma associated with psychological problems and encourages students to seek help when needed.'),
                  SizedBox(height: 10),
                  Text(
                    'The role of teachers in providing courses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    'Teachers can deliver psychological awareness courses through the use of specially designed learning materials, which include information about mental health and how to deal with stress. These courses can also be integrated into the regular curriculum or offered as additional activities.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Professional Training for Teachers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    ' In order for teachers to be qualified to offer these courses, it is essential that they receive vocational training covering the basics of mental health and how to recognize the warning signs of students’ psychological problems. Schools can organize teacher training workshops in collaboration with mental health professionals.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Collaborate with families and the community',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    'It is important that psychological awareness sessions are delivered in collaboration with families and the local community to ensure a comprehensive support network for students. Schools can organise awareness sessions for parents to inform them about the importance of mental health and how they can support their children.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Leveraging technology ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    'Technology can be used to enhance the delivery of psychological awareness courses through educational programs and applications that help communicate information in an innovative and engaging way for students.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Provision of resources and services ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    'Schools should provide resources and services to support mental health, such as counselors and student support programs, to help students deal with psychological challenges.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Evaluation and follow-up of courses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,                      color: AppColors.deepsea,

                    ),
                  ),
                  Text(
                    'It is necessary to evaluate the effectiveness of psychological awareness courses and follow up on their impact on students. Schools can collect data and feedback from students and teachers to continuously improve and develop courses',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In conclusion, teachers can play a pivotal role in providing psychological awareness courses to students, which are an integral part of comprehensive and integrated education. Through vocational training, collaboration with families and the community, and the use of technology, teachers can enhance students’ mental health and equip them to face life’s challenges with confidence and competence.',
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
