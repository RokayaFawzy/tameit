import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/beging_screens/intro_Page/intro_page1.dart';
import 'package:tame_it/Screens/beging_screens/intro_Page/intro_page3.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

import 'intro_Page/intro_page2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntPage1(),
              IntPage2(),
              IntPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: JumpingDotEffect(
                    jumpScale: 0.2,
                    verticalOffset: 0.1,
                    dotWidth: 25,
                    dotHeight: 3)),
          ),
          onLastPage
              ? Align(
                  alignment: Alignment(0, 0.8),
                  child: Container(
                    width: 250,
                    height: 46,
                    child: CustomButton(
                      title: 'Get Started',
                      color: AppColors.deepsea,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment(0, 0.8),
                  child: Container(
                    width: 250,
                    height: 46,
                    child: CustomButton(
                      title: 'Next',
                      color: AppColors.deepsea,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
