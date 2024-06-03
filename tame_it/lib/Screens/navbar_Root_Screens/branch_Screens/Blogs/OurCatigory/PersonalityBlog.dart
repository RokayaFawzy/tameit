import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class BorderlinePersonalityDisorderBlog extends StatefulWidget {
  const BorderlinePersonalityDisorderBlog({Key? key}) : super(key: key);

  @override
  _BorderlinePersonalityDisorderBlogState createState() =>
      _BorderlinePersonalityDisorderBlogState();
}

class _BorderlinePersonalityDisorderBlogState
    extends State<BorderlinePersonalityDisorderBlog> {
  Map<String, bool> expandedSections = {
    'Borderline Personality Disorder': false,
    'Causes': false,
    'Risk Factors': false,
    'Complications': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Borderline Personality Disorder',
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
                    "assets/images/person2.jpg",
                    fit: BoxFit.cover,
                    height: 200,
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
      case 'Borderline Personality Disorder':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                "assets/images/person1.jpeg"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            const Text(
              'Borderline personality disorder (BPD) is a mental health condition that affects how individuals perceive themselves and others, making it difficult to perform daily life tasks. It involves a pattern of unstable, intense relationships as well as impulsiveness and an unhealthy self-image. Impulsiveness can manifest as intense emotions and acting on impulses without thinking first. Individuals with borderline personality disorder often have a profound fear of abandonment or loneliness. Despite a desire for peaceful, lasting relationships, their fear of abandonment often leads to mood swings and anger. This fear can also result in impulsiveness and self-harm, which may cause others to distance themselves. Borderline personality disorder typically begins in adolescence and worsens in young adulthood. Mood swings, anger, and impulsiveness often improve with age, but core issues related to self-perception, fear of abandonment, and relationship problems persist. If you have borderline personality disorder, know that many individuals with this condition improve with treatment. They can learn to live more stable and satisfying lives.',
            ),
          ],
        );
      case 'Causes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Like other mental health disorders, the exact causes of borderline personality disorder are not fully understood. In addition to environmental factors—such as a history of child abuse or neglect—borderline personality disorder may be associated with:',
            ),
            Text(
              '• Genetic predisposition: Some studies involving twins and families suggest that personality disorders may be inherited or closely linked with other mental health disorders within families.',
            ),
            Text(
              '• Brain changes: Research indicates that changes in specific brain regions can affect emotions, impulsivity, and aggression.',
            ),
          ],
        );
      case 'Risk Factors':
        return const Text(
          'Factors related to personality development that may increase the risk of developing borderline personality disorder (BPD) include:',
        );
      case 'Complications':
        return const Text(
          'Borderline personality disorder can negatively impact various aspects of life, affecting close relationships, employment, education, social activities, and self-perception. This can result in: • Frequent job changes or unemployment. • Incomplete education. • Legal problems, such as incarceration. • Conflict-ridden relationships, marital tension, or divorce. • Self-harm, such as cutting or burning, and recurrent hospitalizations. • Hostile relationships. • Unplanned pregnancies, sexually transmitted infections, car accidents, and physical altercations due to impulsive and risky behavior. • Suicide attempts or completed suicide. Additionally, individuals with borderline personality disorder may develop other mental health conditions, such as: • Depression. • Alcohol or substance use disorders. • Anxiety disorders. • Eating disorders. • Bipolar disorder. • Post-traumatic stress disorder (PTSD). • Attention-deficit/hyperactivity disorder (ADHD). • Other personality disorders.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
