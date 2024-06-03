import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class Testings extends StatefulWidget {
  const Testings({super.key});

  @override
  State<Testings> createState() => _TestingsState();
}

class _TestingsState extends State<Testings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text('Psychometer',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: ListView(children: [
        Container(
            padding: EdgeInsets.only(top: 16.0, left: 16.0),
            color: AppColors.Bermuda,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Psychological Tests',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF50555C))),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ExpandableText(
                    'How much do I know about myself, do I suffer from depression or anxiety? ,'
                    ' Should I visit a therapist, do I need psychiatric treatment? , '
                    'In just a few minutes these tests will answer all your head questions to know more about your psychological condition '
                    'and take a step forward to a better life. All of the information contained on this platform, website, or app, '
                    'including the results of any self-assessment or questionnaire, should be discussed with a suitably qualified healthcare professional '
                    'before drawing any conclusions about your own mental health. Self-assessments are not intended to give a specific formal diagnosis or provide medical advice. '
                    'You are strongly encouraged to confirm any information obtained from- or through this assessment (and any other information on this platform) '
                    'and to review all information regarding your mental health condition, life stage, or treatment with your treating professional. '
                    'Never disregard professional healthcare advice or delay seeking treatment because of something you have read on, or accessed through, '
                    'this platform.\nAll tests are Scientific, Reliable, Trusted.',
                    maxLines: 3,
                    expandText: 'Read more',
                    collapseText: 'Read less',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    )),
              ),
              SizedBox(height: 40)
            ])),
        SizedBox(height: 15),
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Dep_Anx_Str');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Depression, Anxiety \nand stress scale",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'This test is designed to measure your psychological state with regards to the degree of depression, stress and anxiety. Please read the test sentences and choose the best answer that fits you during the last 2 weeks.',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/AnxietyScale');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Anxiety scale",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'This test is designed to measure your anxiety degree. Please read the test sentences and choose the best answer that fits',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/DepressionScale');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Depression scale",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'This test is designed to measure your depression degree. Please read the test sentences and choose the best answer that fits you during the last 2 weeks.',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/OCDScale');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "OCD scale",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'Obsessions are unwelcome or distressing ideas, thoughts, images or impulses that repeatedly enter your mind. '
                              'They may seem to occur against your will. They may be repugnant to you, are often senseless, and may not fit '
                              'your actual personality at all (for example, the recurrent thought or impulse to harm to your children, '
                              'even though you never This test is designed to measure your obsessive compulsive symptoms. '
                              'Obsessions are unwelcome or distressing ideas, thoughts, images or impulses that repeatedly enter your mind. '
                              'They may seem to occur against your will. They may be repugnant to you, are often senseless, and may not '
                              'fit your actual personality at all. Compulsions are behaviors or acts that you feel driven to perform, '
                              'even though you may recognize them as senseless or excessive. At times, you may try to resist doing them, '
                              'but this may prove difficult. You may experience anxiety that does not diminish until the behavior is completed. '
                              'Please read the test sentences and choose the best answer that fits you during the last 2 weeks. '
                              'This test is designed to measure your obsessive compulsive symptoms. Obsessions are unwelcome or distressing ideas, '
                              'thoughts, images or impulses that repeatedly enter your mind. They may seem to occur against your will. They may be repugnant to you, '
                              'are often senseless, and may not fit your actual personality at all. Compulsions are behaviors or acts that you feel driven to perform, '
                              'even though you may recognize them as senseless or excessive. At times, you may try to resist doing them, but this may prove difficult. '
                              'You may experience anxiety that does not diminish until the behavior is completed. Please read the test sentences and '
                              'choose the best answer that fits you during the last 2 weeks.',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/PTSDScale');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "PTSD",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'This test assesses the psychological impact of stressful events after its ends by few months. Below is a list of problems and complaints that person sometimes have in response to stressful life experiences. Please read each one carefully, choose the answer that fits you mostly to indicate how much you have been bothered by that problem in the last month',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/Adult_ADHD_Self_ReportScale');
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: AppColors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Adult ADHD Self-Report Scale",
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20), // Adjust as needed
                                Flexible(
                                  child: Text(
                                    'Referrals: \nEvery 2 weeks',
                                    style: TextStyle(color: Color(0XFF50555C)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ExpandableText(
                              'Attention deficit hyperactivity disorder (ADHD) in adults is a mental health related disorder and includes a set of persistent problems, such as difficulty in attention, hyperactivity, and impulsive behavior. Attention deficit disorder with hyperactivity in adults may lead to unstable relationships, poor work or school performance, decreased self-confidence, and other problems.',
                              style: TextStyle(color: Color(0XFF979797)),
                              maxLines: 3,
                              expandText: 'Read more',
                              collapseText: 'Read less',
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text('Test Duration:- 1:30 Mins'),
                                  ),
                                  SizedBox(width: 20), // Adjust as needed
                                  Flexible(
                                    child: Text('Cost: Free'),
                                  )
                                ]),
                          ])),
                )),
          ],
        ),
        SizedBox(height: 100),
      ]),
    );
  }
}
