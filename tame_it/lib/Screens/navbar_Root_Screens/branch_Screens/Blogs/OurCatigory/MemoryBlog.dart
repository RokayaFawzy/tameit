import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class MemoryDisorders extends StatefulWidget {
  const MemoryDisorders({Key? key}) : super(key: key);

  @override
  _MemoryDisordersState createState() => _MemoryDisordersState();
}

class _MemoryDisordersState extends State<MemoryDisorders> {
  Map<String, bool> expandedSections = {
    'Memory Disorders': false,
    'Symptoms': false,
    'Additional Symptoms': false,
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
            'Memory Disorders',
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
                      "assets/images/memory1.jpg",
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
      case 'Memory Disorders':
        return Column(
          children: [
            Image.asset(
              "assets/images/memory2.jpg",
              fit: BoxFit.cover,
              height: 200, // adjust height as needed
            ),
            Text(
              'Memory loss refers to forgetting memories, such as facts, information, and experiences. Despite how movies and TV shows portray memory loss as identity loss, this is generally not the case in reality. Instead, individuals experiencing memory loss—also known as amnesia—usually retain their identity. However, they may struggle with learning new information and forming new memories. Memory loss can occur due to damage to brain regions crucial for memory function. Unlike transient episodes of memory loss, known as transient global amnesia, memory loss can be permanent. There is no specific treatment for memory loss, but treatment can be directed at the underlying cause of the condition. People with memory loss and their families can be assisted in coping with the condition through memory-strengthening tips and support.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Symptoms':
        return Text(
          'The primary symptoms experienced by individuals with memory loss are:\n'
          '- Difficulty acquiring new information.\n'
          '- Difficulty recalling past events and previously familiar information.\n\n'
          'Most people with memory loss experience short-term memory problems, making it difficult for them to retain new information and often causing them to lose recent memories. Older or deeply ingrained memories, however, may remain intact. For example, a person may remember childhood experiences or the names of former presidents but may struggle to recall the current president\'s name or what they ate for breakfast. Memory loss does not affect a person\'s intelligence, general knowledge, awareness, attention span, ability to reason, personality, or identity. Individuals with memory loss typically understand written and spoken words and can learn skills such as riding a bike or playing the piano. They are also aware that they have a memory disorder. Memory loss differs from dementia, which often includes memory loss but also involves other cognitive impairments leading to a decline in daily functioning. These problems may include language difficulties, impaired judgment, and visuospatial skills. Memory loss is also a common symptom of mild cognitive impairment, which involves milder memory and cognitive problems compared to those experienced by individuals with dementia.',
          style: TextStyle(fontSize: 16),
        );
      case 'Additional Symptoms':
        return Text(
          'Depending on the cause of memory loss, other symptoms may include:\n'
          '- False memories, either completely invented or real memories misplaced in time.\n'
          '- Confusion or lack of focus.',
          style: TextStyle(fontSize: 16),
        );
      case 'When to See a Doctor?':
        return Text(
          'Anyone experiencing unexplained memory loss, head injury, or confusion needs immediate medical care.\n\n'
          'Individuals with memory loss may not know their whereabouts or may be unable to seek medical care themselves. If you know someone exhibiting symptoms of memory loss, assist them in obtaining necessary medical care for their condition.',
          style: TextStyle(fontSize: 16),
        );
      case 'Causes':
        return Text(
          'Normal memory function relies on several parts of the brain. Therefore, any disease or injury affecting the brain can impact memory. Memory loss can occur due to damage to brain regions involved in emotions and memory, including the hippocampus deep within the brain\'s center and the fornix structures within the temporal lobes. Memory loss can result from brain injury or damage, known as neurological memory loss. Possible causes of neurological memory loss include:\n'
          '- Stroke\n'
          '- Brain inflammation due to a viral infection like herpes simplex virus, autoimmune reaction to cancerous tumor elsewhere in the body, or autoimmune reaction without cancer.\n'
          '- Insufficient oxygen reaching the brain, for example, due to a heart attack, respiratory distress, or carbon monoxide poisoning.\n'
          '- Long-term alcohol consumption leading to thiamine (vitamin B-1) deficiency in the body, known as Wernicke-Korsakoff syndrome.\n'
          '- Brain tumors affecting memory control areas.\n'
          '- Alzheimer\'s disease and other diseases causing neural tissue damage.\n'
          '- Epileptic seizures.\n'
          '- Certain medications, such as benzodiazepines or other sedatives.\n\n'
          'Brain injuries causing concussion, such as car accidents or sports injuries, can lead to mental confusion and difficulty remembering new information, common symptoms in early recovery stages. Mild brain injuries typically do not cause permanent memory loss, but more severe brain injuries can. Another rare type of memory loss, known as dissociative amnesia, results from severe emotional or psychological trauma, such as being a victim of violent crime or other severe psychological shocks. When a person experiences this disorder, they lose personal memories and any information about their life, usually for a short period only.',
          style: TextStyle(fontSize: 16),
        );
      case 'Risk Factors':
        return Text(
          'The likelihood of developing memory loss increases if you have experienced:\n'
          '- Brain surgery or head injury or physical trauma.\n'
          '- Stroke.\n'
          '- Alcohol addiction.\n'
          '- Seizures.',
          style: TextStyle(fontSize: 16),
        );
      case 'Complications':
        return Text(
          'Memory loss varies in severity and scope, but even mild memory loss negatively impacts daily activities and quality of life. This syndrome can cause problems at work, school, and social interactions. Some individuals with severe memory problems may require living in care facilities or supervised environments.',
          style: TextStyle(fontSize: 16),
        );
      case 'Prevention':
        return Text(
          'Brain damage is a major cause of memory loss. Therefore, it is essential to take necessary steps to reduce the brain\'s risk of injury. For example:\n'
          '- Avoid excessive alcohol consumption.\n'
          '- Wear protective gear when engaging in activities like riding a bike and driving.\n'
          '- •	Seek prompt medical treatment for infections to prevent them from spreading to the brain.'
          '- Seek immediate medical treatment if you experience symptoms indicating a stroke or brain blood vessel dilation. Symptoms include severe headache, numbness on one side of the body, or inability to move it.',
          style: TextStyle(fontSize: 16),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
