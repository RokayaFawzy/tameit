import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../values/values.dart';

class thirdBlog extends StatefulWidget {
  const thirdBlog({super.key});

  @override
  State<thirdBlog> createState() => _thirdBlogState();
}

class _thirdBlogState extends State<thirdBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Children’s Mental Health',
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
                    "assets/images/thired.jpg",
                    width: double
                        .infinity, // Make the image fit the container width
                    height: 175, // Make the image fill the container height
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire container
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      ' Children’s Mental Health and How It Affects Them: How Parents Can Help ',
                      style: TextStyle(
                          color: AppColors.OrangePeel,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                      'The mental health of our children is crucial. Not only does mental health affect physical health, but untreated mental health problems interfere with learning, socialization, self-esteem, and other important aspects of child development that can have lifelong repercussions. And for some children, untreated mental health problems lead to suicide. So pay attention, and take what you see seriously. ',
                       style: TextStyle(color: AppColors.deepsea),),
                  SizedBox(height: 10),
                  Text(
                      'If your child is showing signs of anxiety or depression, call your doctor. Don’t put it off. If your child talks about harming themselves or others, get help immediately, such as by going to your local emergency room. In this situation, it’s better to overreact than underreact.',
                       style: TextStyle(color: AppColors.deepsea),),
                  SizedBox(height: 10),
                  Text(
                      'Parents can play a pivotal role in supporting their children’s mental health through various ways, such as expressing love and continuous support, using positive methods to guide their behavior, dedicating time to talk and listen to them, engaging in outdoor activities, and resolving problems positively. Encouraging children to communicate with others helps them feel valued in the world and learn effective communication skills.',
                       style: TextStyle(color: AppColors.deepsea),),
                  SizedBox(height: 10),
                  Text(
                      'It’s also essential for parents to recognize signs of mental health issues in children, such as changes in thinking, difficulty concentrating, negative thoughts, declining academic performance, and feelings of despair or helplessness. Taking these signs seriously and seeking professional help when needed is crucial.',
                       style: TextStyle(color: AppColors.deepsea),),
                  SizedBox(height: 10),
                  Text(
                      'Prioritizing children’s mental health can be achieved through policies and laws that promote and protect mental well-being. ',
                       style: TextStyle(color: AppColors.deepsea),),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      launch(
                          'https://www.health.harvard.edu/blog/the-mental-health-crisis-among-children-and-teens-how-parents-can-help-202203082700');
                    },
                    child: Text(
                      'Providing support to caregivers enables them to offer the necessary care for their children',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
