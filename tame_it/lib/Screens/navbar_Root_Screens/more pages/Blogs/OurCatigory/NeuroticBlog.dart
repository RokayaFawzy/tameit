import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class NeurologicalFunctionalDisorder extends StatefulWidget {
  const NeurologicalFunctionalDisorder({Key? key}) : super(key: key);

  @override
  _NeurologicalFunctionalDisorderState createState() =>
      _NeurologicalFunctionalDisorderState();
}

class _NeurologicalFunctionalDisorderState
    extends State<NeurologicalFunctionalDisorder> {
  Map<String, bool> expandedSections = {
    'Neurological Functional Disorder': false,
    'Symptoms': false,
    'When to See a Doctor': false,
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
          'Neurological Functional Disorder',
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
                      "assets/images/neurotic2.jpg",
                      fit: BoxFit.cover,
                      height: 200, // adjust height as needed
                    ),
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
      case 'Neurological Functional Disorder':
        return Column(
          children: [
            Image.asset(
              "assets/images/neurotic1.gif",
              fit: BoxFit.cover,
              height: 200, // adjust height as needed
            ),
            Text(
              'Neurological functional disorder is a broad and newer term encompassing what some people refer to as conversion disorder, involving neurological symptoms that cannot be attributed to a neurological disease or any other medical condition. However, these symptoms are real and cause significant distress or impairments in various functions.\n\n'
              'The indicators and symptoms of neurological functional disorder vary depending on the type of functional neurological symptom and may include specific patterns. Typically, this disorder affects motor and sensory functions, such as walking ability, swallowing, vision, or hearing. Symptoms can vary in severity, appearing and disappearing or persisting over time. However, you cannot intentionally induce or control these symptoms.\n\n'
              'The exact cause of neurological functional disorder remains unknown. The condition may be triggered by a neurological disturbance, allergic reaction to stress, psychological trauma, or physical injury, but this is not always the case. Functional neurological disorder is associated with brain function rather than structural brain damage (such as that resulting from stroke, multiple sclerosis, infection, or injury).',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Symptoms':
        return Text(
          'The indicators and symptoms of functional neurological disorder affecting motor and sensory functions may include:\n'
          '- Weakness or paralysis\n'
          '- Abnormal movements, such as tremors or difficulty walking\n'
          '- Loss of balance\n'
          '- Difficulty swallowing or sensation of a "lump in the throat"\n'
          '- Seizures or shaking episodes with clear consciousness (non-epileptic seizures)\n'
          '- Episodes of unresponsiveness\n\n'
          'Indicators and symptoms affecting sensory perception may include:\n'
          '- Numbness or loss of touch sensation\n'
          '- Speech problems, such as inability to speak or stuttering\n'
          '- Vision problems, such as double vision or blindness\n'
          '- Hearing difficulties or deafness\n'
          '- Cognitive difficulties affecting memory and concentration',
          style: TextStyle(fontSize: 16),
        );
      case 'When to See a Doctor':
        return Text(
          'Seek medical care to address indicators and symptoms that concern you or impair your ability to perform various functions. If the underlying cause is a neurological disease or another medical condition, diagnosing and treating the condition promptly is important. If diagnosed as a functional neurological disorder, treatment may help alleviate symptoms and prevent future issues.',
          style: TextStyle(fontSize: 16),
        );
      case 'Causes':
        return Text(
          'The exact cause of functional neurological disorder remains unknown. Theories about what occurs in the brain leading to symptom manifestation are complex and involve several mechanisms that may vary depending on the type of functional neurological symptom.\n\n'
          'Fundamentally, parts of the brain controlling muscle and sensory functions may be affected by the disorder, despite the absence of disease or deformity.\n\n'
          'Symptoms of functional neurological disorder may suddenly appear following a stressful event, psychological trauma, or physical injury. Other triggers may involve changes or disturbances in how the brain functions at the structural, cellular, or metabolic level, though symptom triggers cannot always be definitively determined.',
          style: TextStyle(fontSize: 16),
        );
      case 'Risk Factors':
        return Text(
          'Risk factors that may increase the likelihood of developing functional neurological disorder include:\n'
          '- Having neurological disorders or conditions such as epilepsy, migraines (migraine headaches), or movement disorders.\n'
          '- Recent exposure to acute stress or physical or psychological trauma.\n'
          '- Mental health disorders, such as mood disorders, anxiety, dissociative disorders, or specific personality disorders.\n'
          '- Family history of neurological conditions or symptoms.\n'
          'Women may be more susceptible to developing functional neurological disorder.',
          style: TextStyle(fontSize: 16),
        );
      case 'Complications':
        return Text(
          'Certain symptoms of functional neurological disorder, particularly when left untreated, can lead to severe disability and decreased quality of life similar to issues caused by medical problems or disease.\n\n'
          'The following symptoms may appear with functional neurological disorder:\n'
          '- Pain\n'
          '- Anxiety disorders, including panic disorders\n'
          '- Depression\n'
          '- Insomnia\n'
          '- Fatigue',
          style: TextStyle(fontSize: 16),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
