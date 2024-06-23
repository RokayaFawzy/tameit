import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tame_it/values/values.dart';

class Successpage extends StatelessWidget {
  const Successpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Lottie.asset("assets/images/Animation - 1719091544248.json", width: 200),
        ])));
  }
}
