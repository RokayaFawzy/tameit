import 'package:flutter/material.dart';

import '../../../../../values/values.dart';

class PTSDArticle extends StatefulWidget {
  const PTSDArticle({Key? key}) : super(key: key);

  @override
  _PTSDArticleState createState() => _PTSDArticleState();
}

class _PTSDArticleState extends State<PTSDArticle> {
  Map<String, bool> expandedSections = {
    'Overview': false,
    'Symptoms': false,
    'Causes': false,
    'Risk Factors': false,
    'Types of Traumatic Events': false,
    'Complications': false,
    'Prevention': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Post-Traumatic Stress Disorder (PTSD)',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 14,
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
                    "assets/images/ptsd1.jpg",
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
                "assets/images/ptsd2.png"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            const Text(
              'Post-Traumatic Stress Disorder (PTSD) is a mental health condition triggered by a terrifying event—either experiencing it or witnessing it. Symptoms may include flashbacks, nightmares, severe anxiety, and uncontrollable thoughts about the event. Most people who go through traumatic events may have temporary difficulty adjusting and coping, but with time and good self-care, they usually get better. If the symptoms worsen or last for months or even years and interfere with your daily life, you may be experiencing PTSD. Effective treatment soon after symptoms develop can be critical to reduce symptoms and improve function.',
            ),
          ],
        );
      case 'Symptoms':
        return const Text(
          'PTSD symptoms may start within one month of a traumatic event, but sometimes they may not appear until years after the event. These symptoms can cause significant problems in social or work situations and in relationships. They can also interfere with your ability to perform your usual daily tasks. PTSD symptoms are generally grouped into four types: intrusive memories, avoidance, negative changes in thinking and mood, and changes in physical and emotional reactions. Symptoms can vary over time or from person to person.',
        );
      case 'Causes':
        return const Text(
          'PTSD can develop when you go through, see, or learn about an event involving actual or threatened death, serious injury, or sexual violation. Doctors don\'t know exactly why some people develop PTSD. Like most mental health problems, PTSD is probably caused by a mix of stressful experiences, inherited mental health risks, inherited traits of personality, and the way your brain regulates stress response chemicals and hormones.',
        );
      case 'Risk Factors':
        return const Text(
          'People of all ages can develop post-traumatic stress disorder. However, certain factors may increase the risk of developing this disorder after exposure to trauma, such as exposure to long-lasting acute stress, previous trauma in life, working in a job that increases exposure to traumatic events, having mental health problems, struggling with substance misuse issues, lack of strong family or friend support system, and having relatives with mental health problems.',
        );
      case 'Types of Traumatic Events':
        return const Text(
          'Some of the most common events that can lead to developing post-traumatic stress disorder (PTSD) include exposure to combat situations, physical abuse during childhood, sexual violence, physical assault, being threatened with a weapon, and accidents. There are many other traumatic events that can also lead to PTSD, such as fires, natural disasters, robberies, plane crashes, torture, kidnapping, life-threatening illnesses, terrorist attacks, and other severe or life-threatening events.',
        );
      case 'Complications':
        return const Text(
          'PTSD can disrupt your entire life, including your job, relationships, health, and enjoyment of daily activities. Having PTSD can also increase the risk of developing other mental health problems, such as depression and anxiety, substance use problems or alcohol misuse, eating disorders, and suicidal thoughts and behaviors.',
        );
      case 'Prevention':
        return const Text(
          'Timely support and assistance can prevent natural stress responses from worsening into PTSD. This might involve seeking support from family and friends who will listen and provide comfort, seeking out a mental health professional for a short course of therapy, or seeking support from faith community. Support from others can help prevent turning to unhealthy coping methods, such as alcohol or drug addiction.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
