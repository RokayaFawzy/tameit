import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Testings/question.dart';
// import 'package:tame_it/Screens/Testings/result.dart';
import '../../values/values.dart';

class AnxietyScale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnxietyScaleState();
  }
}

class _AnxietyScaleState extends State<AnxietyScale> {
  final _questions = const [
    {
      'questionText': 'Feeling nervous, anxious, or on edge',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Not being able to stop or control worrying',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Worrying too much about different things',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Trouble relaxing',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Being so restless that it’s hard to sit still',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Becoming easily annoyed or irritable',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Feeling afraid as if something awful might happen',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print("Total score: $_totalScore");
    } else {
      print('No more questions!');
      print("Total score: $_totalScore");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          title: const Text('Psychometer',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: 
        // ListView(children: [
        //   Container(
        //       padding: EdgeInsets.only(top: 16.0, left: 16.0),
        //       color: AppColors.Bermuda,
        //       child:
        //           Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        //         Align(
        //           alignment: Alignment.center,
        //           child: Text('Anxiety scale',
        //               style: TextStyle(
        //                   fontSize: 30,
        //                   fontWeight: FontWeight.bold,
        //                   color: AppColors.white)),
        //         ),
        //         SizedBox(height: 10),
        //         Column(children: [
        //           Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 16.0, right: 16.0, top: 8),
        //               child: Container(
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        //                   color: AppColors.white,
        //                   child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Row(
        //                           children: [
        //                             Flexible(
        //                                 child: Text("INSTRUCTIONS",
        //                                     style: TextStyle(
        //                                       color: AppColors.deepsea,
        //                                       fontWeight: FontWeight.w500,
        //                                     )))
        //                           ],
        //                         ),
        //                         SizedBox(height: 10),
        //                         Text(
        //                           'Please read the scale items and choose the best answer that fits during the last 2 weeks. There are no right or wrong answers, and you do not need to spend too much time answering any of them.',
        //                           style: TextStyle(
        //                               color: AppColors.blackShade9,
        //                               fontSize: 17,
        //                               fontWeight: FontWeight.w400),
        //                         ),
        //                         SizedBox(height: 15)
        //                       ]))),
        //           SizedBox(height: 40),
        //           Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 16.0, right: 16.0, top: 8),
        //               child: Container(
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        //                   color: AppColors.white,
        //                   child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Flexible(
        //                                 child: Text("DISCLAIMER",
        //                                     style: TextStyle(
        //                                       color: AppColors.red,
        //                                       fontWeight: FontWeight.w500,
        //                                     )))
        //                           ],
        //                         ),
        //                         SizedBox(height: 10),
        //                         Text(
        //                           'This assessment does not indicate a confirmed diagnosis. To determine any potential diagnosis, discuss your results with your therapist. Your results will be shown to you only.',
        //                           style: TextStyle(
        //                               color: AppColors.blackShade9,
        //                               fontSize: 17,
        //                               fontWeight: FontWeight.w400),
        //                         ),
        //                         SizedBox(height: 15),
        //                       ]))),
        //         ]),
        //         SizedBox(height: 50)
        //       ])),
        //   SizedBox(height: 20),
        //   Padding(
        //       padding: const EdgeInsets.all(15),
        //       child: Container(
        //           decoration: BoxDecoration(
        //               border: Border.all(color: AppColors.blackShade10)),
        //           child: Column(children: [
        //             Padding(
        //                 padding: const EdgeInsets.only(
        //                     left: 16.0, right: 16.0, top: 22, bottom: 10),
        //                 child: Text(
        //                     'Please read the test sentences and choose the best answer that fits you during the last 2 weeks',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.w500,
        //                         fontSize: 25,
        //                         color: AppColors.blackShade10))),
        //             SizedBox(height: 20),
        //             Container(
        //               decoration: BoxDecoration(
        //                   border: BorderDirectional(
        //                       top: BorderSide(color: AppColors.blackShade10))),
        //               padding: EdgeInsets.only(top: 18),
                      // color: AppColors.Tenne,
                      // child:
                      //  Column(children: [
                        _questionIndex < _questions.length
                            ? Quiz(
                                answerQuestion: _answerQuestion,
                                questionIndex: _questionIndex,
                                questions: _questions,
                              )
                            : Result(_totalScore, _resetQuiz),
                      // ]
                      // ),
                    // ),
                    // SizedBox(height: 80)
                  // ]))),
        // ])
        );
  }
}




class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 4) {
      resultText =
          'Your results indicate that you have none, or very few signs of Anxiety. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 9) {
      resultText =
          'Your results indicate that you may be experiencing mild Anxiety. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 14) {
      resultText =
          'Your results indicate that you are experiencing moderate Anxiety. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 19) {
      resultText =
          'Your results indicate that you may be experiencing severe Anxiety. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else {
      resultText =
          'Your results indicate that you may be at risk for major Anxiety. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30),
      child: Column(children: <Widget>[
        Flex(direction: Axis.vertical, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      resultPhrase,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ]))
        ]),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
                child: Text(
                  'Restart Quiz',
                  style: TextStyle(fontSize: 18,color: AppColors.white),
                ),
                onPressed: resetHandler,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepsea,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))))
      ]),
    );
  }
}


