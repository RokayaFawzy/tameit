import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class SchizophreniaBlog extends StatefulWidget {
  const SchizophreniaBlog({Key? key}) : super(key: key);

  @override
  _SchizophreniaBlogState createState() => _SchizophreniaBlogState();
}

class _SchizophreniaBlogState extends State<SchizophreniaBlog> {
  Map<String, bool> expandedSections = {
    'What is Schizophrenia?': false,
    'Difference between Schizophrenia and Dissociative Identity Disorder (Multiple Personality Disorder)':
        false,
    'Causes of Schizophrenia': false,
    'Risk Factors for Schizophrenia': false,
    'Early Symptoms of Schizophrenia': false,
    'Symptoms of Schizophrenia': false,
    'Difference between Psychosis and Schizophrenia': false,
    'Diagnosis of Schizophrenia': false,
    'Treatment of Schizophrenia': false,
    'Management and Coping Strategies': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Schizophrenia',
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
                    "assets/images/schizo1.jpg",
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
      case 'What is Schizophrenia?':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/schizo2.jpg",
            ),
            const SizedBox(height: 10),
            Text(
              'Schizophrenia, also known as split personality disorder or simply schizophrenia, is a severe and chronic mental illness that affects a person\'s thinking, perception, and behavior, causing them to appear disconnected from reality. Individuals with schizophrenia often experience delusions, hallucinations, and disruptions in thinking and behavior that impair their ability to carry out daily tasks and impact their social relationships.',
            ),
          ],
        );
      case 'Difference between Schizophrenia and Dissociative Identity Disorder (Multiple Personality Disorder)':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Many people mistakenly believe that individuals with schizophrenia have multiple personalities. However, this is not accurate. Dissociative Identity Disorder (DID), previously known as multiple personality disorder, is a distinct mental disorder characterized by the presence of two or more distinct identities or personality states that control a person\'s behavior. Each identity may have its own unique identity, age, ethnicity, and gender.',
            ),
          ],
        );
      case 'Causes of Schizophrenia':
        return const Text(
          'The causes of schizophrenia are not precisely known, but it is believed to result from several factors, including:\n'
          '1. Genetic predisposition\n'
          '2. Neurotransmitter imbalance\n'
          '3. Brain structure changes',
        );
      case 'Risk Factors for Schizophrenia':
        return const Text(
          'Several factors increase the risk of developing schizophrenia, including:\n'
          '- Prenatal exposure to viruses or toxins\n'
          '- Drug use\n'
          '- Advanced paternal age\n'
          '- Psychological stress or trauma',
        );
      case 'Early Symptoms of Schizophrenia':
        return const Text(
          'Symptoms of schizophrenia may appear suddenly, but in most cases, they develop gradually with warning signs lasting months or years before the onset of acute psychotic episodes.\n'
          'Early symptoms of schizophrenia in teenagers may include:\n'
          '- Social isolation and withdrawal from family and friends\n'
          '- Decline in academic performance\n'
          '- Depression and lack of motivation\n'
          '- Mood changes',
        );
      case 'Symptoms of Schizophrenia':
        return const Text(
          'Symptoms of schizophrenia vary in severity, duration, and frequency among individuals and include:\n'
          '- Positive symptoms (psychotic symptoms):\n'
          '  - Delusions\n'
          '  - Hallucinations\n'
          '  - Disorganized speech, behavior, and movement.\n'
          '- Negative symptoms:\n'
          '  - Social withdrawal and isolation\n'
          '  - Lack of motivation to perform basic tasks\n'
          '  - Difficulty speaking\n'
          '  - Emotional blunting, characterized by reduced responsiveness, limited eye contact, fixed facial expressions, and a flat tone of speech.',
        );
      case 'Difference between Psychosis and Schizophrenia':
        return const Text(
          'The distinction between psychosis and schizophrenia is that psychosis refers to a set of symptoms including delusions and hallucinations that can occur with various medical and psychiatric conditions, or substance use, while schizophrenia is a specific mental disorder characterized by multiple symptoms including positive, negative, and cognitive symptoms.',
        );
      case 'Diagnosis of Schizophrenia':
        return const Text(
          'The diagnosis of schizophrenia involves a medical history, physical examination, and exclusion of other conditions that could cause similar symptoms such as substance abuse. Additional tests may include blood tests, urine tests, computed tomography (CT) scans, or magnetic resonance imaging (MRI) to rule out brain lesions.\n\n'
          'A psychiatric evaluation based on the criteria outlined in the Diagnostic and Statistical Manual of Mental Disorders (DSM-5) is used to assess the presence of schizophrenia symptoms lasting for at least one month, including one of the first three symptoms.\n'
          'The symptoms of schizophrenia include:\n'
          '- Delusions.\n'
          '- Hallucinations.\n'
          '- Disorganized speech.\n'
          '- Disorganized or catatonic behavior.\n'
          '- Negative symptoms such as difficulty speaking, emotional blunting, or lack of will.\n\n'
          'In addition, these symptoms are often accompanied by a decline in occupational or educational functioning, reduced interaction with others, and impaired ability for self-care. To diagnose schizophrenia, these symptoms must persist for 6 months or more and not be attributed to substance use or another medical condition.\n',
        );
      case 'Treatment of Schizophrenia':
        return const Text(
          'Schizophrenia is a chronic disorder that lasts a lifetime, but treatment can help alleviate symptoms, prevent relapse, and avoid the need for hospitalization.\n\n'
          '1. Medication: Antipsychotic medications are commonly used to treat schizophrenia, including:\n'
          '   - Olanzapine\n'
          '   - Risperidone\n'
          '   - Clozapine\n'
          '   - Haloperidol\n'
          '   Some medications are available in long-acting injectable forms to enhance treatment adherence and reduce hospitalization needs.\n\n'
          '   Antidepressants like paroxetine may also be used to treat negative symptoms of schizophrenia.\n\n'
          '2. Psychological Therapy: Psychological therapy, in conjunction with medication, helps individuals learn coping skills, improve social relationships, and communicate effectively. This may include:\n'
          '   - Cognitive-behavioral therapy (CBT) to change thought patterns and cope with delusions and hallucinations.\n'
          '   - Family therapy to guide families on how to support individuals with schizophrenia.\n\n'
          '   Treatment for schizophrenia also involves social skills training and vocational rehabilitation to enhance social interaction and facilitate employment.\n\n'
          '   Severe cases of schizophrenia may require hospitalization, especially for patients who cannot care for themselves or have attempted suicide.\n',
        );
      case 'Management and Coping Strategies':
        return const Text(
          'There are several guidelines to control and cope with schizophrenia, including:\n'
          '- Adhering to recommended treatments.\n'
          '- Learning relaxation techniques like meditation and yoga to reduce stress.\n'
          '- Joining support groups for individuals with schizophrenia.\n'
          '- Setting and focusing on goals to engage in meaningful activities and reduce symptoms.\n\n'
          'Schizophrenia is a serious mental illness that should not be ignored or left untreated, as it can lead to serious complications such as anxiety, depression, family and social problems, inability to work and support oneself, substance abuse, self-harm, or suicide.\n',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
