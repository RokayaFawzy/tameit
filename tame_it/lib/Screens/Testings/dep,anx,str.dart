import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Testings/question.dart';
// import 'package:tame_it/Screens/Testings/result.dart';

import '../../values/values.dart';

class Dep_Anx_Str extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dep_Anx_StrState();
  }
}

class _Dep_Anx_StrState extends State<Dep_Anx_Str> {
  final _questions = const [
    {
      'questionText': 'I found it hard to wind down',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText': 'I was aware of dryness in my mouth',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I couldn’t seem to experience any positive feeling at all',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText': 'I experienced breathing difficulty (e.g. excessively rapid breathing, breathlessness in the absence of physical exertion)',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText': 'I found it difficult to work up the initiative to do things',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I tended to over-react to situations',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I experienced trembling (e.g. in the hands)',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt that I was using a lot of nervous energy',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I was worried about situations in which I might panic and make a fool of myself',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt that I had nothing to look forward to',
     'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I found myself getting agitated',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I found it difficult to relax',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt down-hearted and blue',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I was intolerant of anything that kept me from getting on with what I was doing',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt I was close to panic',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I was unable to become enthusiastic about anything',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt I wasn’t worth much as a person',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt that I was rather touchy',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I was aware of the action of my heart in the absence of physical exertion (e.g. sense of heart rate increase, heart missing a beat)',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt scared without any good reason',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt that life was meaningless',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt I wasn’t worth much as a person',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
      ],
    },
    {
      'questionText':
          'I felt I wasn’t worth much as a person',
      'answers': [
        {'text': 'Did not apply to me at all', 'score': 0},
        {'text': 'Applied to me to some degree, or some of the time', 'score': 1},
        {'text': 'Applied to me to a considerable degree or a good part of time', 'score': 2},
        {'text': 'Applied to me very much or most of the time', 'score': 3},
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
                _questionIndex < _questions.length
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
