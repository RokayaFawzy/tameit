import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class PanicDisorder extends StatefulWidget {
  const PanicDisorder({Key? key}) : super(key: key);

  @override
  _PanicDisorderState createState() => _PanicDisorderState();
}

class _PanicDisorderState extends State<PanicDisorder> {
  Map<String, bool> expandedSections = {
    'Panic Disorder': false,
    'Symptoms': false,
    'When to See a Doctor?': false,
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
            'Panic Disorder',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/panic1.png",
                      fit: BoxFit.cover,
                      height: 200, // adjust height as needed
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
      case 'Panic Disorder':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/panic2.png'),
            const SizedBox(height: 10),
            Text(
              'A panic attack is a sudden episode of intense fear that triggers severe physical reactions even though there is no real danger or clear cause for the fear. Panic attacks can be extremely frightening. During a panic attack, you may feel like you\'re losing control, having a heart attack, or even dying.\n\n'
              'Many people experience one or two panic attacks in their lifetime, and the problem goes away, perhaps when a stressful situation ends. However, if you have recurrent, unexpected panic attacks and spend long periods in constant fear of another attack, you may have a condition called panic disorder.\n\n'
              'Although panic attacks themselves are not life-threatening, they can be frightening and significantly impact your quality of life. However, effective treatment is often available.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Symptoms':
        return const Text(
          'Panic attacks typically come on suddenly, without warning. They can occur at any time—while driving, sleeping, shopping, or in the middle of a work meeting. You may have occasional panic attacks, or they may occur frequently.\n\n'
          'Panic attacks can have various forms, but symptoms usually peak within minutes. You may feel exhausted and drained after a panic attack subsides.\n\n'
          'Common signs and symptoms of panic attacks include:\n'
          '- Feeling of impending doom or danger\n'
          '- Fear of losing control or dying\n'
          '- Rapid heart rate\n'
          '- Sweating\n'
          '- Trembling or shaking\n'
          '- Shortness of breath or tightness in the throat\n'
          '- Chills\n'
          '- Hot flashes\n'
          '- Nausea\n'
          '- Abdominal cramping\n'
          '- Chest pain\n'
          '- Headache\n'
          '- Dizziness, lightheadedness, or faintness\n'
          '- Numbness or tingling sensation\n'
          '- Feeling of unreality or detachment\n\n'
          'One of the worst aspects of panic attacks is the intense fear of having another attack. You may avoid situations where you fear a panic attack might occur.',
          style: TextStyle(fontSize: 16),
        );
      case 'When to See a Doctor?':
        return const Text(
          'If you experience symptoms of a panic attack, seek medical help as soon as possible. Panic attacks are not life-threatening but can be extremely distressing. Managing panic attacks on your own can be challenging and may worsen without treatment.\n\n'
          'Symptoms of panic attacks can also mimic symptoms of other serious health problems, such as a heart attack. Therefore, it\'s important to get an evaluation from your primary care provider if you\'re unsure about the cause of your symptoms.',
          style: TextStyle(fontSize: 16),
        );
      case 'Causes':
        return const Text(
          'It\'s unknown what causes panic attacks or panic disorder, but these factors may play a role:\n'
          '- Genetic predisposition\n'
          '- Severe stress\n'
          '- Mood sensitivity to stress or prone to negative emotions\n'
          '- Some changes in the functioning of parts of the brain\n\n'
          'Panic attacks can occur suddenly and without warning, but over time, they\'re often triggered by specific situations.\n\n'
          'Some research suggests that the body\'s natural fight-or-flight response in situations perceived as dangerous contributes to panic attacks. For example, if you were being chased by a grizzly bear, your body would instinctively respond. Your heart rate and breathing would accelerate as your body prepared to confront a life-threatening situation. Many similar responses occur during a panic attack. However, it\'s unclear why panic attacks occur in the absence of a clear threat.',
          style: TextStyle(fontSize: 16),
        );
      case 'Risk Factors':
        return const Text(
          'Symptoms of panic disorder often begin in late adolescence or early adulthood and affect women more than men.\n\n'
          'Factors that can increase the risk of experiencing panic attacks or panic disorder include:\n'
          '- Family history of panic attacks or panic disorder\n'
          '- Major life stressors, such as the death of a loved one or a serious illness\n'
          '- Traumatic event, such as sexual assault or a serious accident\n'
          '- Significant life changes, such as divorce or the birth of another child\n'
          '- Smoking or excessive caffeine consumption\n'
          '- History of physical or sexual abuse in childhood',
          style: TextStyle(fontSize: 16),
        );
      case 'Complications':
        return const Text(
          'Failure to address panic attacks and panic disorder can affect all aspects of your life. Fear of experiencing further panic attacks may lead you to live in a constant state of fear, which can significantly disrupt your quality of life.\n\n'
          'Complications associated with or resulting from panic attacks may include:\n'
          '- Developing specific phobias, such as fear of driving or leaving home\n'
          '- Frequent medical visits for health concerns and other conditions\n'
          '- Social avoidance\n'
          '- Work or school problems\n'
          '- Depression, anxiety disorders, and other mental health issues\n'
          '- Increased risk of suicide attempts or suicidal thoughts\n'
          '- Alcohol or substance abuse\n'
          '- Financial problems\n\n'
          'For some individuals, panic disorder may include agoraphobia, which involves avoiding places or situations due to fear of being unable to escape or get help if a panic attack occurs. You might rely on others to accompany you when leaving home.',
          style: TextStyle(fontSize: 16),
        );
      case 'Prevention':
        return const Text(
          'There\'s no guaranteed way to prevent panic attacks, but these recommendations may help:\n'
          '- Seek treatment for panic attacks as soon as possible to avoid their worsening or recurring regularly.\n'
          '- Adhere to a treatment plan to prevent relapses or worsening symptoms.\n'
          '- Maintain regular physical activity, as it can help reduce anxiety.',
          style: TextStyle(fontSize: 16),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
