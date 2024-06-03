import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class fiveBlog extends StatefulWidget {
  const fiveBlog({super.key});

  @override
  State<fiveBlog> createState() => _fiveBlogState();
}

class _fiveBlogState extends State<fiveBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Promoting children’s mental health ',
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
                    "assets/images/fiveth.jpeg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Promoting children’s mental health ',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'mental health is essential to ensure their proper growth and overall development. Here are some effective ways to boost children’s mental health:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Provide love and support: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                      'Children need to feel safe and loved by their parents. Showing love can be through words, actions, and body language such as hugging and smiling.'),
                  SizedBox(height: 10),
                  Text(
                    '2. Effective communication: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'It is very important that the child finds someone to listen to and talk to. Communication strengthens family bonds and helps the child feel heard and appreciated.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Outdoor Activities: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Play and interact with nature can help children discover the world around them and enhance their cognitive and physical abilities.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '4. Teaching problem-solving skills: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    ' Teaching children how to deal with challenges and solve problems in a positive way can help them develop self-confidence and independence.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '5. Encourage social communication: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Enhancing children’s social communication skills helps them build healthy relationships and gives them a sense of belonging.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '6. Family Stability: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Providing a stable and predictable home environment that helps children feel safe and reduces anxiety and stress.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '7. Play and Learn: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Play is an important means of learning and developing children’s mental and self-abilities, and they should be encouraged to play creatively and educationally.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '8. Respect for the child’s privacy and freedom of expression:  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Giving children the opportunity to express themselves and respect their opinions helps develop their personality and self-confidence.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '9. Avoid violence of all kinds: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Parents should avoid the use of verbal or physical violence and provide positive verbal support to avoid psychological harm to children.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '10. Capacity and Talent Development: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Encouraging children to explore their talents and develop their abilities helps build self-confidence and enhances their love of learning.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '11. Positive dealing with the child: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Parents should deal with children in a positive way and avoid negative criticism that may affect their view of themselves.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '12. Positive Dealing with Emotions:  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Teaching children how to deal with different emotions in a healthy way helps develop their ability to recover from difficult times.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'It is important for parents to realize that promoting children’s mental health requires constant effort and providing a supportive environment that helps children grow up healthy and balanced. Children are the future of society, and investing in their mental health is investing in a bright future for them and society as a whole.',
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
