import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../values/values.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_painters.dart';
import '../widgets/custom_text_form_field.dart';

class Login extends StatefulWidget {
  // Login({required this.themeBloc});

  // final ThemeBloc themeBloc;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    // widget.themeBloc.selectedTheme.add(_buildLightTheme());
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

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
                    child: _buildLoginForm(),
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
            offset: Offset(widthOfScreen * 0.60, heightOfScreen * -0.05),
            radius: widthOfScreen * 0.35,
            color: const Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.94, heightOfScreen * 0.04),
            radius: widthOfScreen * 0.4,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.1, heightOfScreen * 0.95),
            radius: widthOfScreen * 0.170,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.33, heightOfScreen * 0.91),
            radius: widthOfScreen * 0.05,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: Sizes.TEXT_SIZE_30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "   We're Glad You're Here.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                textInputType: TextInputType.text,
                hasTitle: false,
                hasPrefixIcon: true,
                prefixIcon: const Icon(
                  FeatherIcons.mail,
                  color: AppColors.greyShade7,
                  size: Sizes.ICON_SIZE_20,
                ),
                hintTextStyle: Styles.customTextStyle(
                  fontSize: Sizes.TEXT_SIZE_20,
                  color: AppColors.greyShade7,
                ),
                enabledBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                textStyle: Styles.customTextStyle(
                  fontSize: Sizes.TEXT_SIZE_20,
                  color: AppColors.blackShade10,
                ),
                hintText: 'Email',
              ),
              const SizedBox(
                height: 12.0,
              ),
              CustomTextFormField(
                obscured: true,
                textInputType: TextInputType.text,
                hasTitle: false,
                hasPrefixIcon: true,
                prefixIcon: const Icon(
                  FeatherIcons.lock,
                  color: AppColors.greyShade7,
                  size: Sizes.ICON_SIZE_20,
                ),
                hasSuffixIcon: true,
                suffixIcon: const Icon(
                  FeatherIcons.eyeOff,
                  color: AppColors.deepsea,
                ),
                hintTextStyle: Styles.customTextStyle(
                  fontSize: Sizes.TEXT_SIZE_20,
                  color: AppColors.greyShade7,
                ),
                enabledBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                textStyle: Styles.customTextStyle(
                  fontSize: Sizes.TEXT_SIZE_20,
                  color: AppColors.blackShade10,
                ),
                hintText: 'Password',
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Remember me ',
                      style: TextStyle(
                        color: AppColors.blueHorizon,
                      ),
                    ),
                  ),
                  const Icon(
                    FeatherIcons.square,
                    size: Checkbox.width,
                    color: Color.fromARGB(255, 86, 107, 126),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: widthOfScreen * 0.3),
                    child: const InkWell(
                      // onTap:() => ,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.deepsea),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 70.0,
              ),
              SizedBox(
                width: widthOfScreen * 0.6,
                child: CustomButton(
                  title: 'Login',
                  color: AppColors.deepsea,
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: SelectableText.rich(
                  TextSpan(
                    text: 'Not Registered Yet?',
                    style: const TextStyle(
                      color: AppColors.greyShade8,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.TEXT_SIZE_18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign Up',
                          style: const TextStyle(color: AppColors.deepsea),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.of(context).pushNamed('/SignUp'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
