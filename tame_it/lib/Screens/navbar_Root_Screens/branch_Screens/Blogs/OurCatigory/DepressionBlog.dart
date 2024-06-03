import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class DepressionArticle extends StatefulWidget {
  const DepressionArticle({Key? key}) : super(key: key);

  @override
  _DepressionArticleState createState() => _DepressionArticleState();
}

class _DepressionArticleState extends State<DepressionArticle> {
  Map<String, bool> expandedSections = {
    'Overview': false,
    'Symptoms': false,
    'Symptoms in Children and Adolescents': false,
    'Symptoms in Older Adults': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Depression',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
          backgroundColor: AppColors.whiteShade3),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/dep1.jpg",
                    fit: BoxFit.cover,
                    height: 200, // adjust height as needed
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: expandedSections.keys.map((section) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expandedSections[section] =
                                      !expandedSections[section]!;
                                });
                              },
                              child: Text(
                                section,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: Container(
                                child: expandedSections[section]!
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: _buildSectionContent(section),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionContent(String section) {
    switch (section) {
      case 'Overview':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                "assets/images/anx2.webp"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            const Text(
              'Depression is a mood disorder that causes persistent feelings of sadness and loss of interest. It affects mood, thinking, and behavior, leading to emotional and physical problems. Depression often requires long-term treatment but most people improve with medications, psychotherapy, or both.',
            ),
          ],
        );
      case 'Symptoms':
        return Column(
          children: [
            Text(
              'While depression may occur only once in a lifetime, individuals usually experience multiple episodes. During these episodes, symptoms occur most of the day, nearly every day, and may include:\n\n'
              '•	Feelings of sadness, crying, emptiness, or hopelessness\n\n'
              '•	Episodes of anger, irritability, or frustration over small matters\n\n'
              '•	Loss of interest or pleasure in most or all normal activities, such as sex, hobbies, or sports\n\n'
              '•	Sleep disturbances, including insomnia or excessive sleeping\n\n'
              '•	Fatigue and lack of energy, where even small tasks require more effort\n\n'
              '•	Loss of appetite and weight loss, or increased cravings and weight gain\n\n'
              '•	Anxiety, restlessness, or agitation\n\n'
              '•	Slowed thinking, speaking, or body movements\n\n'
              '•	Feelings of worthlessness or guilt, with a focus on past failures or self-blame \n\n'
              '•	Difficulty thinking, concentrating, making decisions, or remembering things\n\n'
              '•	Recurrent or continuous thoughts of death, suicidal thoughts, suicide attempts, or suicide\n\n'
              '•	Unexplained physical problems, such as back pain or headaches\n\n',
            ),
            Text(
                'Symptoms in many individuals with depression are severe enough to cause significant problems in daily activities, such as work, school, social activities, or relationships with others. Some individuals may feel overall misery and unhappiness without a known cause\n\n'),
          ],
        );
      case 'Symptoms in Children and Adolescents':
        return const Text(
          'Signs and common symptoms of depression in children and adolescents are similar to those in adults, but there may be some differences.\n\n'
          '•	In younger children, symptoms of depression may include sadness, irritability, excessive clinginess, anxiety, aches and pains, or refusal to go to school, along with failure to thrive.\n\n'
          '•	In adolescents, symptoms may include sadness, irritability, feelings of negativity and worthlessness, anger, poor school performance or attendance, feelings of being misunderstood and overly sensitive, recreational drug or alcohol use, excessive eating or sleeping, self-harm, loss of interest in normal activities, and social withdrawal.\n\n',
        );
      case 'Symptoms in Older Adults':
        return const Text(
          'Depression is not a normal part of aging and should not be dismissed. Unfortunately, depression in older adults is often underdiagnosed and untreated, and they may resist seeking help. Symptoms of depression in older adults can be different or less pronounced, such as:'
          '•	Memory problems or personality changes\n\n'
          '•	Physical pain or bodily discomfort\n\n'
          '•	Fatigue, loss of appetite, sleep problems, or decreased interest in sex—symptoms not caused by a medical condition or medication\n\n'
          '•	Desire to stay at home often instead of going out to engage with others or try new activities\n\n'
          '•	Feelings or suicidal thoughts, especially among older adults\n\n',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
