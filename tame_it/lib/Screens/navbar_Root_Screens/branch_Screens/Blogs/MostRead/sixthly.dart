import 'package:flutter/material.dart';
import '../../../../../values/values.dart';

class sixthlyBlog extends StatefulWidget {
  const sixthlyBlog({super.key});

  @override
  State<sixthlyBlog> createState() => _sixthlyBlogState();
}

class _sixthlyBlogState extends State<sixthlyBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'The role of teachers in supporting students’ mental health ',
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
                    "assets/images/sixthly.png",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'The role of teachers in supporting students’ mental health ',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Teachers play a vital role in supporting pupils’ mental health and are on the front lines of classroom education and socialization. Teachers’ responsibility is not limited to communicating academic information, but also to provide a learning environment that promotes mental health and helps students develop their social and emotional skills.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Provide psycho-emotional support ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                      'Teachers can provide psychological support by creating positive relationships with students, and providing a safe and welcoming environment within the classroom. Teachers should be alert to any signs of psychological problems students may be facing and work to address them in collaboration with specialists when necessary.'),
                  SizedBox(height: 10),
                  Text(
                    'Tutorial Development ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Educational programs should include materials that help develop the psychological and emotional awareness of students. Teachers can integrate activities that enhance life skills,such as effective communication and problem-solving, into the curriculum.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Professional Training for Teachers ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    ' It is important that teachers receive appropriate training to be able to recognize and deal with the psychological needs of students effectively. Training should include topics such as mental health, how to deal with stress, and relaxation techniques.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cooperation with family and community',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Teachers should work closely with families and the community to ensure that students are provided with psychological support. Schools can organise workshops and awareness sessions for parents on how to support their children’s mental health.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Use of technology ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Teachers can use technology to support students’ mental health through educational programs and apps that promote self-awareness, emotional control and communication skills.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Provision of resources and services ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Schools should provide resources and services to support mental health, such as counselors and student support programs, to help students deal with psychological challenges.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Promoting mental health in school policies ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'School policies should reflect the institution’s commitment to supporting students’ mental health by developing procedures and protocols that ensure a supportive and stimulating learning environment',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In conclusion, the role of teachers in supporting the mental health of pupils is essential to achieving inclusive and integrated education. By providing psycho-emotional support, developing educational programs, vocational training, collaborating with families and the community, using technology, providing resources and services, and promoting mental health in school policies, teachers can effectively contribute to building a generation capable of facing psychological and emotional challenges with confidence and competence.',
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
