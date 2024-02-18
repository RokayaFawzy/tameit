import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      body: DefaultTabController(
        length: 2,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: widthOfScreen * 0.1,
                      right: widthOfScreen * 0.3,
                    ),
                  ),
                  SizedBox(
                    height: (heightOfScreen * 0.07),
                  ),
                  Container(
                    height: heightOfScreen,
                    child: _buildResetPassForm(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetPassForm() {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  iconSize: 29,
                  color: AppColors.deepsea,
                  icon: Icon(FeatherIcons.arrowLeft),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/CodePhone');
                  },
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Sizes.HEIGHT_14,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   Enter a new password",
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: Sizes.TEXT_SIZE_20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: Sizes.HEIGHT_50,
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              decoration: InputDecoration(
                  // contentPadding:EdgeInsets.only(left: 25),
                  hintText: ' New password',
                  hintStyle: Styles.customTextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  suffixIcon: const Icon(
                    FeatherIcons.eyeOff,
                    size: Sizes.ICON_SIZE_22,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  enabled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sizes.RADIUS_14)),
                      borderSide: BorderSide(
                          color: AppColors.grey,
                          width: Sizes.WIDTH_1,
                          style: BorderStyle.solid)),
                  filled: true,
                  fillColor: Color.fromARGB(94, 200, 201, 205)),
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: Sizes.HEIGHT_50,
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              decoration: InputDecoration(
                  // contentPadding:EdgeInsets.only(left: 25),
                  hintText: ' Confirm password',
                  hintStyle: Styles.customTextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  suffixIcon: const Icon(
                    FeatherIcons.eyeOff,
                    size: Sizes.ICON_SIZE_22,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  enabled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sizes.RADIUS_14)),
                      borderSide: BorderSide(
                          color: AppColors.grey,
                          width: Sizes.WIDTH_1,
                          style: BorderStyle.solid)),
                  filled: true,
                  fillColor: Color.fromARGB(94, 200, 201, 205)),
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            width: widthOfScreen * 0.6,
            child: CustomButton(
              title: 'Change Password',
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
            height: Sizes.HEIGHT_25,
          ),
        ],
      ),
    );
  }
}
