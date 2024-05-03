import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Testings/question.dart';
import '../../values/values.dart';

class PTSD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PTSDState();
  }
}

class _PTSDState extends State<PTSD> {
  final _questions = const [
    {
      'questionText':
          'Repeated, disturbing memories, thoughts, or images of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Repeated, disturbing dreams of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Suddenly acting or feeling as if a stressful experience were happening again (as if you were reliving it)?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Feeling very upset when something reminded you of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Having physical reactions (e.g., heart pounding, trouble breathing, or sweating) when something reminded you of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Avoid thinking about or talking about a stressful experience from the past or avoid having feelings related to it?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Avoid activities or situations because they remind you of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Trouble remembering important parts of a stressful experience from the past?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Loss of interest in things that you used to enjoy?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Feeling distant or cut off from other people?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText':
          'Feeling emotionally numb or being unable to have  loving feelings for those close to you?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Feeling as if your future will somehow be cut short?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Trouble falling or staying asleep? ',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Feeling irritable or having angry outbursts?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Having difficulty concentrating?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Being “super alert” or watchful on guard?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
      ],
    },
    {
      'questionText': 'Feeling jumpy or easily startled?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'A little bit', 'score': 1},
        {'text': 'Moderately', 'score': 2},
        {'text': 'Quite a bit', 'score': 3},
        {'text': 'Extremely', 'score': 4},
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
          'Your results indicate that you have none, or very few signs of PTSD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 9) {
      resultText =
          'Your results indicate that you may be experiencing mild PTSD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 14) {
      resultText =
          'Your results indicate that you are experiencing moderate PTSD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 19) {
      resultText =
          'Your results indicate that you may be experiencing severe PTSD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else {
      resultText =
          'Your results indicate that you may be at risk for major PTSD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
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
