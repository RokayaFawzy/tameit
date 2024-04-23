import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/values/values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Colors.black,
              // Colors.white
              AppColors.Sidecar,
              AppColors.Sidecar,

              AppColors.seaBlue3,
              AppColors.whiteShade3,
              // AppColors.Sidecar,
              // AppColors.seaBlue3,
              // AppColors.twitterBlue,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Align(
          alignment: const Alignment(0.03, -0.38),
          child: Container(
            alignment: Alignment(0.03, -0.38),
            child: Image.asset(
              "assets/images/image.png",
              width: 600, // Adjust the width as needed
              height: 600, // Adjust the height as needed
            ),
          ),
        ),
      ),
    );
  }
}
