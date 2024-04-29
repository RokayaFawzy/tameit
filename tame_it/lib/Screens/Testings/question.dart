import 'package:flutter/material.dart';

import '../../values/values.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
              child: Text(
            questionText,
            style: const TextStyle(
                fontSize: 23,
                color: AppColors.deepsea,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            softWrap: true,
          )))
    ]);
  }
}

class AnswerButton extends StatelessWidget {
  final String answerText;
  final VoidCallback onPressed;

  AnswerButton(this.answerText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)))),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(answerText,
                  style:
                      TextStyle(fontSize: 20, color: AppColors.blackShade10)),
            ),
          ))
    ]);
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return 
    ListView(
      children: [
        Container(
            padding: EdgeInsets.only(top: 16.0, left: 16.0),
            color: AppColors.Bermuda,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Depression, Anxiety and stress scale',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF50555C)
                        color: AppColors.Bermuda
                        )),
              ),
              SizedBox(height: 10),
              Column(children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        color: AppColors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                      child: Text("INSTRUCTIONS",
                                          style: TextStyle(
                                            color: AppColors.deepsea,
                                            fontWeight: FontWeight.w500,
                                          )))
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Please read the scale items and choose the best answer that fits during the last 2 weeks. There are no right or wrong answers, and you do not need to spend too much time answering any of them.',
                                style: TextStyle(
                                    color: AppColors.blackShade9,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 15)
                            ]))),
                SizedBox(height: 40),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        color: AppColors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text("DISCLAIMER",
                                          style: TextStyle(
                                            color: AppColors.red,
                                            fontWeight: FontWeight.w500,
                                          )))
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'This assessment does not indicate a confirmed diagnosis. To determine any potential diagnosis, discuss your results with your therapist. Your results will be shown to you only.',
                                style: TextStyle(
                                    color: AppColors.blackShade9,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 15),
                            ]))),
              ]),
              SizedBox(height: 50)
            ])),
        SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blackShade10)),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 22, bottom: 10),
                      child: Text(
                          'Please read the test sentences and choose the best answer that fits you during the last 2 weeks',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: AppColors.blackShade10))),
                  SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              top: BorderSide(color: AppColors.blackShade10))),
                      padding: EdgeInsets.only(top: 18),
                      // color: AppColors.Tenne,
                      child:
                       Column(children: [
                        Question(
                          questions[questionIndex]['questionText'] as String,
                        ),
                        SizedBox(height: 10),
                        ...((questions[questionIndex]['answers']
                                as List<Map<String, Object>>)
                            .map((answer) {
                          return AnswerButton(
                            answer['text'] as String,
                            () => answerQuestion(answer['score'] as int),
                          );
                        }).toList()),
                        SizedBox(height: 80)
                      ]
                      ))
                ]))),
        SizedBox(height: 80)
      ],
    );
  }
}
