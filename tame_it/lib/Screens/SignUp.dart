import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../values/values.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_painters.dart';
import '../widgets/custom_text_form_field.dart';

class SignUp extends StatefulWidget {
  // SignUp({required this.themeBloc});

  // final ThemeBloc themeBloc;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    height: (heightOfScreen * -0.12) + (widthOfScreen * 0.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: widthOfScreen * 0.1,
                      right: widthOfScreen * 0.3,
                    ),
                  ),
                  SizedBox(
                    height: (heightOfScreen * 0.09),
                  ),
                  SizedBox(
                    height: 600,
                    child: _buildRegiserForm(),
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
            offset: Offset(widthOfScreen * 0.50, heightOfScreen * -0.05),
            radius: widthOfScreen * 0.35,
            color: Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.14, heightOfScreen * 0.04),
            radius: widthOfScreen * 0.4,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.9, heightOfScreen * 0.95),
            radius: widthOfScreen * 0.170,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.66, heightOfScreen * 0.91),
            radius: widthOfScreen * 0.05,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
      ],
    );
  }

  Widget _buildRegiserForm() {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: Sizes.TEXT_SIZE_30,
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
              SizedBox(
                height: 12.0,
              ),
              CustomTextFormField(
                textInputType: TextInputType.name,
                hasTitle: false,
                hasPrefixIcon: true,
                prefixIcon: const Icon(
                  FeatherIcons.user,
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
                hintText: 'Username',
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                textInputType: TextInputType.text,
                obscured: true,
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
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                textInputType: TextInputType.text,
                obscured: true,
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
                hintText: 'Confirm Password',
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: widthOfScreen * 0.6,
                child: CustomButton(
                  title: 'Register',
                  color: AppColors.deepsea,
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: SelectableText.rich(TextSpan(
                      text: 'Already Have An Account?',
                      style: TextStyle(
                        color: AppColors.greyShade8,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.TEXT_SIZE_18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign In',
                            style: TextStyle(color: AppColors.deepsea),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.of(context).pushNamed('/Login'))
                      ])))
            ],
          ),
        ],
      ),
    );
  }
}
