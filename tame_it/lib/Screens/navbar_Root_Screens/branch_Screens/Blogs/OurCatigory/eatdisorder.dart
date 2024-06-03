import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class EatingDisordersBlog extends StatefulWidget {
  const EatingDisordersBlog({super.key});

  @override
  _EatingDisordersBlogState createState() => _EatingDisordersBlogState();
}

class _EatingDisordersBlogState extends State<EatingDisordersBlog>
    with TickerProviderStateMixin {
  Map<String, bool> expandedSections = {
    'What are Eating Disorders?': false,
    'Symptoms': false,
    'Anorexia Nervosa': false,
    'Bulimia Nervosa': false,
    'Binge Eating Disorder': false,
    'Avoidance/Restriction Eating Disorder': false,
    'When to See a Doctor?': false,
    'Warning signs that may indicate an eating disorder include': false,
    'Causes': false,
    'Complications': false,
    'Prevention': false,
    'Healthy Habits': false,
    'For Children': false,
    'Reaching Out for Help': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          title: const Text(
            'Eating Disorders',
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
                    "assets/images/eatblog.webp",
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
      case 'What are Eating Disorders?':
        return Column(
          children: [
            Image.asset(
                "assets/images/eatblog2.jpg"), // Replace with your image URL or use AssetImage for local images
            const SizedBox(height: 10),
            const Text(
                'Eating disorders are serious health conditions that affect both your physical and mental well-being. They involve problems with how you think about food, eating, weight, and shape, as well as issues with eating behaviors. These symptoms can impact your health, emotions, and functional abilities in important areas of life. If eating disorders are not effectively treated, they can lead to long-term problems and, in some cases, can be life-threatening. The most common eating disorders include anorexia nervosa, bulimia nervosa, and binge eating disorder.'),
          ],
        );
      case 'Symptoms':
        return const Text(
          'Symptoms vary depending on the type of eating disorder. The most common eating disorders include anorexia nervosa, bulimia nervosa, and binge eating disorder. Body shapes and sizes can vary among individuals with eating disorders.',
        );
      case 'Anorexia Nervosa':
        return const Text(
            'Anorexia nervosa, also known as restrictive eating disorder, is a life-threatening eating disorder. It involves unhealthy weight loss, intense fear of weight gain, and a distorted view of weight and shape. Anorexia often involves extreme efforts to control weight and shape, which can seriously conflict with health and daily life. Restrictive eating may involve severe calorie reduction or eliminating certain types of foods or food groups. Other methods of weight loss may include excessive exercise, laxatives or diet aids, or vomiting after eating. Efforts to lose weight can cause serious health problems, even for those who continue to eat throughout the day or who are not severely underweight.');
      case 'Bulimia Nervosa':
        return const Text(
            'Bulimia nervosa, also known as binge-eating disorder, is a serious and sometimes life-threatening eating disorder. It involves episodes of excessive eating followed by usually purging. In some cases, bulimia also involves severe restriction of eating for periods of time. This often leads to stronger desires to overeat and then purge. Binge-eating involves consuming large amounts of food in a short period of time. During binge-eating, individuals feel out of control with eating and unable to stop. After eating, driven by feelings of guilt, shame, or extreme fear of weight gain, purging occurs to rid the body of calories. Purging can include vomiting, excessive exercise, not eating for periods of time, or using other methods such as laxatives. Some people change their medication doses, such as insulin, to try to lose weight. Bulimia also involves preoccupation with weight and body shape along with harsh and harsh self-judgment due to personal appearance.');
      case 'Binge Eating Disorder':
        return const Text(
            'Binge eating disorder involves eating during a short period of time. When binge-eating occurs, it seems that there is no control over eating. But this condition is not followed by purging. People may eat faster during periods of binge-eating or eat more than planned. Even if you don\'t feel hungry, you may continue eating after a long period of uncomfortable fullness. After the end of the binge, people often feel a great deal of guilt, disgust, or embarrassment. They may fear weight gain and may make extreme efforts to avoid eating for periods of time. This can lead to increased hunger and unhealthy cycle. The embarrassment may lead to eating alone to hide the binges. A new episode of eating may occur at least once a week.');
      case 'Avoidance/Restriction Eating Disorder':
        return const Text(
            'Avoidance/restriction eating disorder involves consuming a very limited amount of food or not eating certain foods. Usually, the pattern of eating is not sufficient to meet the minimum daily nutritional needs. This can lead to problems with growth, development, and the ability to perform daily life tasks. But people with this disorder do not fear weight gain or body size. Instead, they may not care about eating or may avoid certain foods because of their color, texture, smell, or taste. Or they may worry about what may happen when they eat. For example, they may fear choking or vomiting or worry about stomach problems. Avoidance/restriction eating disorder can be diagnosed at any age, but it is more common in young children. The disorder can lead to significant weight loss or inability to gain weight during childhood. Poor nutrition can lead to serious health problems.');
      case 'When to See a Doctor?':
        return const Text(
            'You may find it difficult to control or overcome an eating disorder on your own. The earlier you seek treatment, the greater the likelihood of full recovery. Some individuals may occasionally struggle with eating behaviors that resemble symptoms of an eating disorder, even though these behaviors may not meet the diagnostic criteria for an eating disorder. However, problematic eating behaviors can still have a serious impact on health and safety. If you are experiencing eating behaviors that cause distress, interfere with your life or health, or if you suspect you have an eating disorder, seek medical help. Encourage someone you care about to seek treatment. Many individuals with eating disorders do not believe they need treatment. A key feature of many eating disorders is a lack of awareness of the severity of the symptoms. Additionally, feelings of guilt and shame often prevent people from seeking help. If you are concerned about a friend or family member, encourage them to speak to a doctor. Even if the person is not ready to acknowledge an eating-related problem, you can start the conversation by expressing your concern and desire to listen to them.:\n');
      case 'Warning signs that may indicate an eating disorder include':
        return const Text(
          '• Skipping meals or snacks altogether or making excuses for not eating.\n'
          '• Following an extremely restrictive diet not recommended by a qualified medical professional.\n'
          '• Excessive focus on food or healthy eating patterns, especially if it means avoiding usual activities like sporting events, birthday cake, or eating out.\n'
          '• Preparing separate meals instead of eating what the family eats.\n'
          '• Withdrawing from usual social activities.\n'
          '• Expressing frequent and persistent concern about unhealthy habits or excessive weight gain and talking about weight loss.\n'
          '• Frequently checking appearance in the mirror believing there are flaws.\n'
          '• Eating large amounts of food frequently.\n'
          '• Using supplements, laxatives, or herbal products for weight loss.\n'
          '• Exercising much more than the average person. This includes not taking rest days or days off when injured or ill, or avoiding social gatherings or other life events due to the desire to exercise.\n'
          '• Calluses on finger joints from putting fingers in the mouth to induce vomiting.\n'
          '• Dental problems related to frequent vomiting.\n'
          '• Leaving during meals or immediately afterward to use the bathroom.\n'
          '• Talking about depression, disgust, shame, or guilt due to eating habits.\n'
          '• Eating in secret.',
        );

      case 'Causes':
        return const Text(
            'The exact cause of eating disorders is unclear. Just as with other mental health conditions, eating disorders likely result from a complex interplay of biological, psychological, and social factors. Genetic factors: Studies of twins and adopted children suggest that genetic factors may be involved in developing eating disorders. Biological factors: Certain chemicals in the brain that control hunger, appetite, and digestion have been found to be imbalanced in individuals with eating disorders. Psychological factors: Some individuals with eating disorders may have psychological and emotional traits that contribute to the development and maintenance of their condition. Social factors: The modern culture promotes and often idealizes thinness, making it difficult for people of all body types to maintain a positive body image. Peer pressure and media messages can reinforce this societal standard of beauty.');
      case 'Complications':
        return const Text(
            'Eating disorders cause a variety of complications, some of them serious and potentially life-threatening. The more severe or long-lasting the eating disorder, the more likely it is to result in serious complications. Examples of complications include:\n'
            '• Serious health problems\n'
            '• Depression and anxiety\n'
            '• Suicidal thoughts or behavior\n'
            '• Problems with growth and development\n'
            '• Social and relationship issues\n'
            '• Problems at work and school\n'
            '• Death');
      case 'Prevention':
        return const Text(
            'Although there is no sure way to prevent eating disorders, some steps may help:\n'
            '• Avoid dieting around children.\n'
            '• Have regular, enjoyable meals as a family.\n'
            '• Discuss messages about body image and self-esteem from the media.\n'
            '• Promote a healthy, balanced diet and physical activity.\n'
            '• Encourage positive body image and confidence.\n'
            '• Avoid conversations focused on weight or body shape.\n'
            '• Develop a healthy, realistic approach to weight loss and dieting.\n'
            '• Seek treatment early for any eating issues.');
      case 'Healthy Habits':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For Adults',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '- Choose a healthy diet rich in whole grains, fruits, and vegetables. Limit salt, sugar, alcohol, saturated fats, and trans fats. Also, avoid extreme dieting. If you need to lose weight, talk to your doctor or a dietitian to develop a plan that meets your needs.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Avoid using supplements, laxatives, or herbal products for weight loss.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Engage in enough physical activity. Aim for at least 150 minutes per week of moderate-intensity aerobic activity, such as brisk walking. Choose activities you enjoy to increase your likelihood of sticking with them.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Seek help for mental health issues like depression, anxiety, or self-esteem/body image concerns.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                launch('https://www.health.gov/');
              },
              child: Text(
                'For more guidance on food, nutrition, and physical activity, please visit health.gov',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
                'Talk to a doctor if you have concerns about your eating behaviors. Getting treatment early can prevent the problem from worsening.',
                style: TextStyle(fontSize: 16))
          ],
        );
      case 'For Children':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For Children',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '- Avoid dieting in front of your child. Family meal habits can influence children\'s relationships with food. Eating meals together provides an opportunity to teach children about the dangers of dieting. It also allows you to monitor if your child is eating enough and diversely.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Talk to your child. Many websites and social media platforms promote dangerous ideas, such as considering appetite loss a lifestyle choice rather than an eating disorder. Some websites encourage teenagers to start dieting. It\'s important to correct any misconceptions like these. Talk to your child about the risks of making unhealthy eating choices.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Encourage and reinforce a healthy body image in your child regardless of their shape or size. Talk to your child about self-image and reassure them that body shapes vary. Avoid criticizing your own body in front of your child. Messages of acceptance and respect can build healthy self-esteem. They can also build resilience, the ability to quickly recover from difficult events. These skills can help children navigate challenging times during adolescence and young adulthood.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Seek help from your child\'s healthcare provider. During your child\'s routine health visits, doctors may be able to identify early signs of eating disorders. For example, they may ask children about their eating habits. These visits may include height, weight, and body mass index measurements, which can alert you and your child\'s doctor to any significant changes.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );

      case 'Reaching Out for Help':
        return const Text(
            'Reaching out for help with eating disorders can be challenging, but it is a crucial step toward recovery. If you or someone you know is struggling, here are some steps to take:\n'
            '1. **Talk to a healthcare provider**: Start with your primary care doctor or a mental health professional who specializes in eating disorders.\n'
            '2. **Seek support from loved ones**: Share your struggles with friends and family who can offer emotional support.\n'
            '3. **Join a support group**: Connecting with others who understand what you are going through can provide comfort and encouragement.\n'
            '4. **Educate yourself**: Learn about eating disorders and treatment options to better understand the condition and your journey to recovery.\n'
            '5. **Create a support plan**: Work with your healthcare provider to develop a personalized treatment plan that includes medical care, nutrition counseling, and therapy.');
      default:
        return const Text('Content not available.');
    }
  }
}
