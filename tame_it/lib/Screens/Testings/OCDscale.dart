import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Testings/question.dart';
// import 'package:tame_it/Screens/Testings/result.dart';

import '../../values/values.dart';

class OCDScale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OCDScaleState();
  }
}

class _OCDScaleState extends State<OCDScale> {
  final _questions = const [
    {
      'questionText':
          'How much of your time is occupied by obsessive thoughts?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Less than 1 hour per day', 'score': 1},
        {'text': '1-3 hours per day', 'score': 2},
        {'text': '3-8 hours per day', 'score': 3},
        {'text': 'More than 8 hours per day', 'score': 4},
      ],
    },
    {
      'questionText':
          'How much do your obsessive thoughts interfere with functioning in your social, work, or other roles?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Slight interference, but no impairment', 'score': 1},
        {'text': 'Definite interference, but manageable', 'score': 2},
        {'text': 'Substantial interference', 'score': 3},
        {'text': 'Extreme interference, incapacitating', 'score': 4},
      ],
    },
    {
      'questionText': 'How much distress do your obsessive thoughts cause you?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Mild, not too disturbing', 'score': 1},
        {'text': 'Moderate, disturbing, but still manageable', 'score': 2},
        {'text': 'Severe, very disturbing', 'score': 3},
        {'text': 'Extreme, near constant and disabling distress', 'score': 4},
      ],
    },
    {
      'questionText':
          'How much of an effort do you make to resist the obsessive thoughts?',
      'answers': [
        {'text': 'Always resist', 'score': 0},
        {'text': 'Resist most of the time', 'score': 1},
        {'text': 'Make some effort to resist', 'score': 2},
        {'text': 'Reluctantly yield to all obsessive thoughts', 'score': 3},
        {
          'text': 'Completely and willingly yield to all obsessions',
          'score': 4
        },
      ],
    },
    {
      'questionText':
          'How much control do you have over your obsessive thoughts?',
      'answers': [
        {'text': 'Complete control', 'score': 0},
        {
          'text':
              'Much control, usually able to stop or divert obsessions with some effort and concentration',
          'score': 1
        },
        {
          'text':
              'Moderate control, sometimes able to stop or divert obsessions',
          'score': 2
        },
        {
          'text':
              'Little control, rarely successful in stopping or dismissing obsessions',
          'score': 3
        },
        {
          'text':
              'No control, rarely able to even momentarily alter obsessive thinking',
          'score': 4
        },
      ],
    },
    {
      'questionText':
          'How much time do you spend performing compulsive behaviors?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Less than 1 hour per day', 'score': 1},
        {'text': '1-3 hours per day', 'score': 2},
        {'text': '3-8 hours per day', 'score': 3},
        {'text': 'More than 8 hours per day', 'score': 4},
      ],
    },
    {
      'questionText':
          'How much do your compulsive behaviors interfere with functioning in your social, work, or other roles?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Slight interference, but no impairment', 'score': 1},
        {'text': 'Definite interference, but manageable', 'score': 2},
        {'text': 'Substantial interference', 'score': 3},
        {'text': 'Extreme interference, incapacitating', 'score': 4},
      ],
    },
    {
      'questionText':
          'How anxious would you become if you were prevented from performing your compulsive behaviors?',
      'answers': [
        {'text': 'None', 'score': 0},
        {'text': 'Only slightly anxious', 'score': 1},
        {'text': 'Some anxiety, but manageable', 'score': 2},
        {'text': 'Prominent and disturbing anxiety', 'score': 3},
        {'text': 'Extreme, incapacitating anxiety', 'score': 4},
      ],
    },
    {
      'questionText':
          'How much of an effort do you make to resist the compulsions?',
      'answers': [
        {'text': 'Always resist', 'score': 0},
        {'text': 'Try to resist most of the time', 'score': 1},
        {'text': 'Make some effort to resist', 'score': 2},
        {'text': 'Reluctantly yield to all compulsions', 'score': 3},
        {
          'text': 'Completely and willingly yield to all obsessions',
          'score': 4
        },
      ],
    },
    {
      'questionText': 'How much control do you have over the compulsions?',
      'answers': [
        {'text': 'Complete control', 'score': 0},
        {
          'text':
              'Much control, usually able to stop or divert obsessions with some effort and concentration',
          'score': 1
        },
        {
          'text':
              'Moderate control, sometimes able to stop or divert obsessions',
          'score': 2
        },
        {
          'text':
              'Little control, rarely successful in stopping or dismissing obsessions',
          'score': 3
        },
        {
          'text':
              'No control, rarely able to even momentarily alter obsessive thinking',
          'score': 4
        },
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
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_totalScore, _resetQuiz),
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
          'Your results indicate that you have none, or very few signs of depression. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 9) {
      resultText =
          'Your results indicate that you may be experiencing mild depression. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 14) {
      resultText =
          'Your results indicate that you are experiencing moderate depression. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 19) {
      resultText =
          'Your results indicate that you may be experiencing severe depression. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else {
      resultText =
          'Your results indicate that you may be at risk for major depression. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
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
                  style: TextStyle(fontSize: 18, color: AppColors.white),
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
