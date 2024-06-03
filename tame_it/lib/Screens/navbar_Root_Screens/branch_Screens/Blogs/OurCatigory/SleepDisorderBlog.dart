import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class SleepDisorders extends StatefulWidget {
  const SleepDisorders({Key? key}) : super(key: key);

  @override
  _SleepDisordersState createState() => _SleepDisordersState();
}

class _SleepDisordersState extends State<SleepDisorders> {
  Map<String, bool> expandedSections = {
    'Overview': false,
    'Symptoms': false,
    'Clinical Trials': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'Sleep Disorders',
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
                      "assets/images/sleepdis1.jpg",
                      fit: BoxFit.cover,
                      height: 200,
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
            Image.asset("assets/images/sleepdis2.jpg"),
            const SizedBox(height: 10),
            Text(
              'Sleep disorders are conditions that result in changes to your sleep patterns. They can affect your overall health, safety, and quality of life. Sleep deprivation can impact your ability to drive safely and increases the risk of other health problems.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Some signs and symptoms of sleep disorders include excessive daytime sleepiness, irregular breathing or increased movement during sleep. Other signs and symptoms include irregular sleep-wake cycles and difficulty falling asleep.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Some common types of sleep disorders include:\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- Insomnia : Difficulty falling asleep or staying asleep during the night\n\n'
                        '- Sleep Apnea : Feeling abnormal breathing patterns during sleep. There are several types of sleep apnea.\n\n'
                        '- Restless Legs Syndrome (RLS): A type of sleep movement disorder. RLS, also known as Willis-Ekbom disease, causes feelings of discomfort and an urgent need to move your legs while trying to sleep.\n\n'
                        '- Narcolepsy: A condition characterized by extreme daytime sleepiness and sudden onset of sleep during the day.\n',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'There are many ways to help diagnose sleep disorders. Doctors can usually efficiently treat most sleep disorders once properly diagnosed.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Symptoms':
        return const Text(
          'Symptoms of sleep disorders include extreme daytime sleepiness and difficulty sleeping at night. Some people may fall asleep at inappropriate times, which can be dangerous, such as while driving. Other symptoms include abnormal breathing patterns or feeling an uncomfortable urge to move while trying to sleep. There may be unusual movements or sensations during sleep. Other symptoms of sleep disorders include irregular sleep-wake cycles.',
          style: TextStyle(fontSize: 16),
        );
      case 'Clinical Trials':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Mayo Clinic studies of new treatments, interventions, and tests as a means to prevent, treat, and manage this health condition.',
              style: TextStyle(fontSize: 16),
            ),
            // Insert any additional content here for clinical trials
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
