import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class FourthBlog extends StatefulWidget {
  const FourthBlog({super.key});

  @override
  State<FourthBlog> createState() => _FourthBlogState();
}

class _FourthBlogState extends State<FourthBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Maintaining children’s',
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
                    "assets/images/fourth.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Maintaining children’s',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'mental health Maintaining children’s mental health is one of the basic things that parents should pay special attention to. There are several factors that are recommended to avoid to ensure the healthy development of the child psychologically and emotionally, including:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.deepsea,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Verbal or physical violence: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                      'Parents should avoid using violence in any form as a means of discipline, as it can leave profound negative effects on the child’s psyche and lead to behavioral and emotional problems in the future.'),
                  SizedBox(height: 10),
                  Text(
                    '2. Emotional neglect:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Children need love, attention and encouragement from parents. Emotional neglect can lead to feelings of loneliness and insecurity, and may affect a child’s ability to build healthy relationships in the future.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Excessive academic pressure: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'While education is important, parents should avoid putting unrealistic academic pressure on children, which can lead to anxiety and low self-confidence.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '4. Underestimating the child’s feelings:  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'It is important for children to feel that their feelings are important and recognized. Underestimating their feelings can lead to problems with self-expression and communication.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '5. Comparison with others: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Compare the child with his siblings or peers should be avoided, as comparisons can lead to feelings of inferiority and jealousy and undermine self-confidence.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '6. Failure to provide a stable environment :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Children need a stable and predictable environment. Sudden and frequent changes in routine or living environment can lead to feelings of insecurity and anxiety.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '7. Inappropriate Content Exposure:  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepsea,
                    ),
                  ),
                  Text(
                    'Parents should monitor the content that children are exposed to, whether online or TV, and avoid content that can be disturbing or scary.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'It is important for parents to be aware that children’s mental health requires constant care and attention, and that a supportive and positive family environment is the basis for healthy and balanced development. Parents should lead by example in dealing with emotions and challenges, and provide the necessary support for their children to grow and thrive in a safe and loving environment.',
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
