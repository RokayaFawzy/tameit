import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

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
