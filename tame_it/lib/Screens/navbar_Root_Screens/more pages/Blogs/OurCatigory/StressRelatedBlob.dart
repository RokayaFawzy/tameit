import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class StressRelatedDisorders extends StatefulWidget {
  const StressRelatedDisorders({Key? key}) : super(key: key);

  @override
  _StressRelatedDisordersState createState() => _StressRelatedDisordersState();
}

class _StressRelatedDisordersState extends State<StressRelatedDisorders> {
  Map<String, bool> expandedSections = {
    'Stress-related Disorders': false,
    'Symptoms': false,
    'Diagnosis': false,
    'Treatment': false,
    'When to See a Doctor': false,
    'Causes': false,
    'Risk Factors': false,
    'Complications': false,
    'Prevention': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'Stress-related Disorders',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
        backgroundColor: AppColors.whiteShade3,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/stress1.jpg",
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to start
                      children: expandedSections.keys.map((section) {
                        return Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
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
                                textAlign: TextAlign.start,
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
      case 'Stress-related Disorders':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/stress2.webp",
            ),
            const SizedBox(height: 10),
            Text(
              'Sometimes, experiencing anxiety is a natural part of life. However, individuals with anxiety disorders often have excessive and persistent fears and worries about everyday situations. Anxiety disorders often involve recurring episodes of intense anxiety, fear, or panic that peak within minutes (panic attacks).\n\n'
              'These feelings of anxiety and panic interfere with daily activities, are difficult to control, and are disproportionate to the actual danger. They can persist for a long time, and some people may avoid certain places or situations to prevent these feelings. Symptoms may begin during childhood, adolescence, and continue into adulthood.\n\n'
              'Examples of anxiety disorders include generalized anxiety disorder (GAD), social anxiety disorder (social phobia), specific phobias, and separation anxiety disorder. It\'s possible to have more than one anxiety disorder. Sometimes anxiety can result from a medical condition that needs treatment.\n\n'
              'Regardless of the form your anxiety takes, therapy can help you overcome it.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Symptoms':
        return const Text(
          'Common signs and symptoms of anxiety include:\n'
          '- Feeling nervous, anxious, or tense\n'
          '- Feeling a sense of impending danger, panic, or doom\n'
          '- Increased heart rate\n'
          '- Rapid breathing (hyperventilation)\n'
          '- Sweating\n'
          '- Trembling\n'
          '- Feeling weak or tired\n'
          '- Trouble concentrating or thinking about anything other than the present worry\n'
          '- Having trouble sleeping\n'
          '- Experiencing gastrointestinal (GI) problems\n'
          '- Having difficulty controlling worry\n'
          '- Having the urge to avoid things that trigger anxiety',
          style: TextStyle(fontSize: 16),
        );
      case 'Diagnosis':
        return const Text(
          'To diagnose stress-related disorders, doctors often conduct evaluations based on qualitative criteria. These disorders typically involve excessive anxiety or preoccupation that:\n'
          '- Is excessive\n'
          '- Concerns a number of activities and events\n'
          '- Is present most days for at least six months\n\n'
          'Additionally, individuals must have several symptoms, including restlessness, fatigue, difficulty concentrating, irritability, muscle tension, and disturbed sleep. A clinical examination may be performed, and blood tests or other tests may be requested to rule out physical disorders or medication-related causes.',
          style: TextStyle(fontSize: 16),
        );
      case 'Treatment':
        return const Text(
          'Treatment for stress-related disorders often involves a combination of therapy and medication. Psychotherapy can address the underlying causes of anxiety and provide coping mechanisms. Some common medications used include antidepressants, anti-anxiety medications, and beta-blockers. In severe cases, hospitalization may be necessary.\n\n'
          'The choice of treatment depends on the specific disorder, its severity, and individual circumstances. It\'s essential to work closely with healthcare providers to develop a personalized treatment plan.',
          style: TextStyle(fontSize: 16),
        );
      case 'When to See a Doctor':
        return const Text(
          'Seek medical help if you experience excessive anxiety that negatively impacts your life or if you have difficulty controlling your feelings of fear, tension, or anxiety. It\'s especially crucial to seek help if you experience symptoms of depression, substance abuse, or other mental health issues related to anxiety. If you have suicidal thoughts or behaviors, seek emergency treatment immediately.\n\n'
          'Early intervention is key to effective treatment, so don\'t hesitate to reach out to a doctor or mental health care provider.',
          style: TextStyle(fontSize: 16),
        );
      case 'Causes':
        return const Text(
          'The causes of stress-related disorders are complex and multifaceted. They may involve a combination of genetic, environmental, and psychological factors. Life experiences, such as trauma or significant stress, can trigger these disorders in individuals predisposed to anxiety. Medical conditions, such as heart disease or thyroid disorders, may also contribute to anxiety symptoms.\n\n'
          'Understanding the underlying causes of stress-related disorders can help guide treatment and support strategies.',
          style: TextStyle(fontSize: 16),
        );
      case 'Risk Factors':
        return const Text(
          'Several factors may increase the risk of developing stress-related disorders. These include:\n'
          '- Trauma: Exposure to abuse, violence, or other traumatic events\n'
          '- Chronic stress: Prolonged exposure to stressful situations\n'
          '- Genetics: Family history of anxiety or related disorders\n'
          '- Medical conditions: Certain medical conditions or illnesses\n'
          '- Substance abuse: Misuse of drugs or alcohol\n'
          '- Personality traits: Certain personality characteristics may predispose individuals to anxiety\n\n'
          'Identifying and addressing these risk factors can help reduce the likelihood of developing stress-related disorders.',
          style: TextStyle(fontSize: 16),
        );
      case 'Complications':
        return const Text(
          'Stress-related disorders can have significant complications if left untreated. These may include:\n'
          '- Worsening anxiety: Symptoms may become more severe over time\n'
          '- Impact on daily life: Anxiety can interfere with work, relationships, and daily activities\n'
          '- Physical health problems: Chronic stress can contribute to various health issues\n'
          '- Mental health disorders: Anxiety disorders may co-occur with depression or substance abuse\n'
          '- Impaired quality of life: Anxiety can diminish overall well-being and satisfaction\n\n'
          'Prompt treatment and support can help prevent or mitigate these complications.',
          style: TextStyle(fontSize: 16),
        );
      case 'Prevention':
        return const Text(
          'While it may not be possible to prevent stress-related disorders entirely, there are steps individuals can take to reduce their risk:\n'
          '- Manage stress: Develop healthy coping mechanisms for managing stress\n'
          '- Seek support: Build a strong support network of friends, family, and professionals\n'
          '- Practice self-care: Prioritize activities that promote physical and mental well-being\n'
          '- Address underlying issues: Seek treatment for any underlying medical or psychological conditions\n'
          '- Educate yourself: Learn about stress, anxiety, and healthy ways to cope\n\n'
          'By taking proactive steps, individuals can empower themselves to better manage stress and reduce the likelihood of developing stress-related disorders.',
          style: TextStyle(fontSize: 16),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
