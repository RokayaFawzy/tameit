import 'package:flutter/material.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/Blogs/OurCatigory/buble.dart';
import 'package:tame_it/values/values.dart';

class ADHDBlog extends StatefulWidget {
  const ADHDBlog({super.key});

  @override
  _ADHDBlogState createState() => _ADHDBlogState();
}

class _ADHDBlogState extends State<ADHDBlog> with TickerProviderStateMixin {
  Map<String, bool> expandedSections = {
    'What is ADHD?': false,
    'Are there different types of ADHD?': false,
    'What causes it?': false,
    'What are the symptoms?': false,
    'How is it diagnosed?': false,
    'How is it treated?': false,
    'How can parents and families help?': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Attention-Deficit Hyperactivity Disorder (ADHD)',
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
                    "assets/images/adhdim.jpg",
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
      case 'What is ADHD?':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                "assets/images/2332.jpg"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            const Text(
              'Attention-Deficit Hyperactivity Disorder (ADHD) is a common mental condition that typically begins in childhood and can persist into adolescence and adulthood. A child with this disorder struggles with inattention, hyperactivity, impulsiveness, or a combination of these, which can make daily tasks challenging and may slow down their development.',
            ),
          ],
        );
      case 'Are there different types of ADHD?':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'There are three types of Attention-Deficit Hyperactivity Disorder:',
            ),
            SizedBox(height: 10),
            Text(
              '1. Inattentive Type: This involves a child being disconnected from tasks, having difficulty focusing on a specific thing, struggling to maintain focus overall, and experiencing distractibility and disorganization. The cause of these issues is not due to the child being defiant or lacking understanding.',
            ),
            SizedBox(height: 10),
            Text(
              '2. Hyperactive-Impulsive Type: This refers to a child\'s constant movement, even at inappropriate times, along with fidgeting, excessive talking, or behavior that exceeds normal boundaries. In adolescence, this may result in severe restlessness or causing fatigue in others with their activity.',
            ),
            SizedBox(height: 10),
            Text(
              '3. Combined Type: This involves both inattentive and hyperactive-impulsive symptoms.',
            ),
          ],
        );
      case 'What causes it?':
        return const Text(
          'Doctors do not know the exact cause of Attention-Deficit Hyperactivity Disorder.',
        );
      case 'What are the symptoms?':
        return const Text(
          'Children with Attention-Deficit Hyperactivity Disorder may exhibit several symptoms. Common symptoms include:\n'
          '• Easy distractibility and frequent forgetfulness\n'
          '• Rapidly shifting from one activity to another\n'
          '• Difficulty in following directions\n'
          '• Daydreaming often\n'
          '• Trouble completing tasks, such as homework\n'
          '• Losing toys, books, or school supplies frequently\n'
          '• Restlessness and excessive movement in place\n'
          '• Talking non-stop and interrupting others while talking\n'
          '• Wandering around frequently and touching everything\n'
          '• Impatience\n'
          '• Making inappropriate comments without thinking\n'
          '• Difficulty controlling emotions',
        );
      case 'How is it diagnosed?':
        return const Text(
          'There is no single test that can determine whether your child has Attention-Deficit Hyperactivity Disorder. To diagnose the disorder, the doctor will conduct an examination of your child and note symptoms of ADHD that appear. They will also gather information from you, your family, and your child\'s teachers.',
        );
      case 'How is it treated?':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Children with Attention-Deficit Hyperactivity Disorder can improve with treatment, although there is no complete cure. There are three types of treatment:',
            ),
            SizedBox(height: 10),
            Text(
              '1. Medication: There are various types of medications that can help with treatment. The most common types are called "stimulants." Medication helps children focus, learn, and maintain calmness.',
            ),
            SizedBox(height: 10),
            Text(
              '2. Therapy: There are different types of therapy available. Behavioral therapy can help teach children to control their behaviors so they can improve their performance at school and home.',
            ),
            SizedBox(height: 10),
            Text(
              '3. Medication and Therapy Combined: Many children improve when using medication and therapy together.',
            ),
          ],
        );
      case 'How can parents and families help?':
        return const Text(
          'Your child\'s doctor can explain how to help your child make positive changes; assisting them will have positive effects on all family members.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
