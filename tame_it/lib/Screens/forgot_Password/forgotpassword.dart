import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tame_it/Screens/forgot_Password/verification_code.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.deepsea),
          backgroundColor: AppColors.whiteShade3),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter Your Email",
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontSize: Sizes.TEXT_SIZE_24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter the email address to get link reset Your password",
                style: TextStyle(
                  color: AppColors.Bermuda,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: Sizes.HEIGHT_50,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                ),
                decoration: InputDecoration(
                    // contentPadding:EdgeInsets.only(left: 25),
                    hintText: 'Email Address',
                    hintStyle: Styles.customTextStyle(
                      fontSize: Sizes.TEXT_SIZE_14,
                      color: AppColors.greyShade7,
                    ),
                    suffixIcon: const Icon(
                      FeatherIcons.mail,
                      size: Sizes.ICON_SIZE_22,
                      color: AppColors.greyShade7,
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
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            const Text(
              'code will send to your email',
              style: TextStyle(
                  color: AppColors.blackShade3, fontWeight: FontWeight.bold),
            ),
            const Text(
              'example@gmail.com',
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            const SelectableText.rich(TextSpan(
                text: 'This code expires in ',
                style: TextStyle(
                  color: AppColors.greyShade8,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '5 minutes',
                    style: TextStyle(color: AppColors.black),
                  )
                ])),
            SizedBox(
              height: 35,
            ),
            Container(
              width: widthOfScreen * 0.6,
              child: CustomButton(
                title: 'Next',
                color: AppColors.deepsea,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CodePhone(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Sizes.HEIGHT_25,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/Verify_Phone_Number');
              },
              child: Text(
                'Use phone number to reset password',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.deepsea),
              ),
            )
          ],
        ),
      ),
    );
  }
}
