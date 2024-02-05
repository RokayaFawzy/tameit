import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../values/values.dart';
import '../widgets/custom_painters.dart';

class Profile extends StatefulWidget {
  // Profile({required this.themeBloc});

  // final ThemeBloc themeBloc;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    // widget.themeBloc.selectedTheme.add(_buildLightTheme());
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteShade2,
      body: DefaultTabController(
        length: 2,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              drawCircles(),
              ListView(
                children: <Widget>[
                   Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  iconSize: 29,
                  color: AppColors.black,
                  icon: Icon(FeatherIcons.arrowLeft),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Home');
                  },
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
                  SizedBox(
                    height: (heightOfScreen * -0.05) + (widthOfScreen * 0.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: widthOfScreen * 0.1,
                      right: widthOfScreen * 0.3,
                    ),
                  ),
                  SizedBox(
                    height: (heightOfScreen * 0.07),
                  ),
                  SizedBox(
                    height: 600,
                    child: _buildProfile(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawCircles() {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.5, heightOfScreen * -0.1),
            radius: widthOfScreen * 0.7,
            color: const Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
            // shadowColor: AppColors.deepsea1,
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
                 
            ],
          ),
        ],
      ),
    );
  }
}
