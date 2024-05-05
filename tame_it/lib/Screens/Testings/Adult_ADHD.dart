import 'package:flutter/material.dart';
import 'package:tame_it/Screens/Testings/question.dart';
import '../../values/values.dart';

class Adult_ADHD_Self_Report_Scale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Adult_ADHD_Self_Report_ScaleState();
  }
}

class _Adult_ADHD_Self_Report_ScaleState extends State<Adult_ADHD_Self_Report_Scale> {
  final _questions = const [
    {
      'questionText':
          'How often do you make careless mistakes when you have to work on a boring or difficult project?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you have difficulty keeping your attention when you are doing boring or repetitive work?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you have difficulty concentrating on what people say to you, even when they are speaking to you directly?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you have trouble wrapping up the final details of a project, once the challenging parts have been done?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you have difficulty getting things in order when you have to do a task that requires organization?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'When you have a task that requires a lot of thought, how often do you avoid or delay getting started?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you misplace or have difficulty finding things at home or at work?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often are you distracted by activity or noise around you?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you have problems remembering appointments or obligations?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you fidget or squirm with your hands or feet when you have to sit down for a long time?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText':
          'How often do you leave your seat in meetings or other situations in which you are expected to remain seated?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you feel restless or fidgety?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you have difficulty unwinding and relaxing when you have time to yourself?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you feel overly active and compelled to do things, like you were driven by a motor?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you find yourself talking too much when you are in social situations?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'When you’re in a conversation, how often do you find yourself finishing the sentences of the people you are talking to, before they can finish them themselves?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
    {
      'questionText': 'How often do you have difficulty waiting your turn in situations when turn taking is required?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
      ],
    },
     {
      'questionText': 'How often do you interrupt others when they are busy?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Very often', 'score': 4},
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
          'Your results indicate that you have none, or very few signs of ADHD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 9) {
      resultText =
          'Your results indicate that you may be experiencing mild ADHD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 14) {
      resultText =
          'Your results indicate that you are experiencing moderate ADHD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else if (resultScore <= 19) {
      resultText =
          'Your results indicate that you may be experiencing severe ADHD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
    } else {
      resultText =
          'Your results indicate that you may be at risk for major ADHD. \n\n\nThese results are not meant to be a diagnosis. You can meet with a doctor or therapist to get a diagnosis and/or access therapy or medications. Sharing these results with someone you trust can be a great place to start.';
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
