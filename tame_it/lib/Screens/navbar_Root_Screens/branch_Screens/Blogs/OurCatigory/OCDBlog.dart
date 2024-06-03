import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class OCDBlog extends StatefulWidget {
  const OCDBlog({Key? key}) : super(key: key);

  @override
  _OCDBlogState createState() => _OCDBlogState();
}

class _OCDBlogState extends State<OCDBlog> {
  Map<String, bool> expandedSections = {
    'Obsessive-Compulsive Disorder (OCD)': false,
    'Symptoms of OCD': false,
    'Obsessions of OCD': false,
    'Compulsions  of OCD': false,
    'Severity Varies': false,
    'When to See a Doctor': false,
    'Causes of OCD': false,
    'Risk Factors of OCD': false,
    'Complications of OCD': false,
    'Prevention of OCD': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Obsessive-Compulsive Disorder(OCD)',
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
                    "assets/images/ocdim.png",
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
      case 'Obsessive-Compulsive Disorder (OCD)':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                "assets/images/ocd2img.jpg"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            Text(
              'Obsessive-compulsive disorder (OCD) involves a pattern of unwanted thoughts and fears called obsessions. These obsessions drive you to perform repetitive behaviors, also known as compulsions. These obsessions and compulsions interfere with daily activities and cause severe distress.'
              '\n\nUltimately, you feel compelled to engage in compulsive behaviors in an attempt to relieve anxiety. Even when you try to ignore these intrusive thoughts or urges or to get rid of them, they keep coming back repeatedly. This leads to engaging in ritualistic behaviors. This is the empty cycle of OCD.'
              '\n\nObsessive-compulsive disorder often centers around specific themes, such as excessive fear of contamination due to germs. To alleviate your fears of contamination, you may repeatedly wash your hands until they become raw and cracked.'
              '\n\nObsessive-compulsive disorder may cause feelings of shame, embarrassment, and frustration. However, treatment can be effective.',
            ),
          ],
        );
      case 'Symptoms of OCD':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Obsessive-compulsive disorder typically includes both obsessions and compulsions. However, you may experience only obsessions or only compulsions. You may or may not realize that your obsessions and compulsions are unreasonable. Nonetheless, they consume a significant amount of your time, diminish your quality of life, disrupt your routine, and interfere with your daily responsibilities.'),
          ],
        );
      case 'Obsessions of OCD':
        return const Text(
          'Obsessions'
          '\nThe obsessions of obsessive-compulsive disorder are persistent, unwanted, and recurring thoughts, urges, or intrusive images that cause distress or anxiety. You may try to ignore or get rid of them by engaging in compulsive rituals. These obsessions usually intrude when you\'re trying to think about or do other things.'
          '\n\nThese obsessions often revolve around specific themes such as:'
          '\n• Fear of contamination or dirt.'
          '\n• Doubt and difficulty dealing with uncertainty.'
          '\n• Needing things to be arranged or in a specific order.'
          '\n• Aggressive or horrific thoughts about losing control and harming yourself or others.'
          '\n• Unwanted thoughts, including violence, sexual themes, or religious topics.',
        );
      case 'Compulsions  of OCD':
        return const Text(
          'Compulsions'
          '\nCompulsive behaviors resulting from obsessive-compulsive disorder are repetitive behaviors that you feel driven to perform. These repetitive behaviors or mental acts are aimed at reducing anxiety related to obsessions or preventing something bad from happening. However, engaging in compulsive behaviors doesn\'t bring any pleasure and may only provide limited relief from anxiety.'
          '\n\nYou may establish rules or rituals to follow to help control anxiety when you have obsessive thoughts. These compulsive behaviors are illogical and often unrelated to the problem you\'re trying to solve.'
          '\n\nLike obsessions, compulsive behaviors often revolve around specific themes such as:'
          '\n• Washing and cleaning.'
          '\n• Checking and verifying.'
          '\n• Counting.'
          '\n• Keeping things orderly.'
          '\n• Following strict routines.'
          '\n• Excessive reassurance seeking.'
          '\n\nExamples of compulsive symptoms include:'
          '\n• Washing hands until the skin becomes painful due to excessive rubbing.'
          '\n• Checking doors repeatedly to ensure they are locked.'
          '\n• Checking the stove repeatedly to ensure it\'s turned off.'
          '\n• Counting in specific patterns.'
          '\n• Repeating prayers, words, or phrases silently.'
          '\n• Attempting to replace a bad thought with a good one.'
          '\n• Arranging canned goods so they all face the same direction.',
        );
      case 'Severity Varies':
        return const Text(
          'Obsessive-compulsive disorder typically begins in adolescence or young adulthood, but it can also begin in childhood. Symptoms usually start gradually and the severity can change over time. The types of obsessions and compulsions you experience may also change over time. Symptoms generally worsen when you\'re under severe stress, including transitional stages and periods of change. The severity of obsessive-compulsive disorder symptoms, which usually last a lifetime, can range from mild to moderate, or they can be extremely severe and time-consuming to the point where they interfere with your daily activities.',
        );
      case 'When to See a Doctor':
        return const Text(
          'There\'s a difference between striving for perfection — the pursuit of results or performance that is flawless — and having obsessive-compulsive disorder. Obsessive thoughts are not just excessive fears about real-life problems or a desire to clean or arrange things in a certain way.'
          '\n\nIf obsessions and compulsions affect your quality of life, consult a doctor or mental health specialist.',
        );
      case 'Causes of OCD':
        return const Text(
          'The exact cause of obsessive-compulsive disorder is still not fully understood. Key theories include:'
          '\n• Biological factors. Obsessive-compulsive disorder may result from changes in normal body chemistry or brain function.'
          '\n• Genetic traits. Obsessive-compulsive disorder may have a genetic component, although specific genes associated with it have not been identified.'
          '\n• Learning. Obsessive-compulsive fears and compulsive behaviors can be learned by watching family members or over time.',
        );
      case 'Risk Factors of OCD':
        return const Text(
          'Factors that may increase the risk of developing obsessive-compulsive disorder include:'
          '\n• Family history. A family history of obsessive-compulsive disorder or other mental health disorders may increase the risk of developing obsessive-compulsive disorder.'
          '\n• Stressful life events. If you\'ve experienced psychological trauma or stressful events, your risk may increase. This reaction can lead to triggering intrusive thoughts, routine rituals, and emotional disturbances that characterize obsessive-compulsive disorder.'
          '\n• Other mental health disorders. Obsessive-compulsive disorder may be associated with other mental health disorders such as anxiety disorders, depression, substance abuse, or eating disorders.',
        );
      case 'Complications of OCD':
        return const Text(
          'Problems caused by obsessive-compulsive disorder include:'
          '\n• Excessive time spent performing rituals and ceremonies.'
          '\n• Health problems, such as contact dermatitis resulting from repeated hand washing.'
          '\n• Difficulty going to work, school, or engaging in social activities.'
          '\n• Relationship disruption.'
          '\n• Lowered quality of life.'
          '\n• Suicidal thoughts or suicide-related behaviors.',
        );
      case 'Prevention of OCD':
        return const Text(
          'There is no surefire way to prevent obsessive-compulsive disorder. However, getting treatment as soon as possible may help prevent the deterioration of obsessive-compulsive disorder and the disruption of your daily activities and routines.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
