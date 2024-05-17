import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class GADBlog extends StatefulWidget {
  const GADBlog({Key? key}) : super(key: key);

  @override
  _GADBlogState createState() => _GADBlogState();
}

class _GADBlogState extends State<GADBlog> {
  Map<String, bool> expandedSections = {
    'Generalized Anxiety Disorder (GAD)': false,
    'Symptoms of Generalized Anxiety Disorder': false,
    'Diagnosis of Generalized Anxiety Disorder': false,
    'Treatment of Generalized Anxiety Disorder': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Generalized Anxiety Disorder (GAD)',
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
                    "assets/images/anx1.jpg",
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
      case 'Generalized Anxiety Disorder (GAD)':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/anx2.webp"),
            const SizedBox(height: 10),
            Text(
              'Generalized Anxiety Disorder (GAD) involves excessive nervousness and worry about a variety of activities or events; individuals with GAD experience anxiety most days for six months or more.\n\n'
              '• Patients feel anxious and preoccupied about a range of issues, activities, and circumstances, not just one type.\n\n'
              '• For a diagnosis of this disorder, the anxiety must be accompanied by other symptoms (such as easy fatigue, difficulty concentrating, muscle tension).\n\n'
              '• Treatment typically involves a combination of medications (usually anti-anxiety medications and sometimes antidepressants) and psychotherapy.\n\n'
              'Generalized anxiety disorder is a common type of anxiety disorder, occurring in about 3% of adults within any 12-month period. It is twice as likely to affect women as men. It often begins in childhood or adolescence (see Generalized Anxiety Disorder in Children), but it can start at any age.\n\n'
              'For most people, the disorder fluctuates, worsening at times (especially during stressful periods) and lasting for many years.',
            ),
          ],
        );
      case 'Symptoms of Generalized Anxiety Disorder':
        return const Text(
          'Individuals suffering from generalized anxiety disorders constantly feel anxious or distressed and have difficulty controlling these feelings. The intensity, frequency, or duration of fears is greater than necessary for the situation or circumstance.'
          '\n\n'
          'These fears are general in nature, encompassing a variety of topics, and often shift from one subject to another over time. Common fears include work and family responsibilities, financial concerns, health, safety, car problems, and household chores.',
        );
      case 'Diagnosis of Generalized Anxiety Disorder':
        return const Text(
          '•	Evaluation by a physician based on qualitative criteria To diagnose generalized anxiety disorder, the person must experience excessive anxiety or preoccupation that:\n'
          '• Is excessive\n'
          '• Concerns a number of activities and events\n'
          '• Is present most days for at least six months\n\n'
          'Additionally, the person must have three or more of the following symptoms:\n'
          '• Restlessness or feeling on edge\n'
          '• Easily fatigued\n'
          '• Difficulty concentrating\n'
          '• Irritability\n'
          '• Muscle tension\n'
          '• Disturbed sleep\n\n'
          'Before diagnosing generalized anxiety disorder, doctors conduct a clinical examination. They may also request blood tests or other tests to ensure that the symptoms are not caused by a physical disorder or medication use.',
        );
      case 'Treatment of Generalized Anxiety Disorder':
        return const Text(
          'The disorder is often managed with a combination of some forms of psychotherapy and drug therapy. Psychotherapy can address the causes of anxiety and provide coping mechanisms.'
          '\n\n'
          'Some antidepressants, especially selective serotonin reuptake inhibitors (such as escitalopram) and serotonin-norepinephrine reuptake inhibitors (such as venlafaxine), are effective for generalized anxiety disorder. These antidepressants usually take a few weeks to alleviate anxiety, so some individuals are initially given benzodiazepines alongside antidepressants. Benzodiazepines are fast-acting anti-anxiety medications that usually provide rapid relief. However, because long-term use of benzodiazepines can lead to drug misuse, these medications are typically given for a relatively short period. Once the antidepressant and psychotherapy are effective, the dose of benzodiazepines can be slowly reduced and then stopped. Benzodiazepines should not be abruptly discontinued.'
          '\n\n'
          'Buspirone, another anti-anxiety medication, is effective for some individuals with generalized anxiety disorder. Its use does not lead to drug misuse (addiction). However, buspirone may take two weeks or more to begin working.'
          '\n\n'
          'Herbal products such as kava and passionflower may have anti-anxiety effects, although their effectiveness and safety in treating anxiety disorders such as generalized anxiety disorder require further study.'
          '\n\n'
          'Cognitive-behavioral therapy has been found to be beneficial for generalized anxiety disorder. In this therapy, individuals learn to:'
          '\n'
          '• Identify thinking problems\n'
          '• Control these problems\n'
          '• Modify behavior accordingly',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
